//
//  APISessionMock.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 20/1/22.
//

import Foundation
import Combine
import UIKit

struct APISessionMock: APIService {
    func request<T>(with builder: RequestBuilder) -> AnyPublisher<T, APIError> where T : Decodable {
        let characterMock = CharacterResponse(data: DataClass(offset: 0, limit: 30, total: 2, count: 2, results: [Character.previewHeroe, Character.previewHeroe]))
        return Just(characterMock as! T)
            .mapError{error in .decodingError(error.localizedDescription)}
            .eraseToAnyPublisher()
    }
    
    func requestImage(with url: String) -> AnyPublisher<UIImage, APIError> {
        return Just(UIImage(systemName: "person") ?? UIImage())
            .mapError {error in .decodingError(error.localizedDescription) }
            .eraseToAnyPublisher()
    }
    
    
}
