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
        }.inObjectScope(.container)
        
        container.register(MarvelDataSource<ComicModel>.self) { resolver in
            let settings = resolver.resolve(Settings.self)!
            return MarvelDataSource<ComicModel>(api: .comics, settings: settings)
        }
    }
}
