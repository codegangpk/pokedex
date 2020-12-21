//
//  SearchViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import Foundation
import Combine

class SearchViewViewModel: BaseViewViewModel {
    private let pokemonRepository: PokemonMockingRepository
    
    @Published var pokemonSearchResults: [PokemonSearchResult] = []
    @Published var searchText: String = ""
    @Published var pokemonViewModels: [PokemonTableViewCellViewModel] = []
    
    init(pokemonRepository: PokemonMockingRepository = PokemonMockingRepository()) {
        self.pokemonRepository = pokemonRepository
        
        super.init()

        getPokemonList()
        subscribeForSearchText()
    }
}

extension SearchViewViewModel {
    private func getPokemonList() {
        self.isLoading = true
        pokemonRepository.getPokemonList()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.isLoading = false
            } receiveValue: { [weak self] pokemonSearchResults in
                guard let self = self else { return }
                
                self.pokemonSearchResults = pokemonSearchResults.pokemons ?? []
            }
            .store(in: &subscribers)
    }
    
    private func subscribeForSearchText() {
        $searchText
            .combineLatest($pokemonSearchResults)
            .compactMap { searchText, pokemonSearchResults in
                return pokemonSearchResults
                    .filter {
                        guard searchText.isEmpty == false else { return true }
                        
                        return $0.name(for: searchText) != nil
                    }
                    .compactMap {
                        PokemonTableViewCellViewModel(keyword: searchText, pokemonSearchResult: $0)
                    }
            }
            .sink { [weak self] viewModels in
                guard let self = self,
                      self.pokemonViewModels != viewModels
                else { return }
                
                self.pokemonViewModels = viewModels
            }
            .store(in: &subscribers)
    }
}
