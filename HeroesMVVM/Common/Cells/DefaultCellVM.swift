//
//  DefaultCellVM.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 19/1/22.
//

import Foundation
import Combine
import SwiftUI

class DefaultCellVM: ObservableObject {
    
    @Published var avatar = Image(systemName: "person")
    var apiSession: APIService
    private var dataManager: DataManager
    
    var cancellables = Set<AnyCancellable>()
    
    init(apiSession: APIService = APISession(), dataManager: DataManager = DataManager.shared) {
        self.dataManager = dataManager
        self.apiSession = apiSession
    }
    
    func getHeroeImg(heroe: HeroeModel) {
        if let heroe = dataManager.fetchHeroe(id: heroe.id) {
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
            }) { (image) in
                self.dataManager.update(heroe: HeroeModel(id: heroe.id, name: heroe.name, resultDescription: heroe.resultDescription, imageURL: heroe.imageURL, imageData: image.pngData()))
                self.avatar = Image(uiImage: image)
        }
        
        cancellables.insert(cancellable)
    }
    
}
