//
//  PokemonSearchResult.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

struct PokemonSearchResult: Equatable {
    let id: Int
    let names: [String]
    
    init?(pokemonSearchResultModel: PokemonSearchResultModel?) {
        guard let pokemonSearchResultModel = pokemonSearchResultModel,
              let id = pokemonSearchResultModel.id,
              let names = pokemonSearchResultModel.names, names.isEmpty == false
        else { return nil }
        
        self.id = id
        self.names = names
    }
}
