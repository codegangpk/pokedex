//
//  PokemonRepositoriable.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/24.
//

import Foundation
import RxSwift

protocol PokemonRepositoriable: Repositoriable {
    func getPokemon(id: Int) -> Observable<Pokemon>
}
