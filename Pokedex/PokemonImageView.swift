//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Eliude Vemba on 29/05/22.
//

import SwiftUI

struct PokemonImageView: View {
    var image: String
    
    var body: some View {
        AsyncImage(url: URL(string: image)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                    .background(Circle().foregroundColor(.white))
                    .shadow(radius: 5)
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct PokemonImageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageView(image: PokemonViewModel().MOCK_POKEMON.imageURL)
    }
}
