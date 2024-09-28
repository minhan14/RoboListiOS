//
//  MainViewModel.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation
import MyApi

final class MainViewModel:ObservableObject{
    
    /**
     -it is mess up to add loading state with paging
     */
    //    @Published var characterState:UIState<[GetCharactersQuery.Data.Characters.Result?]> = .idle
    
    //    @Published var characters: [GetCharactersQuery.Data.Characters.Result?] = []
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var currentPage: Int = 1
    var endOfPagingReached: Bool = false
    /**
     - encapsulate all ui error state
     */
    @Published var errorState: (isPresent: Bool, message: String) = (false, "")
    
    
    private let characterUseCase:GetCharacterUseCase
    
    
    init(characterUserCase: GetCharacterUseCase = GetCharacterUseCase(characterRepo: CharacterImpls())) {
        self.characterUseCase = characterUserCase
        //fetchCharacters()
    }
    
    
    
    func fetchCharacters(page: Int, userId: UUID?) {
        guard let userId else {
            self.errorState = (true,"User id is nil")
            return
        }
        guard !isLoading, !endOfPagingReached else { return }
        isLoading = true
        
        
        //        self.characterState = .loading
        
        characterUseCase.getCharacters(page: page, filterName: "") { [weak self] result in
            DispatchQueue.main.async{
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.errorState = (false, "")
                    
                    if let res = response.characters?.results, !res.isEmpty {
                        
                        let characters = res.compactMap { character -> Character? in
                            guard let character = character else { return nil }
                            guard let id = character.id,
                                  let name = character.name,
                                  let statusString = character.status,
                                  let status = Status(rawValue: statusString),
                                  let species = character.species,
                                  let locationId = character.location?.id,
                                  let dimension = character.location?.dimension,
                                  let image = character.image else { return nil }
                            return Character(id:id,userId: userId, name: name, status: status, species: species, locationId:locationId,dimension: dimension, image: image)
                        }
                        self?.characters.append(contentsOf: characters)
                        
                    } else {
                        self?.endOfPagingReached = true
                    }
                    self?.isLoading = false
                    print("results>>> \(String(describing: response.characters?.results))")
                    
                case .failure(let error):
                    self?.isLoading = false
                    //  self?.characterState = .error(error.localizedDescription)
                    self?.errorState = (true, error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchNextPage(userId:UUID?) {
        if !endOfPagingReached {
            currentPage += 1
            fetchCharacters(page: currentPage,userId: userId)
        }
    }
}


