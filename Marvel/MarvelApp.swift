//
//  MarvelApp.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import SwiftUI
import UIKit

/// The structure and behavior of the app.
@main
struct MarvelApp: App {
    /// Sets the appearance proxies for the navigation bar.
    init() {
        let newAppearance = UINavigationBarAppearance()
        newAppearance.configureWithOpaqueBackground()
        newAppearance.backgroundColor = .red
        newAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        newAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        
        UINavigationBar.appearance().standardAppearance = newAppearance
        UINavigationBar.appearance().compactAppearance = newAppearance
        UINavigationBar.appearance().tintColor = .systemBackground
        
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .systemBackground
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
