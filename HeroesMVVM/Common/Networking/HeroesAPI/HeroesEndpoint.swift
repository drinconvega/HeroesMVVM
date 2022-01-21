//
//  HeroesEndpoint.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 18/1/22.
//

import Foundation

enum HeroesEndpoint {
    case heroesList(page: Page)
    case heroes(heroe: HeroeModel)
}

extension HeroesEndpoint: RequestBuilder {
    
    private static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    private static let privateKey = Bundle.main.object(forInfoDictionaryKey: "PRIV_KEY") as! String
    internal static let baseURL = Bundle.main.object(forInfoDictionaryKey: "SERVER_URL") as! String
    
    internal enum endpoint : String {
        case characters = "characters"
    }
    
    static func getSecurityParams() -> [String: String] {
        var parameters = [String: String]()
        let timestamp = String(Date().timeIntervalSince1970)
        
        let hash = String.MD5(string: (timestamp + privateKey + apiKey))
        
        parameters["apikey"] = apiKey
        parameters["ts"] = timestamp
        parameters["hash"] = hash
        
        return parameters
    }
    
    func createURLFromParameters(parameters: [String:String]?, url: String, securityParams : Bool=true) -> URLRequest? {
        
        guard var components = URLComponents(string: url) else {
            return nil
        }
        components.queryItems = parameters?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        if securityParams {
            components.queryItems = HeroesEndpoint.getSecurityParams().map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        return URLRequest(url: components.url!)
    }
    
    var urlRequest: URLRequest {
        switch self {
        case .heroesList(let page):
            
            var params = HeroesEndpoint.getSecurityParams()
            params["limit"] = String(page.limit)
            params["offset"] = String(page.offset)
            
            guard let request = self.createURLFromParameters(parameters: params,
                                                             url: "\(HeroesEndpoint.baseURL)\(HeroesEndpoint.endpoint.characters.rawValue)",
                                                             securityParams: false)
                else {preconditionFailure("Invalid URL format")}
            return request
        case .heroes(heroe: let heroe):
            
            guard let request = self.createURLFromParameters(parameters: nil,
                                                             url: "\(HeroesEndpoint.baseURL)\(HeroesEndpoint.endpoint.characters.rawValue)/\(heroe.id)",
                                                             securityParams: true)
                else {preconditionFailure("Invalid URL format")}
            return request
        }
    }
}
