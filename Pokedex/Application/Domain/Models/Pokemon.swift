//
//  Pokemon.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import Foundation

struct Pokemon: Equatable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites?
    
    init?(pokemonModel: PokemonModel?) {
        guard let pokemonModel = pokemonModel,
              let id = pokemonModel.id,
              let name = pokemonModel.name,
              let height = pokemonModel.height,
              let weight = pokemonModel.weight
        else { return nil }
        
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.sprites = Sprites(spritesModel: pokemonModel.sprites)
    }
}
