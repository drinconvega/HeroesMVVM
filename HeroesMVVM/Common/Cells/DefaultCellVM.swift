//
//  DefaultCellVM.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 19/1/22.
//

import Foundation
import Combine
import SwiftUI
import Swinject

class DefaultCellVM: ObservableObject {
    
    @Published var avatar = Image(systemName: "person")
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
            if heroe.imageData?.isEmpty ?? true {
                self.getHeroeSprite(heroe: heroe)
            }else{
                if let img = UIImage(data: heroe.imageData!) {
                    self.avatar = Image(uiImage: img)
                }
            }
        }
    }
    //Actualizamos la BD con la imagen descargada
    func getHeroeSprite(heroe: HeroeModel) {
        let cancellable = apiSession.requestImage(with: heroe.imageURL)
            .sink(receiveCompletion: { (result) in
                print(result)
            }) { [weak self] (image) in
                self?.dataManager.update(heroe: HeroeModel(id: heroe.id, name: heroe.name, resultDescription: heroe.resultDescription, imageURL: heroe.imageURL, imageData: image.pngData()))
                self?.avatar = Image(uiImage: image)
        }
        
        cancellables.insert(cancellable)
    }
    
}
