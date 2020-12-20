//
//  PokemonStatsTableViewCellViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import Foundation

struct PokemonStatsTableViewCellViewModel: Equatable {
    private let pokemonSearchResult: PokemonSearchResult
    private let pokemon: Pokemon
    
    init?(pokemonSearchResult: PokemonSearchResult?, pokemon: Pokemon?) {
        guard let pokemonSearchResult = pokemonSearchResult,
              let pokemon = pokemon
        else { return nil }
        
        self.pokemonSearchResult = pokemonSearchResult
        self.pokemon = pokemon
    }
}

extension PokemonStatsTableViewCellViewModel {
    var imageUrl: URL? {
        return pokemon.sprites?.front_default ?? pokemon.sprites?.etcs?.first
    }
    
    var koreaNameText: String? {
        return pokemonSearchResult.koreanName
    }
    
    var englishNameText: String? {
        return pokemonSearchResult.englishName
    }
    
    var heightText: String? {
        return "\(pokemon.height)"
    }
    
    var weightText: String? {
        return "\(pokemon.weight)"
    }
}
