//
//  UiState.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation

enum UIState<T>: Equatable where T: Equatable {
    case idle
    case loading
    case success(T)
    case error(String)
    
    static func == (lhs: UIState<T>, rhs: UIState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading):
            return true
        case (.success(let lhsUser), .success(let rhsUser)):
            return lhsUser == rhsUser
        case (.error(let lhsMessage), .error(let rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}
