//
//  SearchViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import Foundation

class SearchViewViewModel: BaseViewViewModel, ObservableObject {
    @Published var searchText: String = ""
    
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository = PokemonRepository()) {
        self.pokemonRepository = pokemonRepository
    }
}

extension SearchViewViewModel {
    func getPokemonList() {
        pokemonRepository
            .getPokemonList()
    }
}
