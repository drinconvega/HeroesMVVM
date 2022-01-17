//
//  BaseWebService.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 17/1/22.
//

import Foundation
import NetworkReachability
import Alamofire
import JSONDecoder_Keypath

public class BaseWebService {
    
    public init() {}
    
    private static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    private static let privateKey = Bundle.main.object(forInfoDictionaryKey: "PRIV_KEY") as! String
    internal static let baseURL = Bundle.main.object(forInfoDictionaryKey: "SERVER_URL") as! String
    internal enum endpoint : String {
        case characters = "characters"
    }
    
    public var MAX_RETRY = 3
    static let instance = BaseWebService()
    public static var manager: Alamofire.SessionManager = {
        
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        let manager = Alamofire.SessionManager(
            configuration: configuration
        )
        
        return manager
    }()
    
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func getSecurityParams() -> [String: String]{
        var parameters = [String: String]()
        let timestamp = String(Date().timeIntervalSince1970)
        
        let hash = String.MD5(string: (timestamp + privateKey + apiKey))
        
        parameters["apikey"] = apiKey
        parameters["ts"] = timestamp
        parameters["hash"] = hash
        
        return parameters
    }
}
