//
//  TableViewStyle.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import SwiftUI

struct TableViewStyle: ViewModifier {
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func configureListStyle() -> some View {
        self.modifier(TableViewStyle())
    }
}
