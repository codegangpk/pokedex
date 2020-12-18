//
//  ImageAssets.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import SwiftUI

enum SFSymbols: String {
    case xmarkCircleFill = "xmark.circle.fill"
        
    var image: Image {
        Image(systemName: self.rawValue)
    }
}
