//
//  UserRepositoryImpl.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation
import SwiftData
import SwiftUI

struct UserRepositoryImpl: UserRepository {
    
    @AppStorage("loggedInUser") var loggedInUser: String = ""
    private let context: ModelContext
      
      init(context: ModelContext) {
          self.context = context
      }
    
    func registerUser(name: String, password: String) throws -> User {
        
        if let _ = getUserByName(name: name) {
            throw NSError(domain: "User already exists", code: 400, userInfo: nil)
        }
    
        
        let encryptedPassword = EncryptionHelper.encrypt(data: password)
        
        let user = User(name: name, encryptedPassword: encryptedPassword)
        
        context.insert(user)
        
        try context.save()
        
        return user
    }
    
    func authenticateUser(name: String, password: String) throws -> User {
        
        guard let user = getUserByName(name: name) else {
            throw NSError(domain: "User not found", code: 404, userInfo: nil)
        }
        let decryptedPassword = try EncryptionHelper.decrypt(data: user.encryptedPassword)
        
        if decryptedPassword == password {
            return user
        } else {
            throw NSError(domain: "Invalid credentials", code: 401, userInfo: nil)
        }
        
    }
    
    func getUserByName(name: String) -> User? {
        
        let fetchRequest = FetchDescriptor<User>(
            predicate: #Predicate { $0.name == name }
        )
        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch {
            print("Failed to fetch user by name: \(error)")
            return nil
        }
    }
    
//    func getLoggedInUser() -> User? {
//        return try? User.decodeFromString(loggedInUser)
//    }
//    
//    func updateUser(_ user: User) {
//        if let encodedUser = try? user.encodeToString(){
//            self.loggedInUser = encodedUser
//        }
//    }
//    func logout() {
//        self.loggedInUser = ""
//    }
    func getLoggedInUser() -> User? {
           do {
               return try User.decodeFromString(loggedInUser)
           } catch {
               print("Failed to decode user: \(error)")
               return nil
           }
       }
       
       func updateUser(_ user: User) {
           do {
                let encodedUser = try user.encodeToString()
                self.loggedInUser = encodedUser
               
           } catch {
               print("Failed to encode user: \(error)")
           }
       }
       
       func logout() {
           self.loggedInUser = ""
       }
}
