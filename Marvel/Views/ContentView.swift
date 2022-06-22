//
//  ContentView.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ComicSearchView(viewModel: MarvelResolver.resolver.resolve(ComicsViewModel.self)!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
