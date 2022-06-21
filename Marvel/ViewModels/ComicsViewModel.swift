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
    @Published var comic: ComicModel?
    private let dataSource: MarvelDataSource<ComicModel>
    
    init() {
        dataSource = MarvelResolver.resolver.resolve(MarvelDataSource<ComicModel>.self)!
        setupSubscription()
    }
    
    private func setupSubscription() {
        dataSource.data.map { result -> ComicModel? in
            switch result {
            case .success(let comics):
                print(comics)
                return comics.first
            case .failure(let error):
                print(error)
                return nil
            }
        }
        .receive(on: RunLoop.main)
        .assign(to: &$comic)
    }
}
