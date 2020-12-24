//
//  Location.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import Foundation

struct Location: Equatable {
    let lat: Double
    let lng: Double
    let id: Int
    
    init?(locationModel: LocationModel?) {
        guard let locationModel = locationModel,
              let lat = locationModel.lat,
              let lng = locationModel.lng,
              let id = locationModel.id
        else { return nil }
        
        self.lat = lat
        self.lng = lng
        self.id = id
    }
}
