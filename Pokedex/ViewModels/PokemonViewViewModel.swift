//
//  PokemonViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

class PokemonViewViewModel: BaseViewViewModel, ObservableObject {
    private let id: Int
    private let pokemonRepository: PokemonRepository
    
    init(id: Int, pokemonRepository: PokemonRepository = PokemonRepository()) {
        self.id = id
        self.pokemonRepository = pokemonRepository
    }
}
