//
//  MockSessionContainer.swift
//  MarvelTests
//
//  Created by Hibbard Family on 6/21/22.
//

import Alamofire
import Foundation
import UIKit

let mockComicModels: [ComicModel] = [
    ComicModel(id: 1,
               title: "test",
               description: "test desc",
               variantDescription: "test variant",
               thumbnail: MImage(path: "path/to/file", fileType: ".jpg")),
    ComicModel(id: 2,
               title: "test",
               description: "test desc",
               variantDescription: "test variant",
               thumbnail: MImage(path: "path/to/file", fileType: ".jpg"))
]

let mockDataContainer = DataContainer(offset: 0, limit: 50, total: 2, results: mockComicModels)
let mockResponse = ResponseContainer(code: 200, status: "OK", copyright: "", data: mockDataContainer)

class MockSessionContainer<Model: MarvelModel>: SessionContainer {
    var result: Result<ResponseContainer<Model>, AFError>!

    func setSuccess(response: ResponseContainer<Model>) {
        result = .success(response)
    }

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
