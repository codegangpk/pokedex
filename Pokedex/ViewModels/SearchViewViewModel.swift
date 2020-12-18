//
//  SearchViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import Foundation

class SearchViewViewModel: BaseViewViewModel, ObservableObject {
    @Published var searchText: String = ""
    @Published var pokemonViewModels: [PokemonTableViewCellViewModel] = []
    
    private let pokemonRepository: PokemonRepository
    
    init(pokemonRepository: PokemonRepository = PokemonRepository()) {
        self.pokemonRepository = pokemonRepository
    }
}

extension SearchViewViewModel {
    func getPokemonList() {
        utility.call(pokemonRepository.getPokemonList()) { [weak self] in
            guard let self = self else { return }
            
            switch $0 {
            case .success(let pokemonSearchResults):
                self.pokemonViewModels = pokemonSearchResults.pokemons?
                    .compactMap { PokemonTableViewCellViewModel(pokemonSearchResult: $0) } ?? []
                print("viewModels: \(self.pokemonViewModels)")
            case .failure:
                break
            }
        }
    }
}
