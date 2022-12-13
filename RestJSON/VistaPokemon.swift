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
        ZStack{
            VStack{
                Spacer().frame(height: 40)
            Image("fondopokemon").resizable()
            }.ignoresSafeArea()
            VStack{
            if(aux.name != ""){
            HStack{
                Text("\(aux.id)").bold()
                VStack{
                    AsyncImage(url: URL(string: aux.sprites.front_default.lowercased()))
                    Spacer().frame( height: 5)
                    let nom = aux.name.uppercased()
                    Text("\(nom.capitalized)")
                        .bold()
                }
            }
            Spacer().frame(height: 20)
            HStack{
                Text("Tipos:").bold()
                ForEach(0..<aux.types.count, id: \.self){ tip in
                    FilaTipo(tipo: aux.types[tip].type.name)
                }
            }
            HStack{
                Text("Altura:").bold()
                Text("\(aux.height)")
            }
            HStack{
                Text("Peso:").bold()
                Text("\(aux.weight)")
            }
            
            }
            else{
                Text("POKEMON NO EXISTENTE").foregroundColor(Color.red)
            }
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
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/"+nombre)
            if(url != nil){
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
}
struct FilaTipo: View {
    var tipo: String
    var body: some View{
        switch tipo{
            case "normal":
            Text("NORMAL").background(Color.gray)
            case "fighting":
                Text("LUCHA").background(Color.brown)
            case "flying":
                Text("VOLADOR").background(Color.teal)
            case "poison":
                Text("VENENO").background(Color.indigo)
            case "ground":
                Text("TIERRA").background(Color.yellow)
            case "rock":
                Text("ROCA").background(Color.brown)
            case "bug":
                Text("BICHO").background(Color.mint)
            case "ghost":
                Text("FANTASMA").background(Color.purple)
            case "steel":
                Text("ACERO").background(Color.gray)
            case "fire":
                Text("FUEGO").background(Color.red)
            case "water":
                Text("AGUA").background(Color.blue)
            case "grass":
                Text("PLANTA").background(Color.green)
            case "electric":
                Text("ELÉCTRICO").background(Color.yellow)
            case "psychic":
                Text("PSÍQUICO").background(Color.pink)
            case "ice":
                Text("HIELO").background(Color.cyan)
            case "dragon":
                Text("DRAGÓN").background(Color.purple)
            case "dark":
                Text("SINIESTRO").background(Color.black).foregroundColor(Color.white)
            case "fairy":
                Text("HADA").background(Color.pink)
            default:
                Text("TIPO NO DETERMINADO").bold()
        }
    }
}
