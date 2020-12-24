//
//  PokemonUseCase.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/24.
//

import Foundation
import Combine

struct PokemonUseCase {
    private let pokemonMockingRepository: PokemonMockingRepositoriable
    private let pokemonRepository: PokemonRepositoriable
    
    init(
        pokemonMockingRepository: PokemonMockingRepositoriable = PokemonMockingRepository(),
        pokemonRepository: PokemonRepositoriable = PokemonRepository()
    ) {
        self.pokemonMockingRepository = pokemonMockingRepository
        self.pokemonRepository = pokemonRepository
    }
}

extension PokemonUseCase {
    func getPokemonList() -> AnyPublisher<PokemonSearchResults, NetworkError> {
        return pokemonMockingRepository.getPokemonList()
    }
    
    func getLocations() -> AnyPublisher<Locations, NetworkError> {
        return pokemonMockingRepository.getLocations()
    }
    
    func getPokemon(id: Int) -> AnyPublisher<Pokemon, NetworkError> {
        return pokemonRepository.getPokemon(id: id)
    }
}
