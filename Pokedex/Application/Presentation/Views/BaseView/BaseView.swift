//
//  BaseView.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//


import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() {
        loadNib()
    }
}

extension UIView {
    func loadNib() {
        let nibName = String(describing: type(of: self))
        print("nibName: \(nibName)")
        
        do {
            let unableToFindNibError = RuntimeError("$$nibNamed: \(nibName) doesn't exist")
            
            guard Bundle.main.path(forResource: nibName, ofType: "nib") != nil else { throw unableToFindNibError }
            guard let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first(where: { $0 is UIView }) as? UIView else { throw unableToFindNibError }
        
            view.frame = bounds
            addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        } catch {
            print(error)
        }
    }
}
