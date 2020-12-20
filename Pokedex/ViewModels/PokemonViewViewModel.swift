//
//  PokemonViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

class PokemonViewViewModel: BaseViewViewModel, ObservableObject {
    let pokemonSearchResult: PokemonSearchResult
    private let pokemonRepository: PokemonRepository
    private let pokemonMockingRepository: PokemonMockingRepository
    
    @Published var pokemon: Pokemon?
    @Published var locations: [Location]?
    
    init(pokemonSearchResult: PokemonSearchResult,
         pokemonRepository: PokemonRepository = PokemonRepository(),
         pokemonMockingRepository: PokemonMockingRepository = PokemonMockingRepository()
    ) {
        self.pokemonSearchResult = pokemonSearchResult
        self.pokemonRepository = pokemonRepository
        self.pokemonMockingRepository = pokemonMockingRepository

        super.init()
        
        getPokemon(id: pokemonSearchResult.id)
        getLocations(id: pokemonSearchResult.id)
    }
}

extension PokemonViewViewModel {
    private func getPokemon(id: Int) {
        utility.isLoading = true
        pokemonRepository
            .getPokemon(id: id)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.utility.isLoading = false
            } receiveValue: { [weak self] pokemon in
                guard let self = self else { return }
                
                self.pokemon = pokemon
            }
            .store(in: &utility.subscribers)
    }
    
    private func getLocations(id: Int) {
        utility.isLoading = true
        pokemonMockingRepository
            .getLocations()
            .sink { _ in
            } receiveValue: { [weak self] locations in
                guard let self = self else { return }
                
                self.locations = locations.pokemons?
                    .filter { $0.id == id } ?? []
            }
            .store(in: &utility.subscribers)
    }
}
