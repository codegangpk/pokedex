//
//  SearchViewViewModel.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import Foundation

class SearchViewViewModel: ObservableObject {
    @Published var searchText: String = ""
}
