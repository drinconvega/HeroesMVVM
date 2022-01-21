//
//  HeroeDetail.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 14/1/22.
//

import SwiftUI

struct HeroeDetail: View {
    let heroe: HeroeModel
    @ObservedObject var vm = HeroeDetailVM()
    @State var image: UIImage = UIImage(systemName: "person")!
    
    var body: some View {
        ScrollView {
            ZStack{
                if vm.isLoading {
                    LoadingView().zIndex(1)
                }
                
                VStack (spacing: 40) {
                    Image(uiImage: image)
                    .resizable()
                    .cornerRadius(15)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding()
                    .onReceive(vm.$avatar) { data in
                        self.image = UIImage(data: data) ?? UIImage()
                    }
                    Text(heroe.name)
                        .padding()
                    Spacer(minLength: 20)
                    Text(heroe.resultDescription)
                        .padding()
                    Spacer()
                    Button("Reload") {
                        vm.getHeroeFromServer()
                    }.padding()
                    .alert("Ups!, something went wrong", isPresented: $vm.showErrorView) {
                        Button("Retry") {
                            vm.getHeroe(heroe: heroe)
                        }
                    }
                }
            }
            
        }
        .onAppear {
            vm.getHeroe(heroe: heroe)
        }
    }
}

struct HeroeDetail_Previews: PreviewProvider {
    @ObservedObject var vm = HeroeDetailVM()
    
    static var previews: some View {
        Group {
            HeroeDetail(heroe: HeroeModel.previewHeroe)
                .previewDevice("iPhone SE (2nd generation)")
            HeroeDetail(heroe: HeroeModel.previewHeroe)
                .previewDevice("iPhone 13 Pro Max")
        }
    }
    
}
