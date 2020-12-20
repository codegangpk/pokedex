//
//  Sprites.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import Foundation

struct Sprites: Equatable {
    let front_default: URL?
    let etcs: [URL]?
    
    init?(spritesModel: SpritesModel?) {
        guard let spritesModel = spritesModel else { return nil }
        
        front_default = spritesModel.front_default
        etcs = [
            spritesModel.back_female,
            spritesModel.back_shiny_female,
            spritesModel.back_default,
            spritesModel.front_female,
            spritesModel.front_shiny_female,
            spritesModel.back_shiny,
            spritesModel.front_default,
            spritesModel.front_shiny
        ]
        .compactMap { $0 }
    }
}
