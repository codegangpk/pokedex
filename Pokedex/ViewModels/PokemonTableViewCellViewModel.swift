//
//  PokemonTableViewCellViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

struct PokemonTableViewCellViewModel: Equatable {
    private let pokemonSearchResult: PokemonSearchResult
    
    init(pokemonSearchResult: PokemonSearchResult) {
        self.pokemonSearchResult = pokemonSearchResult
    }
}

extension PokemonTableViewCellViewModel {
    var numberText: String? {
        return "\(pokemonSearchResult.id)"
    }
    
    var nameText: String? {
        return "\(pokemonSearchResult.names.first)"
    }
}
