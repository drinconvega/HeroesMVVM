//
//  DefaultButton.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 21/1/22.
//

import Foundation
import SwiftUI

struct DefaultButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
