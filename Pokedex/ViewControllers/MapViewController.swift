//
//  MapViewController.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import UIKit

class MapViewController: BaseViewController {
    private let viewModel: MapViewViewModel

    init(viewModel: MapViewViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension MapViewController {
    static func present(in viewController: UIViewController, pokemon: Pokemon, locations: [Location]) {
        let viewModel = MapViewViewModel(pokemon: pokemon, locations: locations)
        let mapViewController = MapViewController(viewModel: viewModel)
        mapViewController.configureCloseButton()
        let mapNavigationController = UINavigationController(rootViewController: mapViewController)
        viewController.navigationController?.present(mapNavigationController, animated: true, completion: nil)
    }
}
