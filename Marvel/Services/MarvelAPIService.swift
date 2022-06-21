//
//  MarvelAPIService.swift
//  Marvel
//
//  Created by Hibbard Family on 6/21/22.
//

/// The service paths to the Marvel API.
///
/// Use ``url()`` to get the full URL string of the case you have chosen in your request.
enum MarvelAPIService {
    /// Grab the comics.
    case comics
    
    /// The full URL path to use in the request.
    /// - Parameter id: The id to pass into the URL path.
    /// - Returns: Returns the full URL as a `String`.
    func url(id: Int?) -> String {
        var urlString = "https://gateway.marvel.com/v1/public/"
        switch self {
        case .comics:
            urlString += "comics"
            
            if let id {
                urlString += "/\(id)"
            }
        }
        
        return urlString
    }
}
