//
//  HeroeListVM.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 17/1/22.
//

import Foundation
import Combine

class HeroeListVM: ObservableObject {
    
    @Published var heroes = [Character]() {
        didSet {
            didChange.send(self)
        }
    }
    //En never se puede mer una funcion una enumeracion etc
    let didChange = PassthroughSubject<HeroeListVM, Never>()
    
    private let charactersWS = CharactersWebService()
    var page = Page(limit: 15, offset: 0)
    
    init() {
        getHeroes()
    }
    
    
    
    func getHeroes() {
        charactersWS.getCharacters(page: self.page) { characters in
            self.heroes = characters
            self.page.offset += 15
        } onError: { error in
            
        }

    }
    
}
