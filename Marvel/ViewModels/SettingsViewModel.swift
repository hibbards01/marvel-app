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

let publicKeyString = "publicKey"
let privateKeyString = "privateKey"

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
