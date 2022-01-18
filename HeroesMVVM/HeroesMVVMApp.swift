//
//  HeroesMVVMApp.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 14/1/22.
//

import SwiftUI

@main
struct HeroesMVVMApp: App {
    
    @StateObject var vm = HeroeListVM()
    
    var body: some Scene {
        WindowGroup {
            HeroeList()
                .environmentObject(vm)
        }
    }
}
