//
//  MarvelResolver.swift
//  Marvel
//
//  Created by Hibbard Family on 6/21/22.
//

import Swinject

/// Resolver for the app.
struct MarvelResolver {
    /// `static` resolver so it can be used anywhere.
    static let resolver = assembleContainer()
    
    private init() {}
    
    private static func assembleContainer() -> Resolver {
        let assembler = Assembler([
            MarvelAssembly()
        ])
        
        return assembler.resolver
    }
}
