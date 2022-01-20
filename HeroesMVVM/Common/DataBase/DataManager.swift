//
//  DataManager.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 19/1/22.
//

import Foundation
import CoreData
/*
protocol HeroeDataManagerProtocol : ObservableObject {
    func fetchHeroeList() -> [HeroeModel]
    func fetchHeroe(id: Double) -> HeroeModel?
    func addHeroe(heroe: HeroeModel)
    func delete(heroe: HeroeModel)
    func update(heroe: HeroeModel)
}*/


//typealias DataManagerProtocol = HeroeDataManagerProtocol

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
extension DataManager {
    func fetchHeroeList() -> [HeroeModel] {
        let result: Result<[HeroeEntity], Error> = dbHelper.read(HeroeEntity.self, predicate: nil, limit: nil)
        switch result {
        case .success(let heroeEntities):
            return heroeEntities.map { $0.convertToHeroeModel() }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchHeroe(id: Int64) -> HeroeModel? {
        let predicate = NSPredicate(format: "id == %d", id)
        let result: Result<HeroeEntity?, Error> = dbHelper.readFirst(HeroeEntity.self, predicate: predicate)
        switch result {
        case .success(let heroeEntities):
            return heroeEntities.map { $0.convertToHeroeModel() }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func addHeroe(heroe: HeroeModel) {
        let entity = HeroeEntity.entity()
        let newHeroe = HeroeEntity(entity: entity, insertInto: dbHelper.context)
        newHeroe.id = heroe.id
        newHeroe.name = heroe.name
        newHeroe.resultDescription = heroe.resultDescription
        newHeroe.imageURL = heroe.imageURL
        if let imageData = heroe.imageData{
            newHeroe.image = imageData
        }
        dbHelper.create(newHeroe)
    }
    
    func delete(heroe: HeroeModel) {
        guard let heroeEntity = fetchHeroeEntity(for: heroe) else { return }
        dbHelper.delete(heroeEntity)
    }
    
    func addOrUpdate(heroe: HeroeModel) {
        if let heroeEntity = fetchHeroeEntity(for: heroe) {
            heroeEntity.id = heroe.id
            heroeEntity.name = heroe.name
            heroeEntity.resultDescription = heroe.resultDescription
            heroeEntity.imageURL = heroe.imageURL
            if let imageData = heroe.imageData{
                heroeEntity.image = imageData
            }
            dbHelper.update(heroeEntity)
        } else {
            self.addHeroe(heroe: heroe)
        }
        
    }
    
    func update(heroe: HeroeModel) {
        guard let heroeEntity = fetchHeroeEntity(for: heroe) else { return }
        heroeEntity.id = heroe.id
        heroeEntity.name = heroe.name
        heroeEntity.resultDescription = heroe.resultDescription
        heroeEntity.imageURL = heroe.imageURL
        if let imageData = heroe.imageData{
            heroeEntity.image = imageData
        }
        dbHelper.update(heroeEntity)
    }
}

