//
//  MapViewController.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import UIKit
import MapKit

final class MapViewController: BaseViewController {
    @IBOutlet private weak var mapView: MKMapView!
    
    private let viewModel: MapViewViewModel

    init(viewModel: MapViewViewModel) {
        self.viewModel = viewModel
        
        super.init()
        
        title = viewModel.titleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapViewController {
    override func configureView() {
        super.configureView()
        
        mapView.register(LocationAnnotationView.self, forAnnotationViewWithReuseIdentifier: LocationAnnotationView.reuseIdentifier)
        
        mapView.addAnnotations(viewModel.locations)
        mapView.showRegion(for: viewModel.locations)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: LocationAnnotationView.reuseIdentifier, for: annotation) as! LocationAnnotationView
        return annotationView
    }
}

extension MapViewController {
    static func present(in viewController: UIViewController, pokemonName: String, locations: [Location]) {
        let viewModel = MapViewViewModel(pokemonName: pokemonName, locations: locations)
        let mapViewController = MapViewController(viewModel: viewModel)
        mapViewController.configureCloseButton()
        let mapNavigationController = UINavigationController(rootViewController: mapViewController)
        viewController.navigationController?.present(mapNavigationController, animated: true, completion: nil)
    }
}
