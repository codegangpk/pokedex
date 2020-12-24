//
//  ResistantLayer.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import UIKit

// workaround for flickering MKAnnotationView : override MKMapView's attempt to modify layer (zPosition)
//https://stackoverflow.com/questions/46518725/mapkit-mkmapview-zposition-does-not-work-anymore-on-ios11
final class ResistantLayer: CALayer {
    override var zPosition: CGFloat {
        get { return super.zPosition }
        set {}
    }
    var resistantZPosition: CGFloat {
        get { return super.zPosition }
        set { super.zPosition = newValue }
    }
}
