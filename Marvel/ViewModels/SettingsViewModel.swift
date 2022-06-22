//
//  SettingsViewModel.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import Combine
import Foundation

/// The settings for the APP.
protocol Settings {
    /// Public key needed for the API.
    var publicKey: String { get }
    
    /// Private key needed for the API.
    var privateKey: String { get }
}

/// Public Key string for UserDefaults.
let publicKeyString = "publicKey"

/// Private Key string for UserDefaults.
let privateKeyString = "privateKey"

/// View Model to save and provide the API keys.
class SettingsViewModel: Settings, ObservableObject {
    var publicKey: String {
        get {
            UserDefaults.standard.string(forKey: publicKeyString) ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: publicKeyString)
        }
    }
    var privateKey: String {
        get {
            UserDefaults.standard.string(forKey: privateKeyString) ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: privateKeyString)
        }
    }
}
