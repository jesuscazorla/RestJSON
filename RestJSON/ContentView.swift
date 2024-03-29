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
    var filas = 0..<3
    var columnas = 0..<2

    @State var navigation2 = false
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Image("fondopokedex2").resizable().offset(y: 10)
                }.ignoresSafeArea()
                    .background(Color("colorpokedex"))
            VStack{
            HStack{
                TextField("Buscar...", text: $nombre)
                    .padding()
                    .frame(width: 250, height: 30, alignment: .center)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius:25))
                HStack{
                    Button(){
                        navigation.toggle()
                        
                    }label: {
                        Image(systemName: "magnifyingglass.circle")
                            .opacity(nombre.isEmpty ? 0.3 : 0.7)
                            .foregroundColor(Color.white).imageScale(Image.Scale.large).frame(width: 50)
                            .frame(height: 40)
                        
                    }
                }
            }.offset(y: -50)
            .background(
                Group {
                    NavigationLink(
                        destination: VistaPokemon(nombre:nombre.lowercased(), nav: $navigation).navigationBarBackButtonHidden(true),
                    isActive: $navigation,
                    label: {
                        EmptyView()
                    })
                   
                }
                    .hidden()
            )
                VStack{
                ForEach(filas){__ in
                    HStack{
                        ForEach(columnas){_ in
                            VStack{
                            FilaPokemon(navigation2: navigation2)
                            }
                        }
                    }.frame(width: 190, alignment: .center)
                        .offset(y: 60)
                }
                }
                .navigationBarItems(trailing: Text("Pokédex").bold().font(.title))
                
                
            }
        }
    }

    }
}


struct FilaPokemon: View {
    @State var aux: Post = Post(id: 0, name: "", height: 0, weight: 0, types: [Types(type: Type(name: ""))], sprites: PokemonSprites(front_default: ""), stats: [Stats(base_stat: 0, stat: Stat(name: ""))])
    @State var navigation2: Bool
    var body: some View{

                VStack{
                    AsyncImage(url: URL(string: aux.sprites.front_default.lowercased())).padding(.top, -10)
                    Text("\(aux.name.capitalized)")
                        .foregroundColor(Color.black).bold().font(.title3).multilineTextAlignment(.center)
                    HStack{
                        ForEach(0..<aux.types.count, id: \.self){ tip in
                            FilaTipo(tipo: aux.types[tip].type.name)
                        }
                    }.offset(y: -10)
                }.frame(width: 190)
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
                destination: VistaPokemon(id: aux.id, nav: $navigation2).navigationBarBackButtonHidden(true),
            isActive: $navigation2,
            label: {
                EmptyView()
            })
           
        }
            .hidden()
    )
    }
}



    

 

