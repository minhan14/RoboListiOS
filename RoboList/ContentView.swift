//
//  ContentView.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mainViewModel:MainViewModel
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
