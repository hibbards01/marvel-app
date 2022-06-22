//
//  MarvelDataSource.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Foundation
import Alamofire
import CryptoKit
import Combine

/// A data source to provide data from the Marvel API.
protocol DataSource {
    /// The model to use for the request.
    associatedtype ModelType
    
    /// The data publisher to send the results to the subcriber.
    var data: AnyPublisher<Result<[ModelType], AFError>, Never> { get }
    
    /// Initalizer.
    /// - Parameters:
    ///   - api: The ``MarvelAPIService`` to use for the ``DataSource``
    ///   - sessionContainer: The session to make the requests on.
    ///   - settings: The settings of the APP.
    init(api: MarvelAPIService,
         sessionContainer: SessionContainer,
         settings: Settings)
    
    /// Request on the service with parameters.
    /// - Parameters:
    ///   - id: The ID to add to the path of the ``MarvelAPIService``.
    ///   - parameters: The GET parameters to addtionally send.
    func request(id: Int?, with parameters: [String: String])
}

/// The data source to grab the results from the Marvel API.
struct MarvelDataSource<Model: MarvelModel>: DataSource {
    var data: AnyPublisher<Result<[Model], AFError>, Never>
    private let api: MarvelAPIService
    private let sessionContainer: SessionContainer
    private let settings: Settings
    private let subject = PassthroughSubject<Result<[Model], AFError>, Never>()
    
    init(api: MarvelAPIService,
         sessionContainer: SessionContainer,
         settings: Settings) {
        self.api = api
        self.sessionContainer = sessionContainer
        self.settings = settings
        self.data = subject.eraseToAnyPublisher()
    }
    
    func request(id: Int? = nil, with parameters: [String: String] = [:]) {
        Task {
            let result = await sendRequest(id: id, parameters: parameters)
            
            // Check the result and see if everything passed.
            switch result {
            case .success(let response):
                // Grab the actually results from the response.
                let results = response.data.results
                subject.send(.success(results))
            case .failure(let error):
                subject.send(.failure(error))
            }
        }
    }
    
    /// Grab the data from the provided ``MarvelAPIService``.
    /// - Parameter parameters: The GET parameters to add onto the request.
    /// - Returns: Returns the data.
    private func sendRequest(id: Int?, parameters: [String: String]) async -> Result<ResponseContainer<Model>, AFError> {
        var newParameters = parameters
        append(parameters: &newParameters)
        return await sessionContainer.getData(url: api.url(id: id), parameters: newParameters)
    }
    
    /// Appends more GET parameters needed to make the request.
    ///
    /// Adds these parameters;
    /// - ts: The timestamp.
    /// - hash: MD5 has created from the keys and timestamp.
    /// - apikey: The public API key.
    ///
    /// - Parameter parameters: The dict that holds the GET Parameters.
    private func append(parameters: inout [String: String]) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        let combined = timestamp + settings.privateKey + settings.publicKey
        let digest = Insecure.MD5.hash(data: combined.data(using: .utf8) ?? Data())
        let hash = digest.map {
            String(format: "%02hhx", $0)
        }.joined()
        
        parameters["ts"] = timestamp
        parameters["hash"] = hash
        parameters["apikey"] = settings.publicKey
    }
}
