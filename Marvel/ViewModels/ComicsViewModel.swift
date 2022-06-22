//
//  ComicsViewModel.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Combine
import Foundation
import Alamofire
import UIKit
import SwiftUI

class ComicsViewModel: ObservableObject {
    @Published var comic: ComicModel?
    @Published var image: Image?
    @Published var showError: String? = nil
    var searchText: String = "" {
        didSet {
            if let id = Int(searchText) {
                dataSource.request(id: id)
                image = nil
                showError = nil
            } else if !searchText.isEmpty {
                showError = "Please enter a number value."
            }
        }
    }
    
    private let dataSource: MarvelDataSource<ComicModel>
    private let sessionContainer: SessionContainer
    
    init(dataSource: MarvelDataSource<ComicModel>, sessionContainer: SessionContainer) {
        self.dataSource = dataSource
        self.sessionContainer = sessionContainer
        setupSubscription()
    }
    
    private func setupSubscription() {
        dataSource.data
            .receive(on: RunLoop.main)
            .map { [weak self] result -> ComicModel? in
                switch result {
                case .success(let comics):
                    self?.showError = nil
                    let first = comics.first
                    self?.grabImage(thumbnail: first?.thumbnail)
                    return first
                case .failure(let error):
                    self?.showError = error.localizedDescription
                    return nil
                }
            }
            .assign(to: &$comic)
    }
    
    private func grabImage(thumbnail: MImage?) {
        if let path = thumbnail?.urlPath() {
            Task {
                do {
                    let data = try await sessionContainer.getImage(path: path)
                    DispatchQueue.main.async {
                        self.image = Image(uiImage: UIImage(data: data) ?? UIImage())
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}
