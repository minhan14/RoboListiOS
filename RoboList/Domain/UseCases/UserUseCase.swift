//
//  UserUseCase.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation

struct UserUseCase: UserRepository{
 
    
    
    let repo: UserRepository
    
    func registerUser(name: String, password: String) throws -> User {
        try repo.registerUser(name: name, password: password)
    }
    
    func authenticateUser(name: String, password: String) throws -> User {
        try repo.authenticateUser(name: name, password: password)
    }
    
    func getUserByName(name: String) -> User? {
        repo.getUserByName(name: name)
    }
    
    func getLoggedInUser() -> User? {
        repo.getLoggedInUser()
    }
    
    func updateUser(_ user: User) {
        repo.updateUser(user)
    }
    
    func logout() {
        repo.logout()
    }
    
}
