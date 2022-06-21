//
//  MarvelDataSource.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Foundation
import Alamofire
import CryptoKit

enum MarvelAPI {
    case comics(Int?)
    
    func url() -> String {
        var urlString = "https://gateway.marvel.com/v1/public/"
        switch self {
        case .comics(let id):
            urlString += "comics"
            
            if let id {
                urlString += "/\(id)"
            }
        }
        
        return urlString
    }
}

struct MarvelDataSource {
    let api: MarvelAPI
    
    init(api: MarvelAPI) {
        self.api = api
    }
    
    func getData<Model: Decodable>(publicKey: String,
                                   privateKey: String,
                                   parameters: [String: String]) async -> Result<ResponseContainer<Model>, AFError> {
        var newParameters = parameters
        append(parameters: &newParameters, publicKey: publicKey, privateKey: privateKey)
        let dataTask = AF.request(api.url(), method: .get, parameters: newParameters)
            .serializingDecodable(ResponseContainer<Model>.self)
        return await dataTask.result
    }
    
    private func append(parameters: inout [String: String], publicKey: String, privateKey: String) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        let combined = timestamp + privateKey + publicKey
        let digest = Insecure.MD5.hash(data: combined.data(using: .utf8) ?? Data())
        let hash = digest.map {
            String(format: "%02hhx", $0)
        }.joined()
        
        parameters["ts"] = timestamp
        parameters["hash"] = hash
        parameters["apikey"] = publicKey
    }
}
