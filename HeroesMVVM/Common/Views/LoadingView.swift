//
//  LoadingView.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 18/1/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView("Loading...")
            .padding()
            .progressViewStyle(.circular)    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
