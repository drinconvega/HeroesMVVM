//
//  HeroeService.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 21/1/22.
//

import Foundation
import Combine

protocol HeroeService {
    var apiSession: APIService {get}
    
    func getHeroe(heroe: HeroeModel) -> AnyPublisher<CharacterResponse, APIError>
}

extension HeroeService {
    
    func getHeroe(heroe: HeroeModel) -> AnyPublisher<CharacterResponse, APIError> {
        return apiSession.request(with: HeroesEndpoint.heroes(heroe: heroe))
            .eraseToAnyPublisher()
    }
    
}
