//
//  SessionContainer.swift
//  Marvel
//
//  Created by Hibbard Family on 6/21/22.
//

import Alamofire
import Foundation

/// The session to provide the data for.
///
/// Use this protocol to mock the Sessions for unit testing.
protocol SessionContainer {
    /// Grabs the data using `AF.request`.
    /// - Parameters:
    ///   - url: The URL string
    ///   - parameters: The GET parameters.
    /// - Returns: Returns the results as a `Result`,
    func getData<Model: MarvelModel>(url: String, parameters: [String: String]) async -> Result<ResponseContainer<Model>, AFError>
    
    /// Download the image.
    /// - Parameter path: The url path of the image.
    /// - Returns: Returns the Data image.
    func getImage(path: String) async throws -> Data
}

struct SessionContainerProvider: SessionContainer {
    func getData<Model: MarvelModel>(url: String,  parameters: [String: String]) async -> Result<ResponseContainer<Model>, AFError> {
        let dataTask = AF.request(url, method: .get, parameters: parameters)
            .serializingDecodable(ResponseContainer<Model>.self)
        let response = await dataTask.response
        
        // Check the response make sure everything went thru.
        if let statusCode = response.response?.statusCode,
           statusCode != 200 {
            return .failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: statusCode)))
        } else {
            return response.result
        }
    }
    
    func getImage(path: String) async throws -> Data {
        let dataTask = AF.request(path).serializingData()
        return try await dataTask.value
    }
}
