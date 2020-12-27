//
//  PokemonUseCase.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/24.
//

import Foundation
import RxSwift

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
    func getPokemonList() -> Observable<PokemonSearchResults> {
        return pokemonMockingRepository.getPokemonList()
    }
    
    func getLocations() -> Observable<Locations> {
        return pokemonMockingRepository.getLocations()
    }
    
    func getPokemon(id: Int) -> Observable<Pokemon> {
        return pokemonRepository.getPokemon(id: id)
    }
}
