//
//  LocationAnnotationView.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import Foundation
import MapKit

class LocationAnnotationView: MKMarkerAnnotationView {
    override class var layerClass: AnyClass {
        return ResistantLayer.self
    }
    
    var resistantLayer: ResistantLayer {
        return self.layer as! ResistantLayer
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        displayPriority = .required
        clusteringIdentifier = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
