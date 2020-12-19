//
//  PokemonStatsTableViewCell.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit

class PokemonStatsTableViewCell: BaseTableViewCell {
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var koreanNameLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightValueLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    
    override func commonInit() {
        super.commonInit()
        
        pokemonImageView.image = nil
        koreanNameLabel.text = nil
        englishNameLabel.text = nil
        heightLabel.text = "키:"
        heightValueLabel.text = nil
        weightLabel.text = "몸무게:"
        weightValueLabel.text = nil
    }

    override class var nib: UINib? {
        return UINib(nibName: "PokemonStatsTableViewCell", bundle: nil)
    }
}

extension PokemonStatsTableViewCell: Bindable {
    func bind(_ viewModel: PokemonStatsTableViewCellViewModel) {
        pokemonImageView.loadImage(url: viewModel.imageUrl)
        koreanNameLabel.text = viewModel.koreaNameText
        englishNameLabel.text = viewModel.englishNameText
        heightValueLabel.text = viewModel.heightText
        weightValueLabel.text = viewModel.weightText
    }
}
