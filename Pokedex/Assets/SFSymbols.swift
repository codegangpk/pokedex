//
//  ImageAssets.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/18.
//

import UIKit

enum SFSymbols: String {
    case xmarkCircleFill = "xmark.circle.fill"
        
    var image: UIImage? {
        UIImage(systemName: self.rawValue)
    }
}
