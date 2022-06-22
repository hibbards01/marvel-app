//
//  MarvelAssembly.swift
//  Marvel
//
//  Created by Hibbard Family on 6/21/22.
//

import Swinject

class MarvelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Settings.self) { _ in
            SettingsViewModel()
        }
        
        container.register(SessionContainer.self) { _ in
            SessionContainerProvider()
        }
        
        container.register(MarvelDataSource<ComicModel>.self) { resolver in
            let settings = resolver.resolve(Settings.self)!
            let sessionContainer = resolver.resolve(SessionContainer.self)!
            return MarvelDataSource<ComicModel>(api: .comics, sessionContainer: sessionContainer, settings: settings)
        }
        
        container.register(ComicsViewModel.self) { resolver in
            let dataSource = resolver.resolve(MarvelDataSource<ComicModel>.self)!
            let sessionContainer = resolver.resolve(SessionContainer.self)!
            return ComicsViewModel(dataSource: dataSource, sessionContainer: sessionContainer)
        }
    }
}
