//
//  MainViewModel.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation
import MyApi

final class MainViewModel:ObservableObject{
    
    
    @Published var characterState:UIState<[GetCharactersQuery.Data.Characters.Result?]> = .idle
    
     var currentPage: Int = 1
    
    private var isLoading: Bool = false

    
    /**
     - encapsulate all ui error state
     */
    @Published var errorState: (isPresent: Bool, message: String) = (false, "")


    private let characterUserCase:GetCharacterUseCase
    
    init(characterUserCase: GetCharacterUseCase = GetCharacterUseCase(characterRepo: CharacterImpls())) {
        self.characterUserCase = characterUserCase
        //fetchCharacters()
    }
    
    
     func fetchCharacters(page: Int) {
        guard !isLoading else { return }
        isLoading = true
        self.characterState = .loading

        characterUserCase.getCharacters(page: page, filterName: "Robot") { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false // Reset loading state
                switch result {
                case .success(let response):
                    self?.errorState = (false, "")
                    if let res = response.characters?.results {
                        if page == 1 {
                            self?.characterState = .success(res) // First page
                        } else {
                            // Append new results to existing ones
                            if case .success(let existingResults) = self?.characterState {
                                self?.characterState = .success(existingResults + res)
                            }
                        }
                    }
                    print("results>>> \(String(describing: response.characters?.results))")

                case .failure(let error):
                    self?.characterState = .error(error.localizedDescription)
                    self?.errorState = (true, error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
        }
    }

    
}
