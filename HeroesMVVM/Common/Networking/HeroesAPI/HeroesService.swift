//
//  HeroesService.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 18/1/22.
//

import Foundation
import Combine
import UIKit

protocol HeroesService {
    var apiSession: APIService {get}
    
    func getHeroesList(page: Page) -> AnyPublisher<CharacterResponse, APIError>
    func getHeroesList(page: HeroeModel) -> AnyPublisher<CharacterResponse, APIError>
}

extension HeroesService {
    
    func getHeroesList(page: Page) -> AnyPublisher<CharacterResponse, APIError> {
        return apiSession.request(with: HeroesEndpoint.heroesList(page: page))
            .eraseToAnyPublisher()
    }
    
    func getHeroesList(heroe: HeroeModel) -> AnyPublisher<CharacterResponse, APIError> {
        return apiSession.request(with: HeroesEndpoint.heroes(heroe: heroe))
            .eraseToAnyPublisher()
    }
    
}
