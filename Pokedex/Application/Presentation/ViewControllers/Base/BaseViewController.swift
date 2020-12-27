//
//  BaseViewController.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit
import RxSwift

//WARNING: do not configure or customize!! use only for setting lightweight style
class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseViewController {
    final override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        addSubscribers()
    }
}

extension BaseViewController {
    @objc func configureView() {
        
    }
    
    @objc func addSubscribers() {
        
    }
}

extension BaseViewController {
    func subscribeForLoading(for viewModel: BaseViewViewModel) {
        viewModel.isLoading
            .subscribe { [weak self] in
                guard let self = self else { return }
                
                switch $0 {
                case .next(let isLoading):
                    if isLoading {
                        self.view.showLoader()
                    } else {
                        self.view.hideLoader()
                    }
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    func subscribeForNetworkError(for viewModel: BaseViewViewModel, errorHandler: @escaping (NetworkError) -> Void) {
        viewModel.networkError
            .subscribe {
                switch $0 {
                case .next(let networkError):
                    guard let networkError = networkError else { return }
                    
                    errorHandler(networkError)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}

extension BaseViewController {
    func configureCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: SFSymbols.close.image, style: .plain, target: self, action: #selector(onClose(_:)))
    }
}

extension BaseViewController {
    @objc private func onClose(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
