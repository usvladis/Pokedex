//
//  PokedexViewCell.swift
//  Pokedex
//
//  Created by Владислав Усачев on 11.05.2024.
//

import UIKit

class PokemonListCell: UITableViewCell {
    static let reuseIdentifier = "PokemonListCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var button: UIButton!

    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url),
                  let image = UIImage(data: imageData) {
                   DispatchQueue.main.async {
                       self?.pokemonImage.image = image
                   }
               } else {
                   DispatchQueue.main.async {
                       // Если изображение не может быть загружено, используем заглушку
                       self?.pokemonImage.image = UIImage(named: "placeholder_image")
                }
            }
        }
    }
}
