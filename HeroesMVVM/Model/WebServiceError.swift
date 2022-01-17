//
//  WebServiceError.swift
//  HeroesMVP
//
//  Created by Daniel Rincon on 19/02/2021.
//

import Foundation

public enum WebServiceError : Error {
    case unknown
    case invalidSession
    case expiredSession
    case notConnection
}
