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
            .map { _ in pokemonRepository.getPokemonList() }
            .switchToLatest()
            .sink { [weak self] (error) in
                guard let self = self else { return }
                
                self.utility.isLoading = false
            } receiveValue: { [weak self] pokemonSearchResults in
                guard let self = self else { return }
                
                self.pokemonViewModels = pokemonSearchResults.pokemons?.compactMap {
                    PokemonTableViewCellViewModel(pokemonSearchResult: $0)
                } ?? []
            }
            .store(in: &subscribers)
    }
}
