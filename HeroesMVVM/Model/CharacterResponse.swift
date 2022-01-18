//
//  CharacterResponse.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 18/1/22.
//

import Foundation

// MARK: - Response
struct CharacterResponse: Codable {
    /*let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String*/
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Character]
    enum CodingKeys: String, CodingKey {
        case offset, limit, total, count
        case results = "results"
    }
}
