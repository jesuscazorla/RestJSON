//
//  ContentView.swift
//  RestJSON
//
//  Created by Aula11 on 11/12/22.
//

import SwiftUI

struct ContentView: View {
    @State var nombre: String = ""
    @State var tasks: Post = Post(id: 0, name: "", height: 0, weight: 0, types: [Types(type: Type(name: ""))])
    @State var mostrar_info: Bool = false
    @State var tipos: [String] = []
    var body: some View {
    
        
        VStack{
            TextField("Buscar Información del Pokémon", text: $nombre)
            Button("Buscar"){
                mostrar_info = true
                let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(nombre.lowercased())")


                let task = URLSession.shared.dataTask(with: url!){
                    data, response, error in
                    
                    let decoder = JSONDecoder()
                    

                    if let data = data{
                        do{
                          tasks = try decoder.decode(Post.self, from: data)
                            print(tasks)
                            

                            
                    }catch{
                            print(error)
                        }
                    }
                }
                task.resume()
                
            }
            if(mostrar_info){
            Text("ID: \(tasks.id)")
                Text("Nombre: \(tasks.name)")
            Text("Peso: \(tasks.weight/10) kilos")
            var aux = Double(tasks.height)/10
            Text("Altura: \(String(format: "%.2f", aux)) metros")
            construirArray(aux: tasks.types)
            ForEach(0 ..< tipos.count){ value in
                Text("Tipo: \(tipos[value])")
                }
                
            
        }

    }



}
    
    func construirArray(aux : [Types]) -> some View{
        for p in aux {
            tipos.append(p.type.name)
        }
        return Text("")
        
    }
 
}
