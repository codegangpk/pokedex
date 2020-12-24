//
//  PokemonMockingRepositoriable.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/24.
//

import Foundation
import Combine

protocol PokemonMockingRepositoriable: Repositoriable {
    func getPokemonList() -> AnyPublisher<PokemonSearchResults, NetworkError>
    func getLocations() -> AnyPublisher<Locations, NetworkError>
}
