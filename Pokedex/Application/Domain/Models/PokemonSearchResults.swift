//
//  PokemonSearchResults.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

struct PokemonSearchResults {
    let pokemons: [PokemonSearchResult]?
    
    init?(pokemonSearchResultsModel: PokemonSearchResultsModel?) {
        guard let pokemonSearchResultsModel = pokemonSearchResultsModel else { return nil }
        
        self.pokemons = pokemonSearchResultsModel.pokemons?
            .compactMap { PokemonSearchResult(pokemonSearchResultModel: $0) }
    }
}
