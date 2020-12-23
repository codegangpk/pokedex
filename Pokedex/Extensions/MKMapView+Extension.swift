//
//  MKMapView+Extension.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import MapKit

extension MKMapView {
    func showRegion(for annotations: [MKAnnotation]) {
        let region: MKCoordinateRegion
        switch annotations.count {
        case 0:
            return
        case 1:
            let annotation = annotations.first!
            region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        default:
            var topLeft = CLLocationCoordinate2D(latitude: -90, longitude: 180)
            var bottomRight = CLLocationCoordinate2D(latitude: 90, longitude: -180)
            
            annotations.forEach { (annotation) in
                print("annotations: \(annotation)")
                topLeft.latitude = max(topLeft.latitude, annotation.coordinate.latitude)
                topLeft.longitude = min(topLeft.longitude, annotation.coordinate.longitude)
                bottomRight.latitude = min(bottomRight.latitude, annotation.coordinate.latitude)
                bottomRight.longitude = max(bottomRight.longitude, annotation.coordinate.longitude)
            }
            
            let center = CLLocationCoordinate2D(
                latitude: (topLeft.latitude + bottomRight.latitude) / 2,
                longitude: (topLeft.longitude + bottomRight.longitude) / 2
            )
            let extraSpace = 3.0
            let span = MKCoordinateSpan(
                latitudeDelta: abs(topLeft.latitude - bottomRight.latitude) * extraSpace,
                longitudeDelta: abs(bottomRight.longitude - topLeft.longitude) * extraSpace
            )
            
            region = MKCoordinateRegion(center: center, span: span)
            print("region: \(region)")
        }
        let regionThatFits = self.regionThatFits(region)
        setRegion(regionThatFits, animated: true)
    }

}
