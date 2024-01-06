//
//  PokemonLoader.swift
//  Pokedex
//
//  Created by Eliude Vemba on 05/01/24.
//

import Foundation
import Combine

class PokemonLoader: ObservableObject {
    @Published private(set) var pokemonData: [PokemonResponse] = []

    private let urlSession = URLSession(configuration: .default)
    private let limit = 20
    private var offset = 0

    func restartPagination() {
        offset = 0
        PokemonResponse.totalFound = 0
    }


    private func getPokemons() async throws -> [PokemonResponse] {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=\(limit)&offset=\(offset)")!
        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200
        else { throw FetchError.badResponse }
        guard let data = data.removeNullsFrom(string: "null,") else { throw FetchError.badData }

        guard let decoded = try? JSONDecoder().decode(APIResponse.self, from: data)
        else { throw FetchError.badData }

        if self.offset >= 600 {
            self.offset = 600
        } else {
            self.offset += self.limit
        }

        return decoded.results
    }

    @MainActor func load(restart: Bool = false) async {
        if restart {
            restartPagination()
            pokemonData.removeAll()
        }

        do {
            pokemonData += try await getPokemons()
        } catch {
            print("error: ",error)
        }
    }
}

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
