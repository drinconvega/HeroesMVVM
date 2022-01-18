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
    
    var apiSession: APIService
    @Published var heroes = [Character]()
    @Published var isLoading = false
    @Published var showErrorView = false
    @Published var showLoadMore = false
    
    
    var cancellables = Set<AnyCancellable>()
    var page = Page(limit: 15, offset: 0)
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        getHeroesList()
    }
    
    func getHeroesList() {
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
                if heroes.data.count < 15 {
                    self.showLoadMore = false
                }
                self.showLoadMore = true
                self.isLoading = false
                self.heroes = heroes.data.results
                self.page.limit += 15
                self.page.offset += 15
        }
        cancellables.insert(cancellable)
    }
}
