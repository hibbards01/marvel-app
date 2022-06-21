//
//  DataContainer.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Foundation

/// Container to hold the data.
struct DataContainer<Model: Codable>: Codable {
    /// Number of skipped results.
    let offset: Int
    
    /// Result limit.
    let limit: Int
    
    /// Total results.
    let total: Int
    
    /// An Array of the Model specified.
    let results: [Model]
}
