//
//  LandingView.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import SwiftUI
import MyApi
import Kingfisher
import SwiftData

struct LandingView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var viewModel = MainViewModel()
    
    var favList: [GetCharactersQuery.Data.Characters.Result?] = []
    
    private var showInitialLoading: Binding<Bool> {
        Binding(
            get: {
                return (viewModel.isLoading && viewModel.currentPage == 1 )
            },
            set: { _ in
                
            }
        )
    }
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: showInitialLoading) {
                VStack(spacing:0){
                   
                    HStack{
                        Text(authViewModel.currentUser?.name ?? "loading").padding().onTapGesture {
                            authViewModel.logout()
                        }
                        Spacer()
                        NavigationLink(destination: FavoritesView(userId: authViewModel.currentUser?.id ?? UUID())) {
                            Image(systemName:  "heart.fill")
                                .foregroundColor(.red)
                                .frame(width: 30, height: 30)
                        }
                    }.padding()
                   
                               
                    
                 //   let charactersWithImages = viewModel.characters.compactMap { $0 }
                    List {
                        ForEach(viewModel.characters, id: \.id) { character in
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                CharacterRowView(userId: authViewModel.currentUser?.id ?? UUID(), character: character)
                            }
                            
                            .onAppear {
                                if character.id == viewModel.characters.last?.id {
                                    viewModel.fetchNextPage(userId: authViewModel.currentUser?.id)
                                }
                            }
                        }
                        if viewModel.isLoading && viewModel.currentPage != 1 {
                            HStack(alignment:.center) {
                                Spacer()
                                ProgressView("Loading more...")
                                Spacer()
                            }
                        }
                        if viewModel.endOfPagingReached &&  !viewModel.isLoading {
                            Text("No more characters available.")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                }
            }
            
        }
            .onAppear {
                viewModel.fetchCharacters(page: viewModel.currentPage, userId: authViewModel.currentUser?.id)
            }
        
    }
}


struct CharacterRowView: View {
    let userId:UUID
    @Environment(\.modelContext) var context
    @Query(sort:\Character.id) var favorites: [Character]
    var character: Character
    init(userId: UUID,character: Character) {
        self.userId = userId
        self.character = character
        _favorites = Query(filter: #Predicate<Character>{ character in
            character.userId == userId
        },sort:\Character.name)
       
    }
  
    
    var body: some View {
        HStack(){
            let imageUrl = character.image
            let url = URL(string: imageUrl)
            KFImage(url)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .conditionalHorizontalContainerFrame(dimens: 0.2)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                Text(character.species)
                    .font(.subheadline)
                Text(character.status.rawValue)
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("Location: \( character.dimesion)")
                    .font(.caption)
                
            }
            Spacer()
            Button(action: {
                toggleFavorite(character: character)
            }) {
                Image(systemName: isFavorite(character: character) ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite(character: character) ? .red : .gray)
                    .frame(width: 30, height: 30)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 5)
    }
    private func toggleFavorite(character: Character) {
        if let index = favorites.firstIndex(where: { $0.id == character.id }) {
            context.delete(favorites[index])
            
        } else {
           
            context.insert(character)
        }
    }
    private func isFavorite(character: Character) -> Bool {
        return favorites.contains(where: { $0.id == character.id })
    }
}

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        VStack {
            let imageUrl = character.image
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .conditionalHorizontalContainerFrame(dimens: 0.9)
            
            Text(character.name)
                .font(.largeTitle)
                .padding()
            Text("Species: \(character.species)")
            Text("Status: \(character.status.rawValue)")
        }
        .navigationTitle(character.name)
        .padding()
    }
}

#Preview {
    LandingView().withAuthenticationViewModel()
}

struct FavoritesView: View {
    let userId:UUID
    @Environment(\.modelContext) var context
    @Query(sort:\Character.id) var favorites: [Character]
    init(userId:UUID) {
        self.userId = userId
        _favorites = Query(filter: #Predicate<Character>{ character in
            character.userId == userId
        },sort:\Character.name)
    }
    var body: some View {
        
        List {
            ForEach(favorites, id: \.id) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    CharacterRowView(userId: userId,character: character)
                }
            }.onDelete(perform: { indexSet in
                for index in indexSet{
                    context.delete(favorites[index])
                }
                
            })
        }
        .navigationTitle("Favorites")
    }
}
