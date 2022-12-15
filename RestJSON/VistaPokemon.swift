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
    @State var aux: Post = Post(id: 0, name: "", height: 0, weight: 0, types: [Types(type: Type(name: ""))], sprites: PokemonSprites(front_default: ""), stats: [Stats(base_stat: 0, stat: Stat(name: ""))])
    @Binding var nav: Bool
    var body: some View{
        ZStack{
            VStack{
                Image("fondopokemon")
            }.ignoresSafeArea()
          
            VStack{
            if(aux.name != ""){
                Text("\(aux.id)").font(.title).bold()
                HStack{
                VStack{
                    AsyncImage(url: URL(string: aux.sprites.front_default.lowercased()))
                    Spacer().frame( height: 10)
                    let nom = aux.name.uppercased()
                    Text("\(nom.capitalized)")
                        .bold().font(.title)
                }
            }
            Spacer().frame(height: 20)
            HStack{
                ForEach(0..<aux.types.count, id: \.self){ tip in
                    FilaTipo(tipo: aux.types[tip].type.name)
                }
            }.padding(.bottom, 20)
            HStack{
                var altura = Double(aux.height)
                Text("Altura: \(String(format: "%.2f", (altura/10))) metros").bold()
            
            }
            HStack{
                var peso = Double(aux.weight)
                Text("Peso: \(String(format: "%.2f", (peso/10))) kg").bold()
               
            }
                Spacer().frame(height: 20)
                Text("Estadísticas base: ").bold().padding(.bottom, 20)
                ForEach(0..<aux.stats.count, id: \.self){ st in
                    HStack{
                        switch aux.stats[st].stat.name{
                            case "hp":
                            Text("Puntos de salud:").foregroundColor(Color.green)
                            case "attack":
                                Text("Ataque:").foregroundColor(Color.red)
                            case "defense":
                                Text("Defensa:").foregroundColor(Color.blue)
                            case "special-attack":
                                Text("Ataque especial:").foregroundColor(Color.pink)
                            case "special-defense":
                                Text("Defensa especial:").foregroundColor(Color.cyan)
                            case "speed":
                            Text("Velocidad:").foregroundColor(Color.yellow)
                            default:
                                Text("Stat no registrada:")
                        }
                        Text("\(aux.stats[st].base_stat)").foregroundColor(Color.white)
                    }.frame(width: 200, height: 29)
                    .background(Color.black).clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer().frame(height: 5)
                }
                Image("botonExit")
                    .resizable()
                    .frame(width: 40, height: 80)
                .onTapGesture {
                    nav.toggle()
                }
                .offset(x: -165, y: -300)
            }
            else{
                Text("POKEMON NO EXISTENTE").foregroundColor(Color.black).bold()
                Image("botonExit")
                    .resizable()
                    .frame(width: 40, height: 80)
                .onTapGesture {
                    nav.toggle()
                }
                .offset(x: -165, y: -10)
                
            }
            }.frame(alignment: .center)
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
            .ignoresSafeArea()
        }
    }
}
struct FilaTipo: View {
    var tipo: String
    var body: some View{
        switch tipo{
            case "normal":
            Image("acero").resizable().frame(width: 70, height: 30, alignment: .center)
            case "fighting":
            Image("lucha").resizable().frame(width: 70, height: 30, alignment: .center)
            case "flying":
            Image("volador").resizable().frame(width: 70, height: 30, alignment: .center)
            case "poison":
            Image("veneno").resizable().frame(width: 70, height: 30, alignment: .center)
            case "ground":
            Image("tierra").resizable().frame(width: 70, height: 30, alignment: .center)
            case "rock":
            Image("roca").resizable().frame(width: 70, height: 30, alignment: .center)
            case "bug":
            Image("bicho").resizable().frame(width: 70, height: 30, alignment: .center)
            case "ghost":
            Image("fantasma").resizable().frame(width: 70, height: 30, alignment: .center)
            case "steel":
            Image("acero").resizable().frame(width: 70, height: 30, alignment: .center)
            case "fire":
            Image("fuego").resizable().frame(width: 70, height: 30, alignment: .center)
            case "water":
            Image("agua").resizable().frame(width: 70, height: 30, alignment: .center)
            case "grass":
            Image("planta").resizable().frame(width: 70, height: 30, alignment: .center)
            case "electric":
            Image("electrico").resizable().frame(width: 70, height: 30, alignment: .center)
            case "psychic":
            Image("psiquico").resizable().frame(width: 70, height: 30, alignment: .center)
            case "ice":
            Image("hielo").resizable().frame(width: 70, height: 30, alignment: .center)
            case "dragon":
            Image("dragon").resizable().frame(width: 70, height: 30, alignment: .center)
            case "dark":
            Image("siniestro").resizable().frame(width: 70, height: 30, alignment: .center)
            case "fairy":
            Image("hada").resizable().frame(width: 70, height: 30, alignment: .center)
            default:
                Text("TIPO NO DETERMINADO").bold()
        }
    }
}
