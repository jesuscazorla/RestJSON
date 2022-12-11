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

