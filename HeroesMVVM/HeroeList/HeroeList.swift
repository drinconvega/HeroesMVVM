//
//  ContentView.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 14/1/22.
//

import SwiftUI

struct HeroeList: View {
    
    @EnvironmentObject var vm : HeroeListVM
    
    var body: some View {
        NavigationView {
            ZStack {
                if vm.isLoading {
                    LoadingView()
                        .background(Color(UIColor.lightGray)
                                        .opacity(0.1))
                        .cornerRadius(5)
                }
                
                List {
                    ForEach(vm.heroes, id: \.self) { heroe in
                        NavigationLink(destination: HeroeDetail(heroe: heroe)) {
                            DefaultCell(heroe: heroe)
                        }
                    }
                    if vm.showLoadMore{
                        HStack {
                            Button("Load more") {
                                vm.getHeroesList()
                                
                            }
                        }.listRowInsets(EdgeInsets())
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(Color(UIColor.systemGroupedBackground))
                    }
                }.listStyle(.plain)
                    .alert("Ups!, something went wrong", isPresented: $vm.showErrorView) {
                        Button("Retry") {
                            vm.getHeroesList()
                        }
                    }
                    .navigationTitle("Heroes")
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeroeList()
                .previewDevice("iPhone SE (2nd generation)")
                .environmentObject(HeroeListVM())
            HeroeList()
                .previewDevice("iPhone 13 Pro Max")
                .environmentObject(HeroeListVM())
        }
    }
}
