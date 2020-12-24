//
//  UIApplication+Extension.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit

extension UIApplication {
    static var keyWindow: UIWindow? {
        UIApplication.shared.windows.first(where: {
            $0.windowScene?.activationState == .foregroundActive && $0.isKeyWindow
        })
    }
}
