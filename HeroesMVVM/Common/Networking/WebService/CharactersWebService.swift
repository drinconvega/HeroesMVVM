//
//  CharactersWebService.swift
//  HeroesMVVM
//
//  Created by Daniel Rincon Vega on 17/1/22.
//

import Foundation

public class CharactersWebService: BaseWebService {
    
    public func getCharacters(page: Page, onSuccess: @escaping ([Character]) -> Void,
                              onError: @escaping (Error) -> Void) {
        
        
        if BaseWebService.isConnected(){
            var params = BaseWebService.getSecurityParams()
            params["limit"] = String(page.limit)
            params["offset"] = String(page.offset)
            
            BaseWebService.manager.request("\(BaseWebService.baseURL)\(BaseWebService.endpoint.characters.rawValue)", method: .get, parameters: params).validate()
                .responseJSON (completionHandler: { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            onError(NetworkingError.unknown)
                            return
                        }
                        do{
                            let characters = try JSONDecoder().decode([Character].self, from: data, keyPath: "data.results")
                            onSuccess(characters)
                        }catch let error {
                            print("Error parseo getCharacters: \(error)")
                            onError(NetworkingError.ParsingError)
                        }
                    case .failure(let error):
                        onError(error)
                        print("Error getCharacters: \(error)")
                    }
                })
        }else{
            onError(WebServiceError.notConnection)
        }
    }
    
}
