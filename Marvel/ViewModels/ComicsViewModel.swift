//
//  ComicsViewModel.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Combine
import Foundation
import Alamofire

class ComicsViewModel: ObservableObject {
    typealias Response = ResponseContainer<ComicModel>
    
    init() {
        getComics()
    }
    
    private func getComics() {
        Task {
            let settingsViewModel = SettingsViewModel()
            let dataSource = MarvelDataSource(api: .comics(nil))
            let result: Result<Response, AFError> = await dataSource.getData(publicKey: settingsViewModel.publicKey,
                                                                             privateKey: settingsViewModel.privateKey,
                                                                             parameters: ["limit": "50"])
            
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
