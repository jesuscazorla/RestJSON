//
//  VistaPokemon.swift
//  RestJSON
//
//  Created by Aula11 on 12/12/22.
//

import SwiftUI
import Foundation

struct VistaPokemon: View {
    var id: Int = 0
    var nombre: String = ""
    @State var aux: Post = Post(id: 0, name: "", height: 0, weight: 0, types: [Types(type: Type(name: ""))], sprites: PokemonSprites(front_default: ""))
    var body: some View{
        VStack{
            HStack{
                Text("\(aux.id)").bold()
                AsyncImage(url: URL(string: aux.sprites.front_default.lowercased()))
            }
            Text("\(aux.name.capitalized)")
            /*
            HStack{
                Text("Tipos").bold()
                aux.types.forEach { tipo in
                    Text(tipo.type.name)
                }
            }
             */
            }
        .onAppear {
            if(id != 0){
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")
            let task = URLSession.shared.dataTask(with: url!){
                data, response, error in
                
                let decoder = JSONDecoder()
                

                if let data = data{
                    do{
                        let tasks = try decoder.decode(Post.self, from: data)
                        aux = tasks
                        
                    }catch{
                        print(error)
                    }
                }
            }
            task.resume()
            }
            else{
                let url = URL(string: "https://pokeapi.co/api/v2/pokemon/"+nombre)
                let task = URLSession.shared.dataTask(with: url!){
                    data, response, error in
                    
                    let decoder = JSONDecoder()
                    

                    if let data = data{
                        do{
                            let tasks = try decoder.decode(Post.self, from: data)
                            aux = tasks
                            
                        }catch{
                            print(error)
                        }
                    }
                }
                task.resume()
            }
        }
    }
}


