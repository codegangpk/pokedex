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
            .sink { [weak self] (searchText, pokemonSearchResults) in
                guard let self = self else { return }
                
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    guard let self = self else { return }
                    
                    let viewModels = pokemonSearchResults.filter {
                        guard searchText.isEmpty == false else { return true }
                        
                        return $0.name(for: searchText) != nil
                    }
                    .compactMap {
                        PokemonTableViewCellViewModel(keyword: searchText, pokemonSearchResult: $0)
                    }
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        
                        guard self.pokemonViewModels != viewModels else { return }
                        
                        self.pokemonViewModels = viewModels
                    }
                }
            }
            .store(in: &subscribers)
    }
}

