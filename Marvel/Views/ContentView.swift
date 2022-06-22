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
        ComicSearchView(viewModel: MarvelResolver.resolver.resolve(ComicsViewModel.self)!)
    }
}

/// SwiftUI preivew for the ``ContentView``.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
