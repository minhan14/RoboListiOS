//
//  GetCharacterUseCase.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation

struct GetCharacterUseCase:CharacterRepository{
    
    let characterRepo:CharacterRepository
    
    func getCharacters(page: Int, filterName: String, completion: @escaping GetCharactersCompletion) {
        characterRepo.getCharacters(page: page, filterName: filterName, completion: completion)
    }
    
    
}
