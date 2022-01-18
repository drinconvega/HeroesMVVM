//
//  ErrorView.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 18/1/22.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack{
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
            Text("Ups, something went wrong!")
                .padding()
                .font(.title)
        }
        
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
