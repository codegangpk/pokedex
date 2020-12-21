//
//  PokemonViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation
import Combine

class PokemonViewViewModel: BaseViewViewModel {
    let pokemonSearchResult: PokemonSearchResult
    private let pokemonRepository: PokemonRepository
    private let pokemonMockingRepository: PokemonMockingRepository
    
    @Published var pokemonViewModel: PokemonStatsTableViewCellViewModel?
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
        handleNetworkBegin()
        pokemonRepository
            .getPokemon(id: id)
            .sink(
                receiveCompletion: handleNetworkCompletion(completion:),
                receiveValue: { [weak self] pokemon in
                    guard let self = self else { return }
                    
                    self.pokemonViewModel = PokemonStatsTableViewCellViewModel(pokemonSearchResult: self.pokemonSearchResult, pokemon: pokemon)
                }
            )
            .store(in: &subscribers)
    }
    
    private func getLocations(id: Int) {
        pokemonMockingRepository
            .getLocations()
            .sink { _ in
            } receiveValue: { [weak self] locations in
                guard let self = self else { return }
                
                self.locations = locations.pokemons?
                    .filter { $0.id == id } ?? []
            }
            .store(in: &subscribers)
    }
}
