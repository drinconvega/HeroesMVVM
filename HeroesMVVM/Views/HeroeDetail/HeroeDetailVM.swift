//
//  HeroeDetailVM.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 17/1/22.
//

import Foundation
import Combine

class HeroeDetailVM: ObservableObject, HeroeService {
    
    @Published var heroe = HeroeModel()
    @Published var avatar = Data()
    @Published var isLoading = false
    @Published var showErrorView = false
    
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
            self.avatar = imgData
        }else{
            self.getHeroeSprite(heroe: heroe)
        }
    }
    
    func getHeroeSprite(heroe: HeroeModel) {
        let cancellable = apiSession.requestImage(with: heroe.imageURL)
            .sink(receiveCompletion: { (result) in
                print(result)
            }) { (image) in
                let updatedHeroe = HeroeModel(id: heroe.id, name: heroe.name, resultDescription: heroe.resultDescription, imageURL: heroe.imageURL, imageData: image)
                self.dataManager.update(heroe: updatedHeroe)
                self.avatar = image
            }
        
        cancellables.insert(cancellable)
    }
    
    func getHeroeFromServer() {
        self.isLoading = true
        self.showErrorView = false
        let cancellable = self.getHeroe(heroe: self.heroe)
            .sink(receiveCompletion: { result in
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.showErrorView = true
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
                
            }) { (heroes) in
                
                let heroesMapped = heroes.data.results.map{ character -> HeroeModel in
                    let heroe = character.toHeroModel()
                    self.dataManager.addOrUpdate(heroe: heroe)
                    return heroe
                }
                
                self.isLoading = false
                if let heroe = heroesMapped.first {
                    self.heroe = heroe
                }
                
            }
        cancellables.insert(cancellable)
    }
    
}
