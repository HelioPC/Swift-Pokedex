//
//  PokemonList.swift
//  Pokedex
//
//  Created by Eliude Vemba on 05/01/24.
//

import SwiftUI

struct PokemonList: View {
    @ObservedObject var loader: PokemonLoader

    var body: some View {
        List {
            ForEach(loader.pokemonData) { pokemon in
                PokemonCellView(pokemon: pokemon)
                .task {
                    if pokemon == loader.pokemonData.last {
                        await loader.load()
                    }
                }
            }
        }
    }
}

#Preview {
    PokemonList(loader: PokemonLoader())
}
