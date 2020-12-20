//
//  BaseViewController.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit
import Combine

//WARNING: do not configure or customize!! use only for setting lightweight style
class BaseViewController: UIViewController {
    private let viewModel = BaseViewViewModel()
    var subscribers = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseViewController {
    func subscribeForLoading(for isLoading: Published<Bool>.Publisher) {
        isLoading.sink { [weak self] in
            guard let self = self else { return }
            
            if $0 {
                self.view.showLoader()
            } else {
                self.view.hideLoader()
            }
        }
        .store(in: &subscribers)
    }
}