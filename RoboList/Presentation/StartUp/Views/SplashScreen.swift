//
//  SplashScreen.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import SwiftUI

struct SplashScreen: View {
    
    @Binding var isActive: Bool
    @State private var scale: CGFloat = 0.5
    @State private var opacity = 0.5
    @State private var size = 0.8
    
    
    var body: some View {
        ZStack {
            LottieView(animationFileName: "avd_anim", loopMode: .loop)
                .frame(width: 100, height: 100)
        }
        .scaleEffect(size)
        .opacity(opacity)
        .onAppear{
            withAnimation(.easeIn(duration: 1.2)){
                self.size = 0.9
                self.opacity = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.isActive = true
            }
        }
        .edgesIgnoringSafeArea(.all)
        
        
    }
}

#Preview {
    return SplashScreen(isActive: .constant(true))
}
