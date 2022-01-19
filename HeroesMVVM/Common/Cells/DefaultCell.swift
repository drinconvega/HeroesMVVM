//
//  DefaultCell.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 14/1/22.
//

import SwiftUI

struct DefaultCell: View {
    
    var heroe : Character
    @ObservedObject var vm = DefaultCellVM()
    
    var body: some View {
        HStack {
            vm.avatar
                .resizable()
            /*AsyncImage(url: URL(string: heroe.thumbnail.path+"."+heroe.thumbnail.thumbnailExtension.rawValue)) { image in
                image.resizable()
                
            } placeholder: {
                Image(systemName: "person").resizable()
            }*/
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 20))
            
            
            Text(heroe.name)
                .font(.headline)
            Spacer()
        }
        .onAppear {
            vm.getHeroe(character: heroe)
        }
    }
}

struct DefaultCell_Previews: PreviewProvider {
    static var previews: some View {
        DefaultCell(heroe: Character.previewHeroe)
            .previewLayout(.fixed(width: 400, height: 60))
            .previewDisplayName("Default Cell")
    }
}
