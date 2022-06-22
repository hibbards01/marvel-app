//
//  ResponseContainer.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Foundation

/// Container that holds the response.
struct ResponseContainer<Model: MarvelModel>: Codable {
    /// Status code.
    let code: Int
    
    /// String description of call status.
    let status: String
    
    /// Copyright string.
    let copyright: String
    
    /// Results returned by the call.
    let data: DataContainer<Model>
}
