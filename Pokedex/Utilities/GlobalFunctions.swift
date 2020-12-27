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

func print(_ object: Any) {
    #if DEBUG
    Swift.print(object)
    #endif
}

func print(_ objects: Any...) {
    #if DEBUGa
    Swift.print(objects)
    #endif
}
