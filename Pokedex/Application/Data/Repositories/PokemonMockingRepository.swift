//
//  PokemonMockingRepository.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation
import RxSwift

struct PokemonMockingRepository: PokemonMockingRepositoriable {
    let networkService: NetworkService
    let baseURL = URL(string: "https://demo0928971.mockable.io")!
    
    init(session: NetworkService = NetworkService.shared) {
        self.networkService = session
    }
}

extension PokemonMockingRepository {
    func getPokemonList() -> Observable<PokemonSearchResults> {
        return networkService.call(
            EndPoint(
                baseURL: baseURL,
                httpMethod: .get,
                path: "pokemon_name"
            ),
            for: PokemonSearchResultsModel.self
        )
        .compactMap { PokemonSearchResults(pokemonSearchResultsModel: $0) }
    }
    
    func getLocations() -> Observable<Locations> {
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
    }
}
