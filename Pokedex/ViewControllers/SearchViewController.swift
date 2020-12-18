//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit
import Combine

private enum Section {
    case pokemons
}

private enum Row: Equatable {
    case pokemon(PokemonTableViewCellViewModel)
}

class SearchViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource = DataSource<Section, Row>()
    private var viewModel = SearchViewViewModel()
    
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
        
        tableView.register(PokemonTableViewCell.nib, forCellReuseIdentifier: PokemonTableViewCell.reuseIdentifier)
        
        setupDataSource()
        
        onPokemonViewModelsUpdated()
        onSearchTextUpdated()

        self.viewModel.getPokemonList()
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
        case .pokemon(let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.reuseIdentifier, for: indexPath) as! PokemonTableViewCell
            cell.bind(viewModel)
            return cell
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = dataSource.item(for: indexPath)
        switch row {
        case .pokemon(let viewModel):
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}

extension SearchViewController {
    private func onPokemonViewModelsUpdated() {
        viewModel.$pokemonViewModels.sink { value in
            self.setupDataSource()
            
            let rows: [Row] = value.compactMap { .pokemon($0) }
            self.dataSource.append(rows, in: .pokemons)
            
            guard let section = self.dataSource.sectionIndex(of: .pokemons) else { return }
            
            self.tableView.reloadSections([section], with: .automatic)
        }
        .store(in: &subscribers)
    }
    
    private func onSearchTextUpdated() {
        viewModel.$searchText.sink { _ in
            
        }
    }
}

extension SearchViewController {
    private func setupDataSource() {
        dataSource.removeAllSections()
        
        dataSource.appendSection(.pokemons, with: [])
    }
}
