//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Paul Kim on 2020/12/19.
//

import UIKit

private enum Section {
    case pokemons
}

private enum Row: Equatable {
    case photo
    case name
    case height
    case weight
    case map
}

class PokemonViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource = DataSource<Section, Row>()
    private var viewModel = SearchViewViewModel()
}

extension PokemonViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ImageTableViewCell.nib, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        
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
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseIdentifier, for: indexPath) as! ImageTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension PokemonViewController {
    private func setupDataSource() {
        dataSource.removeAllSections()
        
        dataSource.appendSection(.pokemons, with: [])
    }
}

extension PokemonViewController {
    static func push(in viewController: UIViewController) {
        let pokemonViewController = PokemonViewController()
        viewController.navigationController?.pushViewController(pokemonViewController, animated: true)
    }
}
