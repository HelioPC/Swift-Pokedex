//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Eliude Vemba on 30/05/22.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    let species: PokemonSpecies
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title2)
                Spacer()
                Text(formattedId)
                    .bold()
                    .font(.title2)
                Spacer()
                Image(systemName: "heart.fill")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 30)
            
            AsyncImage(url: pokemon.url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 300, maxHeight: 300)
                case .empty:
                    ProgressView()
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            
            Text("\(pokemon.name.capitalized)")
                .bold()
                .font(.title)
            Text("Seed Pokemon")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
    }
    
    var formattedId: String {
        String(format: "#%03d", pokemon.id)
    }
}

#Preview {
    PokemonDetailView(pokemon: PokemonViewModel.MOCK_POKEMON, species: PokemonViewModel.MOCK_SPECIES)
}
