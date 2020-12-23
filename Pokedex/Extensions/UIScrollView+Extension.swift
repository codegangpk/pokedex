//
//  UIScrollView+Extension.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/23.
//

import UIKit

extension UIScrollView {
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.layer.zPosition = -1
        refreshControl.addTarget(self, action: #selector(refreshControlDidChange(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    @objc func refreshControlDidChange(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
    }
    
    func afterRefreshControlIsFinished(completion: @escaping () -> Void) {
        guard refreshControl?.isRefreshing == true else { return }
        
        afterDelay(0.5) { [weak self] in
            guard let self = self else { return }
            
            self.refreshControl?.endRefreshing()
            
            afterDelay(0.5) {
                completion()
            }
        }
    }
}
