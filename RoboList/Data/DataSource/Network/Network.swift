//
//  Network.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation
import Apollo
class Network{
    
    static let shared = Network()
    private (set) lazy var apollo = ApolloClient(url: URL(string: URLS.BASE_GRAPH_URL)!)
    
}
