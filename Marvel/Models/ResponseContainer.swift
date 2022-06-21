//
//  ResponseContainer.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Foundation

struct ResponseContainer<Model: Codable>: Codable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let data: DataContainer<Model>
}
