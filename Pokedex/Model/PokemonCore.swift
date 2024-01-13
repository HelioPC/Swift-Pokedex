//
//  PokemonCore.swift
//  Pokedex
//
//  Created by Eliude Vemba on 13/01/24.
//

import Foundation

struct APIResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResponse]
}

struct PokemonResponse: Decodable, Identifiable {
    static var totalFound = 0
    
    let id: Int
    let name: String
    
    var url: URL {
        URL(string: "https://img.pokemondb.net/artwork/large/\(name).jpg")!
    }
    
    private enum PokemonKeys: String, CodingKey {
        case name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        PokemonResponse.totalFound += 1
        self.id = PokemonResponse.totalFound
    }
}

extension PokemonResponse {
    static let sample = Self.init(id: 1, name: "bulbasaur")
}

extension PokemonResponse: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Pokemon: Identifiable, Decodable {
    private (set) var pokeID = UUID()
    var isFavorite = false
    
    var url: URL {
        URL(string: "https://img.pokemondb.net/artwork/large/\(name.lowercased()).jpg")!
    }
    
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let stats: [Stats]
    let types: [PokemonTypes]
    let abilities: [Ability]
}

struct PokemonSpecies: Decodable {
    let id: Int
    let name: String
    let gender_rate: Int
    let flavor_text_entries: [FlavorText]
    let capture_rate: Int
    let color: MyColor
    let genera: [Genera]
    let egg_groups: [EggGroup]
    let hatch_counter: Int
    let evolution_chain: EvolutionChain
    let growth_rate: GrowthRate
}

struct FlavorText: Decodable {
    let flavor_text: String
    let language: Language
}

struct Ability: Decodable {
    let ability: AbilityName
}

struct AbilityName: Decodable {
    let name: String
}

struct Genera: Decodable {
    let genus: String
    let language: Language
}

struct EvolutionChain: Decodable {
    let url: String
}

struct GrowthRate: Decodable {
    let name: String
}

struct EggGroup: Decodable {
    let name: String
}

struct Language: Decodable {
    let name: String
}

struct MyColor: Decodable {
    let name: String
}


struct Stats: Decodable {
    let base_stat: Int
    let effort: Int
    let stat: Stat
}

struct Stat: Decodable {
    let name: String
}

struct PokemonTypes: Decodable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
}


extension Pokemon: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
