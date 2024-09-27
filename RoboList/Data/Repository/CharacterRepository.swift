//
//  CharacterRepository.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation
import MyApi

protocol CharacterRepository{
    
    typealias GetCharactersCompletion = (Result<GetCharactersQuery.Data, Error>) -> Void
    func getCharacters(page:Int,filterName:String, completion: @escaping GetCharactersCompletion)
    
}
