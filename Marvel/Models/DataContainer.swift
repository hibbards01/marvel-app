//
//  DataContainer.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Foundation

struct DataContainer<Model: Codable>: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Model]
}
