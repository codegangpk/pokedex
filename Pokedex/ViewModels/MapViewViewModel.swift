//
//  MapViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import Foundation

class MapViewViewModel {
    let pokemonName: String
    let locations: [Location]

    init(pokemonName: String, locations: [Location]) {
        self.pokemonName = pokemonName
        self.locations = locations
    }
}

extension MapViewViewModel {
    var titleText: String {
        return [pokemonName, "서식지"].joined(separator: " ")
    }
}
