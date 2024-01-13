//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Eliude Vemba on 29/05/22.
//

import SwiftUI

enum FetchError: Error {
    case badUrl
    case badResponse
    case badData
}

// TODO: Create a mock data source for Pokemon
// TODO: Fetch (Pokemon) and (Pokemon Species)

class PokemonViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    @Published var pokemonSpecies: PokemonSpecies?
    
    let id: Int
    
    init(id: Int) {
        self.id = id

        Task {
            pokemon = try await getPokemon(id: id)
            pokemonSpecies = try await getPokemonSpecies(id: id)
        }
    }
    
    func getPokemon(id: Int) async throws -> Pokemon {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")
        else { throw FetchError.badUrl }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse}
        guard let data = data.removeNullsFrom(string: "null,") else { throw FetchError.badData }
        
        let maybePokemonData = try JSONDecoder().decode(Pokemon.self, from: data)
        
        return maybePokemonData
    }

    func getPokemonSpecies(id: Int) async throws -> PokemonSpecies {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)")
        else { throw FetchError.badUrl }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse}
        guard let data = data.removeNullsFrom(string: "null,") else { throw FetchError.badData }
        
        let maybePokemonSpeciesData = try JSONDecoder().decode(PokemonSpecies.self, from: data)
        
        return maybePokemonSpeciesData
        
    }
    
    static let MOCK_POKEMON = Pokemon(
        id: 1, name: "bulbasaur", height: 7, weight: 69,
        stats: [
            Stats(base_stat: 45, effort: 0, stat: Stat(name: "hp")),
        ],
        types: [
            PokemonTypes(slot: 1, type: PokemonType(name: "grass")),
        ],
        abilities: [
            Ability(ability: AbilityName(name: "overgrow")),
        ]
    )

    static let MOCK_SPECIES = PokemonSpecies(
        id: 1, name: "bulbasaur", gender_rate: 1,
        flavor_text_entries: [
            FlavorText(flavor_text: "A strange seed was planted on its back at birth. The plant sprouts and grows with this POKéMON.", language: Language(name: "en")),
        ],
        capture_rate: 45,
        color: MyColor(name: "green"),
        genera: [
            Genera(genus: "Seed Pokémon", language: Language(name: "en")),
        ],
        egg_groups: [
            EggGroup(name: "Monster"),
        ],
        hatch_counter: 20,
        evolution_chain: EvolutionChain(url: "https://pokeapi.co/api/v2/evolution-chain/1/"),
        growth_rate: GrowthRate(name: "medium-slow")
    )
}
