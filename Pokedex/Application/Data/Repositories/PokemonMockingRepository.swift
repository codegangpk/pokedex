//
//  PokemonMockingRepository.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation
import Combine

struct PokemonMockingRepository: PokemonMockingRepositoriable {
    let networkService: NetworkService
    let baseURL = URL(string: "https://demo0928971.mockable.io")!
    
    init(session: NetworkService = NetworkService.shared) {
        self.networkService = session
    }
}

extension PokemonMockingRepository {
    func getPokemonList() -> AnyPublisher<PokemonSearchResults, NetworkError> {
        return networkService.call(
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
        return networkService.call(
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
