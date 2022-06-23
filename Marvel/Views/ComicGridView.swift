//
//  ComicGridView.swift
//  Marvel
//
//  Created by Hibbard Family on 6/22/22.
//

import SwiftUI
import Swinject

struct ComicGridView: View {
    @ObservedObject var viewModel: ComicListViewModel
    
    private var gridView: some View {
        Grid(horizontalSpacing: 8, verticalSpacing: 8) {
            ForEach(viewModel.gridViews) { gridRow in
                GridRow {
                    ForEach(gridRow.row) { column in
                        column
                    }
                    
                }
                if gridRow == viewModel.gridViews.last {
                    GridRow {
                        Text("")
                        bottomLoading
                        Text("")
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var bottomLoading: some View {
        HStack {
            Button(action: viewModel.fetchComics) {
                Text("Load More")
                    .foregroundColor(.blue)
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .padding(.leading, 4)
            }
        }
    }
    
    private var gridContainerView: some View {
        ZStack {
            Color(uiColor: UIColor.systemBackground)
            
            ScrollView {
                VStack {
                    if viewModel.isLoading && viewModel.gridViews.isEmpty {
                        ProgressView()
                            .scaleEffect(2)
                            .frame(width: 50, height: 50)
                            .padding(.top)
                    }
                    
                    gridView
                        .padding(.top)
                    
                    Spacer()
                }
            }
            .navigationTitle("Comic List")
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("logo-red").ignoresSafeArea()
                
                gridContainerView
            }
            .onAppear {
                viewModel.fetchComics()
            }
        }
    }
}

struct ComicListView_Previews: PreviewProvider {
    static var previews: some View {
        ComicGridView(viewModel: viewModel)
    }
    
    private static var gridViewItems: [GridRowData] {
        [
            row,
            row,
            row,
            row
        ]
    }
    
    private static var row: GridRowData {
        GridRowData(id: Int.random(in: 0...100), row: [
            ComicView(id: UUID(),
                      title: "Marvel Title (2019)",
                      desc: "Some description",
                      variantDesc: nil,
                      image: Image("marvel-image"),
                      largeSize: false),
            ComicView(id: UUID(),
                      title: "Marvel Title (2019)",
                      desc: "Some description",
                      variantDesc: nil,
                      image: Image("marvel-image"),
                      largeSize: false),
            ComicView(id: UUID(),
                      title: "Marvel Title (2019)",
                      desc: "Some description",
                      variantDesc: nil,
                      image: Image("marvel-image"),
                      largeSize: false)
        ])
    }
    
    private static var viewModel: ComicListViewModel {
        // Register mock session.
        let assemblies = Assembler([
            MarvelAssembly()
        ])
        let viewModel = assemblies.resolver.resolve(ComicListViewModel.self)!
        viewModel.gridViews = gridViewItems
        
        return viewModel
    }
}
