//
//  PokemonTableViewCellViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

struct PokemonTableViewCellViewModel: Equatable {
    private let keyword: String
    private let pokemonSearchResult: PokemonSearchResult
    
    init(keyword: String, pokemonSearchResult: PokemonSearchResult) {
        self.keyword = keyword
        self.pokemonSearchResult = pokemonSearchResult
    }
}

extension PokemonTableViewCellViewModel {
    var id: Int {
        pokemonSearchResult.id
    }
}

extension PokemonTableViewCellViewModel {
    var numberText: String? {
        return "\(pokemonSearchResult.id)"
    }
    
    var nameText: String? {
        return keyword.isEmpty == false ?
            pokemonSearchResult.name(for: keyword)
            :
            pokemonSearchResult.names.first
    }
}
