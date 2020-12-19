//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit

private enum Section {
    case pokemon
}

private enum Row: Equatable {
    case pokemon(PokemonStatsTableViewCellViewModel)
}

class PokemonViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource = DataSource<Section, Row>()
    private var viewModel: PokemonViewViewModel
    
    init(viewModel: PokemonViewViewModel) {
        self.viewModel = viewModel

        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(PokemonStatsTableViewCell.nib, forCellReuseIdentifier: PokemonStatsTableViewCell.reuseIdentifier)
        
        subscribeToPokemon()
        subscribeForLoading(for: viewModel.utility.$isLoading)
        setupDataSource()
    }
}

extension PokemonViewController: UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonStatsTableViewCell.reuseIdentifier, for: indexPath) as! PokemonStatsTableViewCell
            cell.bind(viewModel)
            return cell
        }
    }
}

extension PokemonViewController {
    private func subscribeToPokemon() {
        viewModel.$pokemon
            .sink { [weak self] pokemon in
                guard let self = self else { return }
                
                self.setupDataSource(pokemon: pokemon)

                guard let section = self.dataSource.sectionIndex(of: .pokemon) else { return }
                
                self.tableView.reloadSections([section], with: .automatic)
            }
            .store(in: &subscribers)
    }
}

extension PokemonViewController {
    private func setupDataSource(pokemon: Pokemon? = nil) {
        dataSource.removeAllSections()
        
        self.dataSource.appendSection(.pokemon, with: [])
        if let viewModel = PokemonStatsTableViewCellViewModel(pokemonSearchResult: viewModel.pokemonSearchResult, pokemon: pokemon) {
            dataSource.append([.pokemon(viewModel)], in: .pokemon)
        }
    }
}

extension PokemonViewController {
    static func push(in viewController: UIViewController, pokemonSearchResult: PokemonSearchResult) {
        let viewModel = PokemonViewViewModel(pokemonSearchResult: pokemonSearchResult)
        let pokemonViewController = PokemonViewController(viewModel: viewModel)
        viewController.navigationController?.pushViewController(pokemonViewController, animated: true)
    }
}
