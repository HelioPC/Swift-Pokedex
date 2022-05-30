//
//  PokemonStatsGroupView.swift
//  Pokedex
//
//  Created by Eliude Vemba on 29/05/22.
//

import SwiftUI

struct PokemonStatsGroupView: View {
    var pokemon: Pokemon

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 250)
                .foregroundColor(.white)
                .opacity(0.6)
                .cornerRadius(20)
            
            VStack {
                PokemonStatView(pokemon: pokemon, statName: "Atk", statColor: .blue, statValue: pokemon.attack)
                
                PokemonStatView(pokemon: pokemon, statName: "Def", statColor: .red, statValue: pokemon.defense)
                
                PokemonStatView(pokemon: pokemon, statName: "Hgt", statColor: .teal, statValue: pokemon.height)
                
                PokemonStatView(pokemon: pokemon, statName: "Wgt", statColor: .cyan, statValue: pokemon.weight)
            }
        }
    }
}

struct PokemonStatsGroupView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonStatsGroupView(pokemon: PokemonViewModel().MOCK_POKEMON)
    }
}
