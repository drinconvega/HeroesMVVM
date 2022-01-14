//
//  HeroeDetail.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 14/1/22.
//

import SwiftUI

struct HeroeDetail: View {
    var body: some View {
        ScrollView {
            VStack (spacing: 40) {
                Spacer(minLength: 40)
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                Text("Hello, World!")
                Spacer(minLength: 20)
                Text("Placeholder shfakjshdf kahsf alksjfhkjashflka ks hkla")
            }
        }
    }
}

struct HeroeDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeroeDetail()
                .previewDevice("iPhone SE (2nd generation)")
            HeroeDetail()
                .previewDevice("iPhone 13 Pro Max")
        }
    }
    
}
