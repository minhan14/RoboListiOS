//
//  RegisterView.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var authViewModel:AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    
    private var showingAlert: (Binding<Bool>, String) {
        let isShowingBinding = Binding<Bool>(
            get: { if case .error = authViewModel.registerationState { return true } else { return false } },
            set: { newValue in
                if !newValue {
                  
                }
            }
        )
        let errorMessage: String
        if case .error(let message) = authViewModel.registerationState {
            errorMessage = message
        } else {
            errorMessage = ""
        }
        return (isShowingBinding, errorMessage)
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            LottieView(animationFileName: "avd_anim", loopMode: .loop)
                .axisRelativeFrame(for: [.horizontal, .vertical])
                .padding()
            
            FormView(name: $name, password: $password, confirmPassword: $confirmPassword)
       
            
            // Register Button
            Button(action: {
                authViewModel.registerUser(name: name, password: password,confirmPassword: confirmPassword)
            }) {
                Text("Register")
                    .loginButtonStyle()
                    .padding(.horizontal, 20)
            }
            .padding(.top, 60)
            
            Spacer()
            Text("Already have an account?Login")
                .font(.subheadline)
                .underline()
                .padding(.horizontal, 20)
                .onTapGesture {
                    dismiss()
                }
        }
        .alert(isPresented: showingAlert.0) {
            Alert(
                title: Text("Registration Error"),
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

#Preview {
    RegisterView().withAuthenticationViewModel()
}

struct FormView: View {
    @Binding var name:String
    @Binding var password:String
    @Binding var confirmPassword:String
    var body: some View {
        VStack(spacing:15){
            TextField("Enter Your Name", text: $name)
                .loginFormtextFieldStyle()
                .padding(.horizontal, 20)
            
            SecureField("Enter Your Password", text: $password)
                .loginFormtextFieldStyle()
                .padding(.horizontal, 20)
            
            SecureField("Confirm Your Password", text: $confirmPassword)
                .loginFormtextFieldStyle()
                .padding(.horizontal, 20)
        }
        
       
    }
}
