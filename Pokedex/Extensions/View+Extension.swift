//
//  View+Extension.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import SwiftUI

extension View {
    func onTap(_ action: @escaping () -> Void) -> some View {
        Button(action: action, label: {
            self
        })
    }
}
