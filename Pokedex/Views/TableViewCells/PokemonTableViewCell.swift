//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit

class PokemonTableViewCell: BaseTableViewCell {
    
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    
    override func commonInit() {
        super.commonInit()
        
        numberLabel.text = nil
        nameLabel.text = nil
    }
    
    override class var nib: UINib? {
        return UINib(nibName: "PokemonTableViewCell", bundle: nil)
    }
}

extension PokemonTableViewCell: Bindable {
    func bind(_ viewModel: PokemonTableViewCellViewModel) {
        numberLabel.text = viewModel.numberText
        nameLabel.text = viewModel.nameText
    }
}
