//
//  PokemonMockingRepositoriable.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/24.
//

import Foundation
import RxSwift

protocol PokemonMockingRepositoriable: Repositoriable {
    func getPokemonList() -> Observable<PokemonSearchResults>
    func getLocations() -> Observable<Locations>
}
