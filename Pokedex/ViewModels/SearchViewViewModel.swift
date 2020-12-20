//
//  SearchViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import Foundation
import Combine

class SearchViewViewModel: BaseViewViewModel, ObservableObject {
    @Published var searchText: String = ""
    @Published var pokemonViewModels: [PokemonTableViewCellViewModel] = []
    
    private let pokemonRepository: PokemonMockingRepository
    
    var subscribers = Set<AnyCancellable>()
    
    init(pokemonRepository: PokemonMockingRepository = PokemonMockingRepository()) {
        self.pokemonRepository = pokemonRepository
        
        super.init()
        
        $searchText
            .handleEvents(receiveOutput: { [weak self] value in
                guard let self = self else { return }
                print("value: \(value)")
                self.pokemonViewModels.removeAll()
                self.utility.isLoading = true
            })
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map { _ in pokemonRepository.getPokemonList() }
            .switchToLatest()
            .sink { _ in
            } receiveValue: { [weak self] pokemonSearchResults in
                guard let self = self else { return }
                
                self.utility.isLoading = false
                
                self.pokemonViewModels = pokemonSearchResults.pokemons?
                    .filter { [weak self] in
                        guard let self = self,
                              self.searchText.isEmpty == false
                        else { return true }
                        
                        return $0.name(for: self.searchText) != nil
                    }
                    .compactMap {
                        PokemonTableViewCellViewModel(keyword: self.searchText, pokemonSearchResult: $0)
                    } ?? []
            }
            .store(in: &subscribers)
    }
}
