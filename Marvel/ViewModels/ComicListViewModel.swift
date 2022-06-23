//
//  ComicListViewModel.swift
//  Marvel
//
//  Created by Hibbard Family on 6/22/22.
//

import Combine
import SwiftUI

struct GridRowData: Identifiable {
    let id: Int
    var row: [ComicView]
}

extension GridRowData: Equatable {
    static func == (lhs: GridRowData, rhs: GridRowData) -> Bool {
        lhs.id == rhs.id
    }
}

class ComicListViewModel: ObservableObject {
    @Published var gridViews = [GridRowData]()
    @Published var isLoading: Bool = false
    
//    private var comics = [ComicView]()
    private var offset: Int = 0
    private let limit: Int = 50
    private let dataSource: MarvelDataSource<ComicModel>
    private let sessionContainer: SessionContainer
    private var subscription: AnyCancellable?
    
    /// Creates a comic list view model.
    /// - Parameters:
    ///   - dataSource: The data source to grab the comic.
    ///   - sessionContainer: The session to grab the image.
    init(dataSource: MarvelDataSource<ComicModel>, sessionContainer: SessionContainer) {
        self.dataSource = dataSource
        self.sessionContainer = sessionContainer
        setupSubscription()
    }
    
    /// Fetch comics from the data source.
    func fetchComics() {
        isLoading = true
        dataSource.request(with: [
            "offset": String(offset),
            "limit": String(limit)
        ])
        
        // Increment the offset.
        offset += limit
    }
    
    private func setupSubscription() {
        subscription = dataSource.data.map { result in
            switch result {
            case .success(let data):
                return data
            case .failure(let error):
                print(error)
                return []
            }
        }
        .receive(on: RunLoop.main)
        .sink { [weak self] data in
            guard let self else { return }
            Task {
                do {
                    let views = try await self.createComicViews(data)
                    await self.appendToGrid(with: views)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    @MainActor
    private func appendToGrid(with views: [ComicView]) {
        var index = 0
        
        // Check if the last row needs more comics.
        if var last = gridViews.last,
           last.row.count < 3 {
            for i in 0 ..< 3 - last.row.count where i < views.count {
                last.row.append(views[i])
                index += 1
            }
            gridViews.removeLast()
            gridViews.append(last)
        }
        
        // Finally add the rest of the rows.
        var lastID = gridViews.count
        for r in stride(from: index, to: views.count, by: 3) {
            var comicRow = [ComicView]()
            for i in r ..< r + 3 where i < views.count {
                comicRow.append(views[i])
            }
            gridViews.append(GridRowData(id: lastID, row: comicRow))
            lastID += 1
        }
        
        self.isLoading = false
    }
    
    private func createComicViews(_ models: [ComicModel]) async throws -> [ComicView] {
        try await withThrowingTaskGroup(of: ComicView.self) { group -> [ComicView] in
            for model in models {
                group.addTask(priority: .background) { [weak self] in
                    var image: Image?
                    if let url = model.thumbnail?.urlPath(),
                       let data = try await self?.sessionContainer.getImage(path: url) {
                        image = Image(uiImage: UIImage(data: data) ?? UIImage())
                    }
                    
                    return ComicView(id: UUID(),
                                     title: model.title,
                                     desc: model.description,
                                     variantDesc: model.variantDescription,
                                     image: image,
                                     largeSize: false)
                }
            }
            
            var views = [ComicView]()
            for try await view in group {
                views.append(view)
            }
            
            return views
        }
    }
}
