//
//  Elemento.swift
//  RestJSON
//
//  Created by Aula11 on 11/12/22.
//

import Foundation

struct Post: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [Types]
    let sprites: PokemonSprites
    //let stats: [Dictionary<, Any>]
}

struct Generacion: Codable{
    let name: String
}

struct Types: Codable {
    let type: Type
}

struct Type : Codable{
    let name: String
}

struct PokemonSprites: Codable{
    let front_default: String
}
/*
struct Stat: Codable{
    let name: String
}
 */




