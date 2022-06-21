//
//  ComicModel.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Foundation
import SwiftUI

struct ComicModel: Codable {
    let id: Int
    let title: String
    let description: String?
    let variantDescription: String?
    let thumbnail: MImage?
}

struct MImage: Codable {
    let path: String
    let fileType: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileType = "extension"
    }
}
