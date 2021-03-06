//
//  PokemonRepositoriable.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/24.
//

import Foundation
import Combine

protocol PokemonRepositoriable: Repositoriable {
    func getPokemon(id: Int) -> AnyPublisher<Pokemon, NetworkError>
}
