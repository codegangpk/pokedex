//
//  SearchViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import Foundation
import Combine

final class SearchViewViewModel: BaseViewViewModel {
    private let pokemonUseCase: PokemonUseCase
    
    @Published var pokemonSearchResults: [PokemonSearchResult] = []
    @Published var searchText: String = ""
    @Published var pokemonViewModels: [PokemonTableViewCellViewModel] = []
    
    init(pokemonUseCase: PokemonUseCase = PokemonUseCase()) {
        self.pokemonUseCase = pokemonUseCase
        
        super.init()

        getPokemonList()
        subscribeForSearchText()
    }
}

extension SearchViewViewModel {
    func getPokemonList() {
        beginNetworkRequest()
        pokemonUseCase
            .getPokemonList()
            .sink(
                receiveCompletion: completeNetworkRequest(completion:),
                receiveValue: { [weak self] pokemonSearchResults in
                    guard let self = self else { return }
                    
                    self.pokemonSearchResults = pokemonSearchResults.pokemons ?? []
                }
            )
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
            .filter { $0 != self.pokemonViewModels }
            .assign(to: \.pokemonViewModels, on: self)
            .store(in: &subscribers)
    }
}
