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
    
    @Published var pokemon: Pokemon?
    
    init(pokemonSearchResult: PokemonSearchResult, pokemonRepository: PokemonRepository = PokemonRepository()) {
        self.pokemonSearchResult = pokemonSearchResult
        self.pokemonRepository = pokemonRepository

        super.init()
        
        getPokemon(id: pokemonSearchResult.id)
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
}
