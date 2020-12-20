//
//  MapViewController.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {
    @IBOutlet weak var mapView: MKMapView!
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.register(LocationAnnotationView.self, forAnnotationViewWithReuseIdentifier: LocationAnnotationView.reuseIdentifier)
        
        mapView.addAnnotations(viewModel.locations)
        mapView.showAnnotations(viewModel.locations, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.mapView.setVisibleMapRect(
            self.mapView.visibleMapRect,
            edgePadding: viewModel.edgePadding(with: view.safeAreaInsets),
            animated: false
        )
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
