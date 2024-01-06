//
//  ContentView.swift
//  Pokedex
//
//  Created by Eliude Vemba on 29/05/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var loader = PokemonLoader()
    
    var body: some View {
        NavigationView {
            PokemonList(loader: loader)
            .navigationTitle("Pokedex 2022")
            .task {
                await loader.load(restart: true)
            }
            .refreshable {
                await loader.load(restart: true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
