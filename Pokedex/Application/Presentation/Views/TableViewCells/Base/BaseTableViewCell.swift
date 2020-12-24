//
//  BaseTableViewCell.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    private var topSeparatorView: UIView?
    private var bottomSeparatorView: UIView?
    
    final override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }

    final override func prepareForReuse() {
        super.prepareForReuse()
        
        commonInit()
    }
    
    class var nib: UINib? {
        return UINib(nibName: "BaseTableViewCell", bundle: nil)
    }
}

extension BaseTableViewCell {
    @objc func commonInit() {}
}
