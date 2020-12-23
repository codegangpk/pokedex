//
//  PokemonViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation
import Combine

final class PokemonViewViewModel: BaseViewViewModel {
    private let pokemonSearchResult: PokemonSearchResult
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
        
        getPokemon(id: pokemonId)
        getLocations(id: pokemonId)
    }
}

extension PokemonViewViewModel {
    var pokemonId: Int {
        return pokemonSearchResult.id
    }
    
    var pokemonName: String {
        return pokemonSearchResult.koreanName
    }
}

extension PokemonViewViewModel {
    func getPokemon(id: Int) {
        beginNetworkRequest()
        pokemonRepository
            .getPokemon(id: id)
            .sink(
                receiveCompletion: completeNetworkRequest(completion:),
                receiveValue: { [weak self] pokemon in
                    guard let self = self else { return }

                    let viewModel = PokemonStatsTableViewCellViewModel(pokemonSearchResult: self.pokemonSearchResult, pokemon: pokemon)

                    guard self.pokemonViewModel != viewModel else { return }
                    
                    self.pokemonViewModel = viewModel
                }
            )
            .store(in: &subscribers)
    }
    
    func getLocations(id: Int) {
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
