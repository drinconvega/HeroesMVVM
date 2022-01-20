//
//  DataManagerMock.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 20/1/22.
//

import Foundation

struct DataManagerMock: HeroeDataManagerProtocol {
    func fetchHeroeList<T>() -> [T] where T : HeroModelProtocol {
        return [HeroeModel.previewHeroe as! T, HeroeModel.previewHeroe as! T]
    }
    
    func fetchHeroe<T>(heroe: T) -> T? where T : HeroModelProtocol {
        return HeroeModel.previewHeroe as? T
    }
    
    func addHeroe<T>(heroe: T) where T : HeroModelProtocol {
        
    }
    
    func delete<T>(heroe: T) where T : HeroModelProtocol {
        
    }
    
    func update<T>(heroe: T) where T : HeroModelProtocol {
        
    }
    
    func addOrUpdate<T>(heroe: T) where T : HeroModelProtocol {
        
    }
    
    
}
