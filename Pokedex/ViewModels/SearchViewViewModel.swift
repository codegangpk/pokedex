//
//  SearchViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import Foundation

class SearchViewViewModel: BaseViewViewModel, ObservableObject {
    @Published var searchText: String = ""
}
