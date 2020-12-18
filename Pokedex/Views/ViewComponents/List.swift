//
//  List.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import SwiftUI

struct List<Content: View> {
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

extension List: View {
    var body: some View {
        SwiftUI.List {
            content
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
        }
        .listStyle(PlainListStyle())
        .configureListStyle()
        .background(Color.clear)
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Text("")
        }
    }
}
