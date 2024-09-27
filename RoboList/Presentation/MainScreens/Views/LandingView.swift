//
//  LandingView.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import SwiftUI
import MyApi
import Kingfisher

struct LandingView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.characterState {
                case .loading:
                    ProgressView("Loading characters...")
                    
                case .success(let characters):
                    let charactersWithImages = characters.compactMap { $0 }
                    
                    List(charactersWithImages, id: \.id) { character in
                        
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            CharacterRowView(character: character)
                        }
                    }
                    
                    .onAppear {
                        if characters.isEmpty {
                            viewModel.fetchCharacters(page: viewModel.currentPage) // Fetch first page
                        } else if let lastCharacter = characters.last {
                            if lastCharacter == character {
                                viewModel.currentPage += 1 // Increment page
                                viewModel.fetchCharacters(page: viewModel.currentPage) // Fetch next page
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                case .error(let message):
                    Text("Error: \(message)")
                    
                case .idle:
                    Text("No characters available.")
                }
            }
        }
        Text(authViewModel.currentUser?.name ?? "loading")
    }
}

struct CharacterRowView: View {
    
    var character: GetCharactersQuery.Data.Characters.Result
    
    var body: some View {
        HStack {
            // Kingfisher for image loading
            if let imageUrl = character.image, let url = URL(string: imageUrl) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
            }
            
            VStack(alignment: .leading) {
                Text(character.name ?? "Unknown")
                    .font(.headline)
                Text(character.species ?? "Unknown species")
                    .font(.subheadline)
                Text(character.status ?? "Unknown status")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 5)
    }
}

struct CharacterDetailView: View {
    let character: GetCharactersQuery.Data.Characters.Result
    
    var body: some View {
        VStack {
            if let imageUrl = character.image {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
            Text(character.name ?? "Unknown Name")
                .font(.largeTitle)
                .padding()
            Text("Species: \(character.species ?? "Unknown")")
            Text("Status: \(character.status ?? "Unknown")")
        }
        .navigationTitle(character.name ?? "Character Details")
        .padding()
    }
}

#Preview {
    LandingView().withAuthenticationViewModel()
}
