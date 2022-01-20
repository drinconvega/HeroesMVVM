//
//  LoadingView.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 18/1/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        HStack{
            Spacer()
            VStack {
                Spacer()
                ProgressView("Loading...")
                    .padding()
                    .progressViewStyle(.circular)
                    .background(Color(UIColor.gray))
                    .cornerRadius(5)
                Spacer()
            }
            Spacer()
        }
        .background(Color(UIColor.lightGray)
                        .opacity(0.4))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
