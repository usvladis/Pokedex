//
//  PokemonList.swift
//  Pokedex
//
//  Created by Владислав Усачев on 11.05.2024.
//

import Foundation

struct PokemonMock {
    var name: String
    var imageName: String
}

struct TestData {
    static func generateTestData() -> [PokemonMock] {
        return [
            PokemonMock(name: "Bulbasaur", imageName: "bulbasaur"),
            PokemonMock(name: "Charmander", imageName: "charmander"),
            PokemonMock(name: "Squirtle", imageName: "squirtle"),
            PokemonMock(name: "Pikachu", imageName: "pikachu"),
            PokemonMock(name: "Jigglypuff", imageName: "jigglypuff"),
            PokemonMock(name: "Snorlax", imageName: "snorlax"),
            PokemonMock(name: "Mewtwo", imageName: "mewtwo"),
            PokemonMock(name: "Gyarados", imageName: "gyarados"),
            PokemonMock(name: "Dragonite", imageName: "dragonite"),
            PokemonMock(name: "Eevee", imageName: "eevee")
        ]
    }
}
