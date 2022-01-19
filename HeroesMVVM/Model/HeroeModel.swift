//
//  HeroeModel.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 19/1/22.
//

import Foundation

public struct HeroeModel {
    let id: Int64
    let name, resultDescription: String
    var imageData: Data?
    
    init(id: Int64, name: String, resultDescription: String, imageData: Data?=nil) {
        self.id=id
        self.name=name
        self.resultDescription=resultDescription
        self.imageData=imageData
    }
    
    init() {
        id = 0
        name = ""
        resultDescription = ""
    }
    
}
