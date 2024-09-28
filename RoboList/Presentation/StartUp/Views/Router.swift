//
//  Router.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import SwiftUI

struct Router: View {
    
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    @State private var active: Bool = false
    
    var body: some View {
        if active {
            if authViewModel.currentUser != nil{
                
                LandingView().environmentObject(authViewModel)
            }else{
                LoginView().environmentObject(authViewModel)
            }
        } else {
            SplashScreen(isActive: $active).environmentObject(authViewModel)
        }
    }
}

#Preview {
  
    Router().withAuthenticationViewModel()
}
