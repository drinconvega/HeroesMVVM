//
//  HeroeDetail.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 14/1/22.
//

import SwiftUI

struct HeroeDetail: View {
    let heroe: Character
    @ObservedObject var vm = HeroeDetailVM()
    
    var body: some View {
        ScrollView {
            VStack (spacing: 40) {
                AsyncImage(url: URL(string: heroe.thumbnail.path+"."+heroe.thumbnail.thumbnailExtension.rawValue)) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "person.circle").resizable()
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
                Text(heroe.name)
                    .padding()
                Spacer(minLength: 20)
                Text(heroe.resultDescription)
                    .padding()
            }
        }
        .onAppear {
            vm.getHeroe(character: heroe)
        }
    }
}

struct HeroeDetail_Previews: PreviewProvider {
    @ObservedObject var vm = HeroeDetailVM()
    
    static var previews: some View {
        Group {
            HeroeDetail(heroe: Character.previewHeroe)
                .previewDevice("iPhone SE (2nd generation)")
            HeroeDetail(heroe: Character.previewHeroe)
                .previewDevice("iPhone 13 Pro Max")
        }
    }
    
}
