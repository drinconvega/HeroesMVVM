//
//  HeroeEntity.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 19/1/22.
//

import Foundation
import CoreData

@objc(HeroeEntity)
final class HeroeEntity: NSManagedObject {
    @NSManaged var id: Int64
    @NSManaged var name: String
    @NSManaged var resultDescription: String
    @NSManaged var imageURL: String
    @NSManaged var image: Data
}

extension HeroeEntity {
    func convertToHeroeModel() -> HeroeModel {
        return HeroeModel(id: self.id, name: self.name, resultDescription: self.resultDescription, imageURL: self.imageURL, imageData: self.image)
    }
}
