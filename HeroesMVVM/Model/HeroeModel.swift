//
//  HeroeModel.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 19/1/22.
//

import Foundation

public struct HeroeModel: Hashable {
    let id: Int64
    let name, resultDescription: String
    let imageURL: String
    var imageData: Data?
    
    init(id: Int64, name: String, resultDescription: String, imageURL: String, imageData: Data?=nil) {
        self.id=id
        self.name=name
        self.resultDescription=resultDescription
        self.imageURL=imageURL
        self.imageData=imageData
    }
    
    init() {
        id = 0
        name = ""
        resultDescription = ""
        imageURL = ""
    }
    
    static let previewHeroe = HeroeModel(id: 0000, name: "SuperPrueba", resultDescription:"Prueba de texto muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy muy grande ", imageURL: "https://cdn-icons-png.flaticon.com/512/1705/1705780.png")
}
