//
//  SearchBar.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit

final class SearchBar: UISearchBar {
    typealias DidTextChanged = (UISearchBar, String) -> Void
    private let didTextChanged: DidTextChanged
    
    init(placeholder: String? = nil, didTextChanged: @escaping DidTextChanged) {
        self.didTextChanged = didTextChanged
        
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchBar: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        setShowsCancelButton(false, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        didTextChanged(self, searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
