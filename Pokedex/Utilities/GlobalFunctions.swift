//
//  GlobalFunctions.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import Foundation

func afterDelay(_ seconds: Double = 0, run: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: run)
}

func print(_ items: Any...) {
    #if DEBUG
    Swift.print(items)
    #endif
}
