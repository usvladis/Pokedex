//
//  PokemonApi.swift
//  Pokedex
//
//  Created by Владислав Усачев on 12.05.2024.
//
// https://pokeapi.co/api/v2/pokemon?limit=151
import Foundation

struct PokemonListResponse: Codable {
    let results: [PokemonResult]
}

struct PokemonResult: Codable {
    let name: String
    let url: String
}

// Модель данных покемона
struct Pokemon {
    let name: String
    let url: String
}

// Модель данных покемона для получения URL изображения
struct PokemonData: Codable {
    let sprites: Sprites
}

struct Sprites: Codable {
    let front_default: String?
}

class PokemonAPIManager {
    
    // Метод для выполнения запроса к API и получения данных о покемонах
    static func fetchPokemonData(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=151" // URL для получения данных о первых 151 покемоне
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: -2, userInfo: nil))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemonListResponse = try decoder.decode(PokemonListResponse.self, from: data)
                
                // Преобразование данных из API в массив объектов Pokemon
                let pokemonList: [Pokemon] = pokemonListResponse.results.map { result in
                    let name = result.name
                    let url = result.url
                    return Pokemon(name: name, url: url)
                }
                
                completion(pokemonList, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    static func fetchPokemonImageURL(for pokemon: String, completion: @escaping (URL?) -> Void) {
            let urlString = "https://pokeapi.co/api/v2/pokemon/\(pokemon)/"
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let pokemonData = try decoder.decode(PokemonData.self, from: data)
                    
                    // Получаем URL изображения покемона
                    if let imageURLString = pokemonData.sprites.front_default, let imageURL = URL(string: imageURLString) {
                        completion(imageURL)
                    } else {
                        completion(nil)
                    }
                } catch {
                    completion(nil)
                }
            }.resume()
        }
    }

