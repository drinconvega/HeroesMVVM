//
//  DataManager.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 19/1/22.
//

import Foundation
import CoreData

protocol HeroeDataManagerProtocol {
    func fetchHeroeList<T:HeroModelProtocol>() -> [T]
    func fetchHeroe<T:HeroModelProtocol>(heroe: T) -> T?
    func addHeroe<T:HeroModelProtocol>(heroe: T)
    func delete<T:HeroModelProtocol>(heroe: T)
    func update<T:HeroModelProtocol>(heroe: T)
    func addOrUpdate<T:HeroModelProtocol>(heroe: T)
}

typealias DataManagerProtocol = HeroeDataManagerProtocol

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    var dbHelper: CoreDataHelper = .shared
    
    private init() { }
    
    private func fetchHeroeEntity(for heroe: HeroeModel) -> HeroeEntity? {
        let predicate = NSPredicate(format: "id == %d", heroe.id)
        let result = dbHelper.readFirst(HeroeEntity.self, predicate: predicate)
        switch result {
        case .success(let heroeEntity):
            return heroeEntity
        case .failure:
            return nil
        }
    }
}

// MARK: - HeroeDataManagerProtocol
extension DataManager : DataManagerProtocol{
    
    func fetchHeroeList<T>() -> [T] where T : HeroModelProtocol {
        let result: Result<[HeroeEntity], Error> = dbHelper.read(HeroeEntity.self, predicate: nil, limit: nil)
        switch result {
        case .success(let heroeEntities):
            return heroeEntities.map { $0.convertToHeroeModel() as! T }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchHeroe<T>(heroe: T) -> T? where T : HeroModelProtocol {
        let oldHeroe = heroe as! HeroeModel
        let predicate = NSPredicate(format: "id == %d", oldHeroe.id)
        let result: Result<HeroeEntity?, Error> = dbHelper.readFirst(HeroeEntity.self, predicate: predicate)
        switch result {
        case .success(let heroeEntities):
            return heroeEntities.map { $0.convertToHeroeModel() as! T }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func addHeroe<T>(heroe: T) where T : HeroModelProtocol {
        let entity = HeroeEntity.entity()
        let newHeroe = HeroeEntity(entity: entity, insertInto: dbHelper.context)
        let oldHeroe = heroe as! HeroeModel
        newHeroe.id = oldHeroe.id
        newHeroe.name = oldHeroe.name
        newHeroe.resultDescription = oldHeroe.resultDescription
        newHeroe.imageURL = oldHeroe.imageURL
        if let imageData = oldHeroe.imageData{
            newHeroe.image = imageData
        }
        dbHelper.create(newHeroe)
    }
    
    func delete<T>(heroe: T) where T : HeroModelProtocol {
        let oldHeroe = heroe as! HeroeModel
        guard let heroeEntity = fetchHeroeEntity(for: oldHeroe) else { return }
        dbHelper.delete(heroeEntity)
    }
    
    func update<T>(heroe: T) where T : HeroModelProtocol {
        let oldHeroe = heroe as! HeroeModel
        guard let heroeEntity = fetchHeroeEntity(for: oldHeroe) else { return }
        heroeEntity.id = oldHeroe.id
        heroeEntity.name = oldHeroe.name
        heroeEntity.resultDescription = oldHeroe.resultDescription
        heroeEntity.imageURL = oldHeroe.imageURL
        if let imageData = oldHeroe.imageData{
            heroeEntity.image = imageData
        }
        dbHelper.update(heroeEntity)
    }
    
    func addOrUpdate<T>(heroe: T) where T : HeroModelProtocol {
        let oldHeroe = heroe as! HeroeModel
        if let heroeEntity = fetchHeroeEntity(for: oldHeroe) {
            heroeEntity.id = oldHeroe.id
            heroeEntity.name = oldHeroe.name
            heroeEntity.resultDescription = oldHeroe.resultDescription
            heroeEntity.imageURL = oldHeroe.imageURL
            if let imageData = oldHeroe.imageData{
                heroeEntity.image = imageData
            }
            dbHelper.update(heroeEntity)
        } else {
            self.addHeroe(heroe: heroe)
        }
    }
    
}

