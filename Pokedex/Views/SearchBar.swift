//
//  SearchBar.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            TextField("포켓몬 이름을 입력하세요.", text: $searchText)
            Divider()
        }
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
