//
//  ComicSearchView.swift
//  Marvel
//
//  Created by Hibbard Family on 6/21/22.
//

import SwiftUI
import Swinject

struct ComicSearchView: View {
    @ObservedObject var viewModel: ComicsViewModel
    @State var showModal = false
    
    private var comicView: some View {
        ZStack {
            Color(uiColor: UIColor.systemBackground)
            
            if let comic = viewModel.comic {
                ComicView(title: comic.title,
                          desc: comic.description,
                          variantDesc: comic.variantDescription,
                          image: viewModel.image)
            } else if let error = viewModel.showError {
                Text(error)
                    .foregroundColor(.red)
            } else {
                Text("Search for a comic by ID")
            }
        }
    }
    
    private var mainContent: some View {
        ZStack {
            Color("logo-red").ignoresSafeArea()
            
            comicView
        }
        .searchable(text: $viewModel.searchText)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showModal.toggle()
                }) {
                    Image(systemName: "gear.circle")
                }
            }
        }
        .sheet(isPresented: $showModal) {
            SettingsView()
        }
    }
    
    var body: some View {
        NavigationStack {
            mainContent
                .navigationTitle("Marvel Comics")
        }
    }
}

struct ComicSearchView_Previews: PreviewProvider {
    static var viewModel: ComicsViewModel {
        // Register mock session.
        let assemblies = Assembler([
            MarvelAssembly()
        ])
        let viewModel = assemblies.resolver.resolve(ComicsViewModel.self)!
        viewModel.comic = mockComicModels.first
        viewModel.image = Image(uiImage: UIImage(named: "marvel-image")!)
        
        return viewModel
    }
    
    static var previews: some View {
        ComicSearchView(viewModel: viewModel)
    }
}
