//
//  ContentView.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import SwiftUI

/// Main view.
struct ContentView: View {
    var body: some View {
        TabView {
            ComicSearchView(viewModel: MarvelResolver.resolver.resolve(ComicViewModel.self)!)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            ComicGridView(viewModel: MarvelResolver.resolver.resolve(ComicListViewModel.self)!)
                .tabItem {
                    Label("List", systemImage: "rectangle.grid.3x2")
                }
        }
        .accentColor(.white)
    }
}

/// SwiftUI preivew for the ``ContentView``.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
