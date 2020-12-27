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
    private let pokemonUseCase: PokemonUseCase
    
    @Published var pokemonViewModel: PokemonStatsTableViewCellViewModel?
    @Published var locations: [Location]?
    
    init(pokemonSearchResult: PokemonSearchResult,
         pokemonUseCase: PokemonUseCase = PokemonUseCase()
    ) {
        self.pokemonSearchResult = pokemonSearchResult
        self.pokemonUseCase = pokemonUseCase

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
        pokemonUseCase
            .getPokemon(id: id)
            .sink(
                receiveCompletion: completeNetworkRequest(completion:),
                receiveValue: { [weak self] pokemon in
                    guard let self = self else { return }

                    DispatchQueue.global(qos: .userInitiated).async { [ weak self] in
                        guard let self = self else { return }
                        
                        let viewModel = PokemonStatsTableViewCellViewModel(pokemonSearchResult: self.pokemonSearchResult, pokemon: pokemon)

                        DispatchQueue.main.async { [weak self] in
                            guard let self = self,
                                  self.pokemonViewModel != viewModel
                            else { return }
                            
                            self.pokemonViewModel = viewModel
                        }
                    }
                }
            )
            .store(in: &subscribers)
    }
    
    func getLocations(id: Int) {
        pokemonUseCase
            .getLocations()
            .sink { _ in
            } receiveValue: { [weak self] locations in
                guard let self = self else { return }

                DispatchQueue.global(qos: .userInitiated).async {
                    let locations = locations.pokemons?.filter { $0.id == id }
                    
                    DispatchQueue.main.async {
                        self.locations = locations
                    }
                }
            }
            .store(in: &subscribers)
    }
}
