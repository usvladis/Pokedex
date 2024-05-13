//
//  PokedexCell.swift
//  Pokedex
//
//  Created by Владислав Усачев on 10.05.2024.
//

import UIKit

class PokedexViewController: UIViewController{
    
    var pokemonList = [Pokemon]()
    @IBOutlet var tableView: UITableView!
    let pokemonApi = PokemonAPIManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start")
        tableView.rowHeight = 150
        PokemonAPIManager.fetchPokemonData { [weak self] pokemonList, error in
            guard let self = self else { return }
            
            if let error = error {
                // Обработка ошибки, если запрос не удался
                print("Error fetching Pokemon data: \(error)")
                return
            }
            
            if let pokemonList = pokemonList {
                // Обновляем пользовательский интерфейс с полученными данными
                DispatchQueue.main.async {
                    // Присваиваем полученный список покемонов массиву данных
                    self.pokemonList = pokemonList
                    // Перезагружаем таблицу для отображения данных
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func config(for cell: PokemonListCell, indexPath: IndexPath) {
        let pokemon = pokemonList[indexPath.row]
        cell.nameLabel.text = pokemon.name
        PokemonAPIManager.fetchPokemonImageURL(for: pokemon.name) { imageURL in
            DispatchQueue.main.async {
                if let imageURL = imageURL {
                    cell.loadImage(from: imageURL)
                    } else {
                    cell.pokemonImage.image = UIImage(named: "bulbasaur")
                    }
                }
            }
        }
    }

extension PokedexViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension PokedexViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListCell.reuseIdentifier, for: indexPath)
        
        guard let pokemonListCell = cell as? PokemonListCell else {
            return UITableViewCell()
        }
        config(for: pokemonListCell, indexPath: indexPath)
        return pokemonListCell
    }
}
