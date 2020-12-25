//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import Foundation
import Combine

struct PokemonRepository: PokemonRepositoriable {
    let networkService: NetworkService
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    init(session: NetworkService = NetworkService.shared) {
        self.networkService = session
    }
}

extension PokemonRepository {
    func getPokemon(id: Int) -> AnyPublisher<Pokemon, NetworkError> {
        return networkService.call(
            EndPoint(
                baseURL: baseURL,
                httpMethod: .get,
                path: "pokemon/\(id)"
            )
            , for: PokemonModel.self
        )
        .compactMap { Pokemon(pokemonModel: $0) }
        .eraseToAnyPublisher()
    }
}
