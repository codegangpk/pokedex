//
//  PokemonMockingRepository.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation
import Combine

struct PokemonMockingRepository: PokemonMockingRepositoriable {
    let session: API
    let baseURL = URL(string: "https://demo0928971.mockable.io")!
    
    init(session: API = API()) {
        self.session = session
    }
}

extension PokemonMockingRepository {
    func getPokemonList() -> AnyPublisher<PokemonSearchResults, NetworkError> {
        return session.call(
            EndPoint(
                baseURL: baseURL,
                httpMethod: .get,
                path: "pokemon_name"
            ),
            for: PokemonSearchResultsModel.self
        )
        .compactMap { PokemonSearchResults(pokemonSearchResultsModel: $0) }
        .eraseToAnyPublisher()
    }
    
    func getLocations() -> AnyPublisher<Locations, NetworkError> {
        return session.call(
            EndPoint(
                baseURL: baseURL,
                httpMethod: .get,
                path: "pokemon_locations"
            )
            ,
            for: LocationsModel.self
        )
        .compactMap { Locations(locationsModel: $0) }
        .eraseToAnyPublisher()
    }
}
