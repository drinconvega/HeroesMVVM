//
//  DefaultCell.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 14/1/22.
//

import SwiftUI

struct DefaultCell: View {
    
    var name : String
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .font(.title).padding()
            Text(name)
                .font(.headline)
            Spacer()
        }
        
    }
}

struct DefaultCell_Previews: PreviewProvider {
    static var previews: some View {
        DefaultCell(name: "Tipo")
            .previewLayout(.fixed(width: 400, height: 60))
            .previewDisplayName("Default Cell")
    }
}
