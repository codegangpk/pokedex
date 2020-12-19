//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation
import Combine

struct PokemonRepository {
    private let session: API
    private let mockingBaseURL = URL(string: "https://demo0928971.mockable.io")!
    
    init(session: API = API()) {
        self.session = session
    }
}

extension PokemonRepository {
    func getPokemonList() -> AnyPublisher<PokemonSearchResults, NetworkError> {
        return session.call(
            EndPoint(
                baseURL: mockingBaseURL,
                httpMethod: .get,
                path: "pokemon_name"
            ),
            for: PokemonSearchResultsModel.self
        )
        .compactMap { PokemonSearchResults(pokemonSearchResultsModel: $0) }
        .eraseToAnyPublisher()
    }
}
