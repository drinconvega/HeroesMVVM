//
//  APISession.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 18/1/22.
//

import Foundation
import Combine
import UIKit

struct APISession: APIService {
    func request<T>(with builder: RequestBuilder) -> AnyPublisher<T, APIError> where T: Decodable {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return URLSession.shared
            .dataTaskPublisher(for: builder.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                    
                    return Just(data)
                        .decode(type: T.self, decoder: decoder)
                        .mapError {error in
                            print(error)
                            return .decodingError(error.localizedDescription)}
                        .eraseToAnyPublisher()
                    } else {
                        return Fail(error: APIError.httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                return Fail(error: APIError.unknown)
                        .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
