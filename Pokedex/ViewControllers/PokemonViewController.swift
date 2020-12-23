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
    override func configureView() {
        super.configureView()
        
        tableView.register(PokemonStatsTableViewCell.nib, forCellReuseIdentifier: PokemonStatsTableViewCell.reuseIdentifier)
        
        setupDataSource()
    }
    
    override func addSubscribers() {
        super.addSubscribers()
        
        subscribeToPokemon()
        subscribeToLocations()
        subscribeForLoading(for: viewModel)
        subscribeForNetworkError(for: viewModel) { [weak self] _ in
            guard let self = self else { return }
            
            self.showNetworkErrorAlert()
        }
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
        viewModel.$pokemonViewModel
            .sink { [weak self] viewModel in
                guard let self = self else { return }
                
                defer {
                    if let section = self.dataSource.sectionIndex(of: .pokemon) {
                        self.tableView.reloadSections([section], with: .automatic)
                    }
                }
                
                guard let viewModel = viewModel else {
                    self.setupDataSource()
                    return
                }
                
                self.dataSource.append([.pokemon(viewModel)], in: .pokemon)
            }
            .store(in: &subscribers)
    }
    
    private func subscribeToLocations() {
        viewModel.$locations
            .sink { [weak self] locations in
                guard let self = self else { return }
                guard locations?.isEmpty == false else { return }
                
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "지도 보기", style: .plain, target: self, action: #selector(self.onMapTapped(_:)))
            }
            .store(in: &subscribers)
    }
}

extension PokemonViewController {
    @objc private func onMapTapped(_ sender: UIBarButtonItem) {
        guard let locations = viewModel.locations else { return }
        
        MapViewController.present(in: self, pokemonName: viewModel.pokemonSearchResult.koreanName, locations: locations)
    }
}

extension PokemonViewController {
    private func setupDataSource(pokemon: Pokemon? = nil) {
        dataSource.removeAllSections()
        
        self.dataSource.appendSection(.pokemon, with: [])
    }
}

extension PokemonViewController {
    static func push(in viewController: UIViewController, pokemonSearchResult: PokemonSearchResult) {
        let viewModel = PokemonViewViewModel(pokemonSearchResult: pokemonSearchResult)
        let pokemonViewController = PokemonViewController(viewModel: viewModel)
        viewController.navigationController?.pushViewController(pokemonViewController, animated: true)
    }
}
