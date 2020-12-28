//
//  SearchViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import Foundation
import RxSwift

final class SearchViewViewModel: BaseViewViewModel {
    private let pokemonUseCase: PokemonUseCase
    
    let pokemonSearchResults: BehaviorSubject<[PokemonSearchResult]> = .init(value: [])
    let searchText:  BehaviorSubject<String> = .init(value: "")
    let pokemonViewModels: BehaviorSubject<[PokemonTableViewCellViewModel]> = .init(value: [])
    
    init(pokemonUseCase: PokemonUseCase = PokemonUseCase()) {
        self.pokemonUseCase = pokemonUseCase
        
        super.init()

        getPokemonList()
        subscribeForSearchText()
    }
}

extension SearchViewViewModel {
    func getPokemonList() {
        beginNetworkRequest()
        pokemonUseCase
            .getPokemonList()
            .observeOn(RxSchedulers.globalUserInitiated)
            .map { $0.pokemons ?? [] }
            .observeOn(RxSchedulers.main)
            .subscribe { [weak self] in
                guard let self = self else { return }
                
                self.completeNetworkRequest(completion: $0)
                
                switch $0 {
                case .next(let pokemons):
                    self.pokemonSearchResults.onNext(pokemons)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func subscribeForSearchText() {
        Observable.combineLatest(searchText, pokemonSearchResults)
            .observeOn(RxSchedulers.globalUserInitiated)
            .map { searchText, pokemonSearchResults in
                pokemonSearchResults.filter {
                    guard searchText.isEmpty == false else { return true }
                    
                    return $0.name(for: searchText) != nil
                }
                .compactMap { PokemonTableViewCellViewModel(keyword: searchText, pokemonSearchResult: $0) }
            }
            .observeOn(RxSchedulers.main)
            .filter { try self.pokemonViewModels.value() != $0 }
            .subscribe { [weak self] in
                guard let self = self else { return }
                
                self.completeNetworkRequest(completion: $0)
                
                switch $0 {
                case .next(let viewModels):
                    self.pokemonViewModels.onNext(viewModels)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}

