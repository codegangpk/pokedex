//
//  MapViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/20.
//

import UIKit

final class MapViewViewModel {
    let pokemonName: String
    let locations: [LocationAnnotation]

    init(pokemonName: String, locations: [Location]) {
        self.pokemonName = pokemonName
        self.locations = locations.compactMap { LocationAnnotation(location: $0) }
    }
}

extension MapViewViewModel {
    var titleText: String {
        return [pokemonName, "서식지"].joined(separator: " ")
    }
    
    func edgePadding(with safeAreaInsets: UIEdgeInsets) -> UIEdgeInsets {
        let edgeInset: CGFloat = 50
        return UIEdgeInsets(
            top: safeAreaInsets.top + edgeInset,
            left: safeAreaInsets.left + edgeInset,
            bottom: safeAreaInsets.bottom + edgeInset,
            right: safeAreaInsets.right + edgeInset
        )
    }
}
