//
//  UserRepository.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation

protocol UserRepository {
    
    func registerUser(name: String, password: String) throws -> User
    func authenticateUser(name: String, password: String) throws -> User
    func getUserByName(name: String) -> User?
    
}
