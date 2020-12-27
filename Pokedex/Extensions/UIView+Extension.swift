//
//  UIView+Extension.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit

extension UIView {
    func showLoader() {
        guard subviews.contains(where: { $0 is LoaderView }) == false else { return }
        
        let loaderView = LoaderView()
        addSubview(loaderView)
        loaderView.constraintAllEdges(to: self)
    }
    
    func hideLoader() {
        subviews.forEach {
            guard $0 is LoaderView else { return }
            
            $0.removeFromSuperview()
        }
    }
}

extension UIView {
    func constraintAllEdges(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
