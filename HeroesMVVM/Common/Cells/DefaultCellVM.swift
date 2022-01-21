//
//  DefaultCellVM.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 19/1/22.
//

import Foundation
import Combine

class DefaultCellVM: ObservableObject {
    
    @Published var avatar = Data()
    var apiSession: APIService
    private var dataManager: DataManager
    
    var cancellables = Set<AnyCancellable>()
    
    init(heroe: HeroeModel, apiSession: APIService = APISession(), dataManager: DataManager = DataManager.shared) {
        self.dataManager = dataManager
        self.apiSession = apiSession
        getHeroeImg(heroe: heroe)
    }
    
    func getHeroeImg(heroe: HeroeModel) {
        if let heroe = dataManager.fetchHeroe(heroe: heroe) {
            if let imgData = heroe.imageData, !imgData.isEmpty {
                self.avatar = imgData
            }else{
                self.getHeroeSprite(heroe: heroe)
            }
        }
    }
    //Actualizamos la BD con la imagen descargada
    func getHeroeSprite(heroe: HeroeModel) {
        let cancellable = apiSession.requestImage(with: heroe.imageURL)
            .sink(receiveCompletion: { (result) in
                print(result)
            }) { [weak self] (image) in
                self?.dataManager.update(heroe: HeroeModel(id: heroe.id, name: heroe.name, resultDescription: heroe.resultDescription, imageURL: heroe.imageURL, imageData: image))
                self?.avatar = image
        }
        
        cancellables.insert(cancellable)
    }
    
}
