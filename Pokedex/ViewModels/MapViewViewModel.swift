//
//  MapViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import Foundation

class MapViewViewModel {
    let pokemon: Pokemon
    let locations: [Location]

    init(pokemon: Pokemon, locations: [Location]) {
        self.pokemon = pokemon
        self.locations = locations
    }
}
