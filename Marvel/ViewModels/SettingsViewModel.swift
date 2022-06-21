//
//  SettingsViewModel.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Combine

/// The settings for the APP.
protocol Settings {
    /// Public key needed for the API.
    var publicKey: String { get }
    
    /// Private key needed for the API.
    var privateKey: String { get }
}

class SettingsViewModel: Settings, ObservableObject {
    var publicKey: String = ""
    var privateKey: String = ""
}
