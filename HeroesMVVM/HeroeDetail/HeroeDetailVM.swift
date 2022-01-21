//
//  HeroeDetailVM.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 17/1/22.
//

import Foundation
import Combine
import SwiftUI

class HeroeDetailVM: ObservableObject {
    
    @Published var heroe = HeroeModel()
    @Published var avatar = Image(systemName: "person")
    var apiSession: APIService
    private var dataManager: DataManagerProtocol
    
    var cancellables = Set<AnyCancellable>()
    
    init(apiSession: APIService = APISession(), dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
        self.apiSession = apiSession
    }
    
    func getHeroe(heroe: HeroeModel) {
        self.heroe = dataManager.fetchHeroe(heroe: heroe) ?? heroe
        if let imgData = self.heroe.imageData, !imgData.isEmpty {
            if let img = UIImage(data: imgData) {
                self.avatar = Image(uiImage: img)
            }else {
                self.getHeroeSprite(heroe: heroe)
            }
        }
        
    }
    
    func getHeroeSprite(heroe: HeroeModel) {
        let cancellable = apiSession.requestImage(with: heroe.imageURL)
            .sink(receiveCompletion: { (result) in
                print(result)
            }) { (image) in
                let updatedHeroe = HeroeModel(id: heroe.id, name: heroe.name, resultDescription: heroe.resultDescription, imageURL: heroe.imageURL, imageData: image.pngData())
                self.dataManager.update(heroe: updatedHeroe)
                self.avatar = Image(uiImage: image)
            }
        
        cancellables.insert(cancellable)
    }
    
}
