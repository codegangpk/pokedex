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
    
    private let pokemonRepository: PokemonRepository
    
    var subscribers = Set<AnyCancellable>()
    
    init(pokemonRepository: PokemonRepository = PokemonRepository()) {
        self.pokemonRepository = pokemonRepository
        
        super.init()
        
        $searchText
            .handleEvents(receiveOutput: { [weak self] value in
                guard let self = self else { return }
                print("value: \(value)")
                self.pokemonViewModels.removeAll()
            })
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .handleEvents(receiveOutput: { _ in
                self.utility.isLoading = true
                print("self.utility.isLoading : \(self.utility.isLoading)")
            })
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
                        
                        return $0.names.contains {
                            $0.contains(self.searchText)
                        }
                    }
                    .compactMap {
                        PokemonTableViewCellViewModel(pokemonSearchResult: $0)
                    } ?? []
            }
            .store(in: &subscribers)
    }
}
