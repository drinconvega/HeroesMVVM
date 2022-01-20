//
//  DefaultCell.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 14/1/22.
//

import SwiftUI

struct DefaultCell: View {
    
    var heroe : HeroeModel
    @ObservedObject var vm : DefaultCellVM
    
    init(heroe: HeroeModel) {
        self.heroe = heroe
        _vm = ObservedObject(wrappedValue: DefaultCellVM(heroe: heroe))
    }
    
    var body: some View {
        HStack {
            vm.avatar
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 20))
            
            
            Text(heroe.name)
                .font(.headline)
            Spacer()
        }
    }
}

struct DefaultCell_Previews: PreviewProvider {
    static var previews: some View {
        DefaultCell(heroe: HeroeModel.previewHeroe)
            .previewLayout(.fixed(width: 400, height: 60))
            .previewDisplayName("Default Cell")
    }
}
