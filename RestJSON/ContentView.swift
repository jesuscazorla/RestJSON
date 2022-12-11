//
//  ContentView.swift
//  RestJSON
//
//  Created by Aula11 on 11/12/22.
//

import SwiftUI

struct ContentView: View {
    @State var nombre: String = ""
    @State var navigation = false
    var values = 0..<5
    @State var navigation2 = false
    var body: some View {
    
        NavigationView{
        VStack{
            HStack{
                                       
            TextField("Buscar...", text: $nombre)
                    .padding()
                    .frame(width: 250, height: 30, alignment: .center)
                    .background(.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius:25))
                HStack{
                    Button(){
                        navigation.toggle()
                        
                    }label: {
                        Image(systemName: "magnifyingglass.circle")
                            .opacity(nombre.isEmpty ? 0.3 : 0.5)
                            .foregroundColor(Color.gray).imageScale(Image.Scale.large).frame(width: 50)
                            .frame(height: 40)
                        
                    }
                    
                }
                
            } .background(
                Group {
                    NavigationLink(
                        destination: VistaPokemon(nombre: nombre),
                    isActive: $navigation,
                    label: {
                        EmptyView()
                    })
                   
                }
                    .hidden()
            )
    
        
        .offset(y: -50)
        
        ForEach(values){_ in
            FilaPokemon(navigation2: navigation2)
        }
            
            
          
            
                
                
            }
        .navigationTitle("Pokédex")
        .navigationBarTitleDisplayMode(.inline)
        }
        
        }
     /*
      mostrar_info = true
    
  }
      
      if(mostrar_info){
            Text("ID: \(tasks.id)")
                Text("Nombre: \(tasks.name)")
            Text("Peso: \(tasks.weight/10) kilos")
            var aux = Double(tasks.height)/10
            Text("Altura: \(String(format: "%.2f", aux)) metros")
              //  Text("Types: \(tasks.types)")
        
            
        }*/

    }


struct FilaPokemon: View {
    @State var aux: Post = Post(id: 0, name: "", height: 0, weight: 0, types: [Types(type: Type(name: ""))], sprites: PokemonSprites(front_default: ""))
    @State var navigation2: Bool
    var body: some View{
        VStack{
            HStack{
                Text("\(aux.id)").bold()
                AsyncImage(url: URL(string: aux.sprites.front_default.lowercased()))
            }
            
            Spacer().frame( height: 5)
            
            Text("\(aux.name.capitalized)")
           
            Spacer().frame(height: 10)
            
    
        }.frame(width: 200, height: 100, alignment: .leading)
            
        .onAppear {
            let random = Int64.random(in: 1...800)
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(random)")
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
        .onTapGesture {
            navigation2.toggle()
        }
        .background(
        Group {
            NavigationLink(
                destination: VistaPokemon(nombre: "", post: aux),
            isActive: $navigation2,
            label: {
                EmptyView()
            })
           
        }
            .hidden()
    )
            }       }



    

 

