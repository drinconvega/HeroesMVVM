//
//  APIError.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 18/1/22.
//

import Foundation

enum APIError: Error {
    case decodingError(String)
    case httpError(Int)
    case unknown
}
