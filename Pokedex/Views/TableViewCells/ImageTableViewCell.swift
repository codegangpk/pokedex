//
//  ImageTableViewCell.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit

class ImageTableViewCell: BaseTableViewCell {
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func commonInit() {
        super.commonInit()
        
        pokemonImageView.image = nil
    }

    override class var nib: UINib? {
        return UINib(nibName: "ImageTableViewCell", bundle: nil)
    }
}

extension ImageTableViewCell {
    func configure(url: URL?) {
        pokemonImageView.loadImage(url: url)
    }
}
