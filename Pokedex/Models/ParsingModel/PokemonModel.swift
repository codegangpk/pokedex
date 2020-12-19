//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import Foundation

struct PokemonModel: Codable {
    let id: Int?
    let name: String?
    let height: Int?
    let weight: Int?
    let sprites: SpritesModel?
}
