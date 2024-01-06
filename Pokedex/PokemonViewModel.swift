//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Eliude Vemba on 29/05/22.
//

import SwiftUI

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
    
    var  url: URL {
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
    
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let stats: [Stats]
    let types: [PokemonTypes]
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

enum FetchError: Error {
    case badUrl
    case badResponse
    case badData
}
