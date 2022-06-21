//
//  ContentView.swift
//  Marvel
//
//  Created by Hibbard Family on 6/20/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ComicsViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
