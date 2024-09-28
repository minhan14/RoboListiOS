//
//  RoboListApp.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import SwiftUI
import SwiftData

@main
struct RoboListApp: App {
    
    let container: ModelContainer = {
        let schema = Schema([User.self,Character.self,Location.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    //    @StateObject var authenticationViewModel = AuthenticationViewModel(userRepository:UserUseCase(repo: UserRepositoryImpl(context: ModelContext(try! ModelContainer(for:  Schema([User.self]), configurations:[])))))
    @StateObject var authenticationViewModel: AuthenticationViewModel
    @StateObject var mainViewModel = MainViewModel()
    
    init() {
        let context = ModelContext(container)
        let userRepo = UserRepositoryImpl(context: context)
        let userUseCase = UserUseCase(repo: userRepo)
        _authenticationViewModel = StateObject(wrappedValue: AuthenticationViewModel(userRepository: userUseCase))
    }
    
    var body: some Scene {
        WindowGroup {
            Router().environmentObject(mainViewModel).environmentObject(authenticationViewModel).edgesIgnoringSafeArea(.all)
        }
//        .modelContainer(for: [User.self])
        .modelContainer(container)
    }
}
