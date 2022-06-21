//
//  ComicModel.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Foundation
import SwiftUI

/// A Model representing a Comic.
struct ComicModel: Codable {
    /// Comic ID.
    let id: Int
    
    /// Title of comic.
    let title: String
    
    /// Description of comic.
    let description: String?
    
    /// Variant description of comic.
    let variantDescription: String?
    
    /// An image of Comic.
    let thumbnail: MImage?
}

/// A URL to the image.
struct MImage: Codable {
    /// URL path.
    let path: String
    
    /// File type of the image.
    let fileType: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case fileType = "extension"
    }
}
