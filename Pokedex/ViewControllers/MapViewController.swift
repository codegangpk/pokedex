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
        
        mapView.addAnnotations(viewModel.locations)
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
