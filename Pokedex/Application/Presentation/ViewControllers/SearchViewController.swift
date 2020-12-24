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

private enum Row: Equatable {
    case pokemon(PokemonTableViewCellViewModel)
}

final class SearchViewController: BaseViewController {
    @IBOutlet private weak var tableView: UITableView!
    
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
    override func configureView() {
        super.configureView()
        
        navigationItem.titleView = SearchBar(placeholder: "포켓몬 이름을 입력해주세요.") { [weak self] _, text in
            guard let self = self else { return }
            
            self.viewModel.searchText = text
        }
        
        tableView.register(PokemonTableViewCell.nib, forCellReuseIdentifier: PokemonTableViewCell.reuseIdentifier)
        tableView.addRefreshControl()
        
        setupDataSource()
    }
    
    override func addSubscribers() {
        super.addSubscribers()
        
        subscribeForLoading(for: viewModel)
        subscribeForNetworkError(for: viewModel) { [weak self] _ in
            guard let self = self else { return }
            
            self.showNetworkErrorAlert()
        }
        subscribeForPokemonViewModels()
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
            navigationItem.titleView?.endEditing(true)
            PokemonViewController.push(in: self, pokemonSearchResult: viewModel.pokemonSearchResult)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == tableView else { return }
        
        tableView.afterRefreshControlIsFinished { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.getPokemonList()
        }
    }
}

extension SearchViewController {
    private func subscribeForPokemonViewModels() {
        viewModel.$pokemonViewModels
            .sink { [weak self] viewModels in
                guard let self = self else { return }
                
                self.dataSource.removeAllItems(in: .pokemons)
                let rows: [Row] = viewModels.compactMap { .pokemon($0) }
                self.dataSource.append(rows, in: .pokemons)
                
                self.tableView.reloadData()
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
