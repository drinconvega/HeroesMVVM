//
//  ContentView.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 14/1/22.
//

import SwiftUI

struct HeroeList: View {
    let pruebas = ["Tipo1", "Tipo2", "Tipo3"]
    var body: some View {
        NavigationView {
            List {
                ForEach(pruebas, id: \.self) { prueba in
                    NavigationLink(destination: HeroeDetail()) {
                        DefaultCell(name: prueba)
                    }
                }
            }.listStyle(.plain)
            .navigationTitle("Heroes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeroeList()
                .previewDevice("iPhone SE (2nd generation)")
            HeroeList()
                .previewDevice("iPhone 13 Pro Max")
        }
    }
}
