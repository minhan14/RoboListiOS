//
//  LoginView.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    
    @EnvironmentObject var authViewModel:AuthenticationViewModel
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var alertState: (isShowing: Bool, message: String) = (false, "")
    @State private var isPasswordVisible: Bool = false
    @State private var isRegistering: Bool = false
    
    private var showingLoading: Binding<Bool> {
        Binding(
            get: { if case .loading = authViewModel.loginState { return true } else { return false } },
            set: { _ in
                
            }
        )
    }
    private var showingAlert: (Binding<Bool>, String) {
        let isShowingBinding = Binding<Bool>(
            get: { if case .error = authViewModel.loginState { return true } else { return false } },
            set: { newValue in
                if !newValue {
                    alertState.message = ""
                }
            }
        )
        let errorMessage: String
        if case .error(let message) = authViewModel.loginState {
            errorMessage = message
        } else {
            errorMessage = ""
        }
        return (isShowingBinding, errorMessage)
    }
    
    var body: some View {
        LoadingView(isShowing:showingLoading){
            NavigationStack {
                VStack(spacing:10) {
                    Spacer()
                        LottieView(animationFileName: "avd_anim", loopMode: .loop)
                        .axisRelativeFrame(for: [.horizontal, .vertical])
                            .padding()
              
                    
               
                    TextField("Enter Your Name", text: $name)
                        .loginFormtextFieldStyle()
                        .padding(.horizontal, 20)
                    
                    ZStack {
                        if isPasswordVisible {
                            TextField("Enter Your Password", text: $password)
                                .loginFormtextFieldStyle()
                        } else {
                            SecureField("Enter Your Password", text: $password)
                                .loginFormtextFieldStyle()
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 20)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Login Button
                    Button(action: {
                        authViewModel.authenticateUser(name: name, password: password)
                    }) {
                        Text("Login")
                            .loginButtonStyle()
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 60)
                    Spacer()
                    Text("Do not have an account? Register")
                        .font(.subheadline)
                        .underline()
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            isRegistering = true
                        }
            
                    
                }
                .navigationDestination(isPresented: $isRegistering) {
                    RegisterView().environmentObject(authViewModel).navigationBarBackButtonHidden()
                }
                .alert(isPresented: showingAlert.0) {
                    Alert(
                        title: Text("Login Error"),
                        message: Text(showingAlert.1),
                        dismissButton: .default(Text("OK")){
                            authViewModel.resetState()
                        }
                    )
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
            }
            
        }
    }
    
    
}


#Preview {
     LoginView().withAuthenticationViewModel()
}
