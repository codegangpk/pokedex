//
//  PokemonViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation
import RxSwift

final class PokemonViewViewModel: BaseViewViewModel {
    private let pokemonSearchResult: PokemonSearchResult
    private let pokemonUseCase: PokemonUseCase
    
    let pokemonViewModel: BehaviorSubject<PokemonStatsTableViewCellViewModel?> = .init(value: nil)
    let locations: BehaviorSubject<[Location]?> = .init(value: nil)
    
    init(pokemonSearchResult: PokemonSearchResult,
         pokemonUseCase: PokemonUseCase = PokemonUseCase()
    ) {
        self.pokemonSearchResult = pokemonSearchResult
        self.pokemonUseCase = pokemonUseCase

        super.init()
        
        getPokemon(id: pokemonId)
        getLocations(id: pokemonId)
    }
}

extension PokemonViewViewModel {
    var pokemonId: Int {
        return pokemonSearchResult.id
    }
    
    var pokemonName: String {
        return pokemonSearchResult.koreanName
    }
}

extension PokemonViewViewModel {
    func getPokemon(id: Int) {
        beginNetworkRequest()
        pokemonUseCase
            .getPokemon(id: id)
            .observeOn(RxSchedulers.globalUserInitiated)
            .compactMap {
                PokemonStatsTableViewCellViewModel(pokemonSearchResult: self.pokemonSearchResult, pokemon: $0)
            }
            .observeOn(RxSchedulers.main)
            .filter { try $0 != self.pokemonViewModel.value() }
            .subscribe { [weak self] in
                guard let self = self else { return }
                
                self.completeNetworkRequest(completion: $0)
                
                switch $0 {
                case .next(let viewModel):
                    self.pokemonViewModel.onNext(viewModel)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    func getLocations(id: Int) {
        pokemonUseCase
            .getLocations()
            .observeOn(RxSchedulers.globalUserInitiated)
            .compactMap { $0.pokemons?.filter { $0.id == id } }
            .observeOn(RxSchedulers.main)
            .subscribe { [weak self] in
                guard let self = self else { return }
                
                switch $0 {
                case .next(let locations):
                    self.locations.onNext(locations)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}
