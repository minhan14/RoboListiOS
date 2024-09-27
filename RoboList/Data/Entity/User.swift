//
//  Entity.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation
import SwiftData

@Model
class User: Equatable {
    
    @Attribute(.unique) var id: UUID
    var name: String
    var encryptedPassword: String
    
    init(name: String, encryptedPassword: String) {
        self.id = UUID()
        self.name = name
        self.encryptedPassword = encryptedPassword
    }
}
