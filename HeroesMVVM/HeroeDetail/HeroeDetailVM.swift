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
    var apiSession: APIService
    private var dataManager: DataManager
    
    var cancellables = Set<AnyCancellable>()
    
    init(apiSession: APIService = APISession(), dataManager: DataManager = DataManager.shared) {
        self.dataManager = dataManager
        self.apiSession = apiSession
    }
    
    func getHeroe(character: Character) {
        self.heroe = dataManager.fetchHeroe(id: Int64(character.id)) ?? character.toHeroModel()
        if self.heroe.imageData?.isEmpty ?? true {
            self.getHeroeSprite(heroe: heroe, urlString: character.thumbnail.path+"."+character.thumbnail.thumbnailExtension.rawValue)
        }
    }
    
    func getHeroeSprite(heroe: HeroeModel, urlString: String) {
        let cancellable = apiSession.requestImage(with: urlString)
            .sink(receiveCompletion: { (result) in
                print(result)
            }) { (image) in
                self.heroe = HeroeModel(id: heroe.id, name: heroe.name, resultDescription: heroe.resultDescription, imageData: image.pngData())
                self.dataManager.update(heroe: self.heroe)
        }
        
        cancellables.insert(cancellable)
    }
    
}
