//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Eliude Vemba on 29/05/22.
//

import SwiftUI
import Kingfisher

struct PokemonImageView: View {
    var image: KFImage
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 5))
            .background(Circle().foregroundColor(.white))
            .shadow(radius: 5)
    }
}

struct PokemonImageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImageView(image: KFImage(URL(string: PokemonViewModel().MOCK_POKEMON.imageURL)))
    }
}
