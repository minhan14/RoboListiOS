//
//  AuthenticationViewModel.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation


class AuthenticationViewModel: ObservableObject{
    
    private let userRepository: UserUseCase
    
    @Published var errorMessage: String?
    @Published var currentUser: User?
    @Published var loginState: UIState<User> = .idle
    @Published var registerationState: UIState<User> = .idle
    
    init(userRepository: UserUseCase, errorMessage: String? = nil, currentUser: User? = nil) {
        self.userRepository = userRepository
        self.errorMessage = errorMessage
        self.currentUser = currentUser
        if let userData = userRepository.getLoggedInUser(){
            self.currentUser = userData
        }
    }
    
    func registerUser(name: String, password: String, confirmPassword: String) {
        do {
            guard self.registerationState != .loading else {
                return
            }
            self.registerationState = .loading
            
            guard !name.isEmpty, !password.isEmpty else {
                self.registerationState = .error("Fields cannot be empty")
                return
            }
            guard password == confirmPassword else {
                self.registerationState = .error("Passwords do not match")
                return
            }
            
            let user = try  userRepository.registerUser(name: name, password: password)
            currentUser = user
            userRepository.updateUser(user)
            self.registerationState = .success(user)
            
        } catch {
            self.registerationState = .error(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }

    
    func authenticateUser(name: String, password: String) {
        do {
            guard self.loginState != .loading else {
                return
            }
            self.loginState = .loading
            
            guard !name.isEmpty, !password.isEmpty else {
                self.loginState = .error("Fields cannot be empty")
                return
            }
            let user = try userRepository.authenticateUser(name: name, password: password)
            userRepository.updateUser(user)
            self.loginState = .success(user)
            currentUser = user
        } catch {
            print(error)
            self.loginState = .error(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    func resetState(){
        self.loginState = .idle
        self.registerationState = .idle
    }
    func logout(){
        userRepository.logout()
        self.currentUser = nil
    }
}
