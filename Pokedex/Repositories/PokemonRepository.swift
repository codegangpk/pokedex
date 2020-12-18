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
    func getPokemonList() -> AnyPublisher<PokemonSearchResult, NetworkError> {
        session.call(
            EndPoint(
                baseURL: mockingBaseURL,
                httpMethod: .post,
                path: "pokemon_name",
                parameters: [
                    "hi" : "bye",
                    "hi2" : "bye111"
                ]
            ),
            for: PokemonSearchResultModel.self
        )
        .compactMap { PokemonSearchResult(pokemonSearchResultModel: $0) }
        .eraseToAnyPublisher()
    }
}
