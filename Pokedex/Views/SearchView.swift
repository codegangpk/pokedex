//
//  SearchView.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import SwiftUI

struct SearchView {
    @ObservedObject private var viewModel: SearchViewViewModel
    
    init(viewModel: SearchViewViewModel) {
        self.viewModel = viewModel
    }
}

extension SearchView: View {
    var body: some View {
        VStack {
            SearchBar(searchText: $viewModel.searchText)
            List {
                ForEach(0..<100) { _ in
                    PokemonRow()
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewViewModel())
    }
}
