//
//  LoadingView.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    @State var animate = false
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .center) {
            if (!self.isShowing) {
                self.content()
            } else {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                VStack {
                    ProgressView("Loading...")
                        .scaleEffect(1, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint:.blue))
                        .foregroundColor(.black)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(15)
                .onAppear {
                    self.animate.toggle()
                }
            }
        }
    }
}

#Preview {
    LoadingView(isShowing: .constant(true)) {
        VStack {
            Text("Main Content")
                .padding()
        }
    }
}
