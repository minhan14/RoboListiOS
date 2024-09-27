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
    }
    
    func registerUser(name: String, password: String,confirmPassword:String) {
        do {
            self.registerationState = .loading
            if (name.isEmpty || password.isEmpty){
                self.registerationState = .error("Fields cannot be empty")
                return
            }
            if(password != confirmPassword){
                self.registerationState = .error("Passwords do not match")
                return
            }
            
            let user = try userRepository.registerUser(name: name, password: password)
            currentUser = user
            self.registerationState = .success(user)
        } catch {
            self.registerationState = .error(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    func authenticateUser(name: String, password: String) {
        do {
            self.loginState = .loading
            if (name.isEmpty || password.isEmpty){
                self.loginState = .error("Fields cannot be empty")
                return
            }
            let user = try userRepository.authenticateUser(name: name, password: password)
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
}
