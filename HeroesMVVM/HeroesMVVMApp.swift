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
    @StateObject private var dataController = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            HeroeList()
                .environment(\.managedObjectContext, dataController.dbHelper.persistentContainer.viewContext)
        }
    }
}
