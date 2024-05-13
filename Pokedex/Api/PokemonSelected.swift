//
//  PokemonSelected.swift
//  Pokedex
//
//  Created by Владислав Усачев on 12.05.2024.
//

import Foundation

struct PokemonSelected: Codable{
    var image: PokemonImage
    var weight: Int
}

struct PokemonImage: Codable{
    var front_default: String?
}

class PokemonSelectedApi {
    func getData(url: String, completion: @escaping (PokemonImage) -> ()) {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard let data else {return}
            
            let pokemonImage = try! JSONDecoder().decode(PokemonSelected.self, from: data)
            DispatchQueue.main.async {
                completion(pokemonImage.image)
            }
        }.resume()
    }
}
