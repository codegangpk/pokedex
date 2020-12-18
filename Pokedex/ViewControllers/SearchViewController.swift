//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit

private enum Section {
    case pokemons
}

private enum Row {
    case pokemon
}

class SearchViewController: BaseViewController {
    private var dataSource = DataSource<Section, Row>()
    
    private let viewModel = SearchViewViewModel()
    
    override init() {
        super.init()
        
        title = "포켓몬 도감"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.$searchText.sink { _ in
            
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = dataSource.item(for: indexPath)
        
        switch row {
        case .pokemon:
            return UITableViewCell()
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
}
