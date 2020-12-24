//
//  Locations.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import Foundation

struct Locations: Equatable {
    let pokemons: [Location]?
    
    init?(locationsModel: LocationsModel?) {
        guard let locationsModel = locationsModel else { return nil }
        
        self.pokemons = locationsModel.pokemons?.compactMap { Location(locationModel: $0) }
    }
}
