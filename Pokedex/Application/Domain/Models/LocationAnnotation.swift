//
//  LocationAnnotation.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import Foundation
import MapKit

final class LocationAnnotation: NSObject {
    let latitude: Double
    let longitude: Double
    
    init?(location: Location?) {
        guard let location = location else { return nil }
        
        self.latitude = location.lat
        self.longitude = location.lng
    }
}

extension LocationAnnotation: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
