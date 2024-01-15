//
//  PokemonCore.swift
//  Pokedex
//
//  Created by Eliude Vemba on 13/01/24.
//

import Foundation
import SwiftUI

struct APIResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResponse]
}

struct PokemonResponse: Decodable, Identifiable, Hashable {
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
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")!
    }
    
    let id: Int
    let name: String
    let height: Double
    let weight: Double
    let stats: [Stats]
    let types: [PokemonTypes]
    let abilities: [Ability]
}

struct PokemonSpecies: Decodable {
    let id: Int
    let name: String
    let gender_rate: Double
    let flavor_text_entries: [FlavorText]
    let capture_rate: Double
    let color: MyColor
    let genera: [Genera]
    let egg_groups: [EggGroup]
    let hatch_counter: Double
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


struct Stats: Decodable, Hashable {
    let base_stat: Int
    let effort: Int
    let stat: Stat
}

struct Stat: Decodable, Hashable {
    let name: String
}

struct PokemonTypes: Hashable, Decodable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Decodable, Equatable, Hashable {
    let name: String
}


extension Pokemon: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Stat {
    var displayName: String {
        switch name {
        case "special-attack":
            return "sp. attack"
        case "special-defense":
            return "sp. defense"
        default:
            return name
        }
    }
}

extension PokemonType {
    func typeColor() -> Color {
        switch self.name {
        case "normal":
            return Color(.systemGray)
        case "fighting":
            return Color(.systemRed)
        case "flying":
            return Color(.systemBlue)
        case "poison":
            return Color(.systemPurple)
        case "ground":
            return Color(.systemYellow)
        case "rock":
            return Color(.systemOrange)
        case "bug":
            return Color(.systemGreen)
        case "ghost":
            return Color(.systemIndigo)
        case "steel":
            return Color(.systemGray2)
        case "fire":
            return Color(.systemRed)
        case "water":
            return Color(.systemBlue)
        case "grass":
            return Color(.systemGreen)
        case "electric":
            return Color(.systemYellow)
        case "psychic":
            return Color(.systemPurple)
        case "ice":
            return Color(.systemTeal)
        case "dragon":
            return Color(.systemIndigo)
        case "dark":
            return Color(.systemGray)
        case "fairy":
            return Color(.systemPink)
        case "unknown":
            return Color(.systemGray)
        case "shadow":
            return Color(.systemGray)
        default:
            return Color(.systemGray)
        }
    }
}

extension Double {
    func toFormattedString() -> String {
        return String(format: "%.1f", self)
    }
}
