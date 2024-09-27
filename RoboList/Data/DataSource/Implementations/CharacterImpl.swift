//
//  GetCharacterImpls.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation
import MyApi
import Apollo

struct CharacterImpls:CharacterRepository{
    
    func getCharacters(page: Int, filterName: String, completion: @escaping GetCharactersCompletion) {
        
        let query = GetCharactersQuery(page: GraphQLNullable<Int>(integerLiteral: page), filterName: filterName)
        
        Network.shared.apollo.fetch(query: query){ result in
            
            switch result{
                
            case .success(let response):
                if let errors = response.errors {
                    completion(.failure(errors[0]))
                    return
                }
                guard let data = response.data else {
                    completion(.failure(NSError(domain: "GraphQL", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data available."])))
                    return
                }
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
    
    
}
