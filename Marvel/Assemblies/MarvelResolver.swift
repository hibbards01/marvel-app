//
//  MarvelResolver.swift
//  Marvel
//
//  Created by Hibbard Family on 6/21/22.
//

import Swinject

struct MarvelResolver {
    static let resolver = assembleContainer()
    
    private init() {}
    
    private static func assembleContainer() -> Resolver {
        let assembler = Assembler([
            MarvelAssembly()
        ])
        
        return assembler.resolver
    }
}
