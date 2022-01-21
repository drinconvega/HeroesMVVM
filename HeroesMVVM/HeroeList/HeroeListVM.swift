//
//  HeroeListVM.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 17/1/22.
//

import Foundation
import Combine
import SwiftUI

class HeroeListVM: ObservableObject, HeroesService {
    
    @Published var heroes = [HeroeModel]()
    @Published var isLoading = false
    @Published var showErrorView = false
    @Published var showLoadMore = false
    
    internal var apiSession: APIService
    private var dataManager: DataManagerProtocol
    
    private var cancellables = Set<AnyCancellable>()
    private var page = Page(limit: 30, offset: 0)
    
    init(apiSession: APIService = APISession(), dataManager: DataManagerProtocol = DataManager.shared) {
        self.apiSession = apiSession
        self.dataManager = dataManager
        getHeroeList()
    }
    
    func getHeroeList() {
        self.isLoading = true
        let heroes = getHeroesFromDB()
        if heroes.count > 0 && heroes.count >= page.offset {
            self.heroes = heroes
            page.offset = heroes.count+30
            self.isLoading = false
            self.showLoadMore = true
        }else{
            getHeroesListFromServer()
        }
    }
    
    func getHeroesFromDB() -> [HeroeModel] {
        return dataManager.fetchHeroeList() as [HeroeModel]
    }
    
    func getHeroesListFromServer() {
        self.isLoading = true
        self.showErrorView = false
        let cancellable = self.getHeroesList(page: page)
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
                
                self.page.offset += 30
                
                let heroesMapped = heroes.data.results.map{ character -> HeroeModel in
                    let heroe = character.toHeroModel()
                    self.dataManager.addOrUpdate(heroe: heroe)
                    return heroe
                }
                
                if heroes.data.count < 30 {
                    self.showLoadMore = false
                }else{
                    self.showLoadMore = true
                }
                self.isLoading = false
                self.heroes.append(contentsOf:heroesMapped)
            }
        cancellables.insert(cancellable)
    }
}
