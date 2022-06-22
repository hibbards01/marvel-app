//
//  MockSessionContainer.swift
//  MarvelTests
//
//  Created by Hibbard Family on 6/21/22.
//

import Alamofire
import Foundation
import UIKit

/// ``ComicModel`` mocks.
let mockComicModels: [ComicModel] = [
    ComicModel(id: 1,
               title: "test",
               description: "description",
               variantDescription: "test variant",
               thumbnail: MImage(path: "path/to/file", fileType: ".jpg")),
    ComicModel(id: 2,
               title: "test",
               description: "description",
               variantDescription: "test variant",
               thumbnail: MImage(path: "path/to/file", fileType: ".jpg"))
]

/// ``DataContainer`` mock.
let mockDataContainer = DataContainer(offset: 0, limit: 50, total: 2, results: mockComicModels)
/// ``ResponseContainer`` mock.
let mockResponse = ResponseContainer(code: 200, status: "OK", copyright: "", data: mockDataContainer)

/// Mocks the session.
///
/// Mainly needed for Unit Tests and UI Tests.
class MockSessionContainer<Model: MarvelModel>: SessionContainer {
    /// Saves the result locally so it can be changed on the fly.
    var result: Result<ResponseContainer<Model>, AFError>!

    /// Makes the `result` a `.success` with the specified data provided.
    /// - Parameter response: The response to save to the `result`.
    func setSuccess(response: ResponseContainer<Model>) {
        result = .success(response)
    }

    /// Makes teh `result` a `.failure`.
    func setFailure() {
        result = .failure(AFError.explicitlyCancelled)
    }
    
    func getData<Model: MarvelModel>(url: String, parameters: [String : String]) async -> Result<ResponseContainer<Model>, AFError> {
        if let result = result as? Result<ResponseContainer<Model>, AFError> {
            return result
        } else {
            return .failure(AFError.explicitlyCancelled)
        }
    }
    
    func getImage(path: String) async throws -> Data {
        if let image = UIImage(named: "marvel-image") {
            return image.jpegData(compressionQuality: 0.9) ?? Data()
        }
        
        throw NSError(domain: "Invalid image name", code: 999)
    }
}
