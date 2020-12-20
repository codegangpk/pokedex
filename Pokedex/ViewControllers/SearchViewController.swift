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
        
        navigationItem.titleView = SearchBar(placeholder: "포켓몬 이름을 입력해주세요.") { [weak self] _, text in
            guard let self = self else { return }
            
            self.viewModel.searchText = text
        }
        
        tableView.register(PokemonTableViewCell.nib, forCellReuseIdentifier: PokemonTableViewCell.reuseIdentifier)
        
        setupDataSource()
        
        subscribeForLoading(for: viewModel.utility.$isLoading)
        onPokemonViewModelsUpdated()
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
            PokemonViewController.push(in: self, pokemonSearchResult: viewModel.pokemonSearchResult)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}

extension SearchViewController {
    private func onPokemonViewModelsUpdated() {
        viewModel.$pokemonViewModels
            .sink { [weak self] value in
                guard let self = self else { return }
                
                self.setupDataSource()
                
                let rows: [Row] = value.compactMap { .pokemon($0) }
                self.dataSource.append(rows, in: .pokemons)
                
                guard let section = self.dataSource.sectionIndex(of: .pokemons) else { return }
                
                self.tableView.reloadSections([section], with: .automatic)
            }
            .store(in: &subscribers)
    }
}

extension SearchViewController {
    private func setupDataSource() {
        dataSource.removeAllSections()
        
        dataSource.appendSection(.pokemons, with: [])
    }
}
