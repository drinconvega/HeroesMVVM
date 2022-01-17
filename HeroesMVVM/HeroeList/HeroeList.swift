//
//  ContentView.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 14/1/22.
//

import SwiftUI

struct HeroeList: View {
    
    @ObservedObject var vm = HeroeListVM()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.heroes, id: \.self) { heroe in
                    NavigationLink(destination: HeroeDetail()) {
                        DefaultCell(name: heroe.name)
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
