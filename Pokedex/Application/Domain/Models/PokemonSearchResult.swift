//
//  PokemonSearchResult.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

struct PokemonSearchResult: Equatable {
    let id: Int
    let koreanName: String
    let englishName: String
    
    init?(pokemonSearchResultModel: PokemonSearchResultModel?) {
        guard let pokemonSearchResultModel = pokemonSearchResultModel,
              let id = pokemonSearchResultModel.id,
              let koreanName = pokemonSearchResultModel.names?.first, koreanName.isEmpty == false,
              let englishName = pokemonSearchResultModel.names?.last, englishName.isEmpty == false
        else { return nil }
        
        self.id = id
        self.koreanName = koreanName
        self.englishName = englishName
    }
}

extension PokemonSearchResult {
    func name(for keyword: String) -> String? {
        
        switch keyword {
        case keyword where koreanName.lowercased().contains(keyword.lowercased()):
            return koreanName
        case keyword where englishName.lowercased().contains(keyword.lowercased()):
            return englishName
        default:
            return nil
        }
    }
}
