//
//  LoaderView.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit

final class LoaderView: BaseView {
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    static let shared: LoaderView = LoaderView(frame: .zero)
    
    override func commonInit() {
        super.commonInit()
    }
    
    deinit {
        print("deinit LoaderView")
    }
}

extension LoaderView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
            
        activityIndicatorView.startAnimating()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        activityIndicatorView.stopAnimating()
    }
}
