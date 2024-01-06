//
//  PokemonCellView.swift
//  Pokedex
//
//  Created by Eliude Vemba on 05/01/24.
//

import SwiftUI

struct PokemonCellView: View {
    // @ObservedObject var pokemonVM = PokemonViewModel()
    let pokemon: PokemonResponse
    
    var body: some View {
        NavigationLink(destination: VStack {}) {
            HStack {
                AsyncImage(url: pokemon.url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .interpolation(.high)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100, maxHeight: 100)
                    case .empty:
                        ProgressView()
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("ID: \(pokemon.id)")
                        .font(.subheadline)

                    Text(pokemon.name.capitalized)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.leading, 30)
                
                Spacer()
            }
        }
    }
}

#Preview {
    PokemonCellView(pokemon: PokemonResponse.sample)
}
