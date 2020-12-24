//
//  UIViewController+Extension.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/22.
//

import UIKit

extension UIViewController {
    func showSingleActionAlert(title: String?, message: String? = nil, actionTitle: String? = "확인", handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default) { (_) in
            handler?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showNetworkErrorAlert() {
        self.showSingleActionAlert(title: "네트워크 에러", message: "네트워크 에러가 발생했습니다.")
    }
}
