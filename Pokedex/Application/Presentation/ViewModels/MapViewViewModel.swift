//
//  MapViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import UIKit

final class MapViewViewModel {
    let pokemonName: String
    let locations: [LocationAnnotation]

    init(pokemonName: String, locations: [Location]) {
        self.pokemonName = pokemonName
        self.locations = locations.compactMap { LocationAnnotation(location: $0) }
    }
}

extension MapViewViewModel {
    var titleText: String {
        return [pokemonName, "서식지"].joined(separator: " ")
    }
}
