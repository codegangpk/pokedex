//
//  UIImageView+Extension.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: URL?, options: KingfisherOptionsInfo? = [.transition(.fade(0.2))], completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        guard let url = url else { return }
        
        self.kf.setImage(with: url, options: options, completionHandler: completion)
    }
}
