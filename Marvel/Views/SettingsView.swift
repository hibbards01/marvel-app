//
//  SettingsView.swift
//  Marvel
//
//  Created by Hibbard Family on 6/21/22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    init() {
        guard let vm = MarvelResolver.resolver.resolve(Settings.self) as? SettingsViewModel else {
            fatalError("Unable to grab the SettingsViewModel")
        }
        viewModel = vm
    }
    
    private var apiKeys: some View {
        ZStack {
            Color(uiColor: UIColor.systemBackground)
            
            VStack(spacing: 20) {
                textFieldView(label: "Public Key", text: $viewModel.publicKey)
                textFieldView(label: "Private Key", text: $viewModel.privateKey)
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func textFieldView(label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(label)
            TextField("Enter \(label)", text: text)
                .textFieldStyle(.roundedBorder)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("logo-red").ignoresSafeArea()
                
                apiKeys
                    .navigationTitle("Settings")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
