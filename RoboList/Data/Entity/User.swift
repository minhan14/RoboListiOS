//
//  Entity.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation
import SwiftData

@Model
class User: Codable,Equatable {
    
    @Attribute(.unique) var id: UUID
    var name: String
    var encryptedPassword: String
    
    init(name: String, encryptedPassword: String) {
        self.id = UUID()
        self.name = name
        self.encryptedPassword = encryptedPassword
    }
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        encryptedPassword = ""
    }
    
    func encodeToString() throws -> String {
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(self)
        return String(data: encoded, encoding: .utf8)!
    }
    
    static func decodeFromString(_ jsonString: String) throws -> User {
        let decoder = JSONDecoder()
        let jsonData = jsonString.data(using: .utf8)!
        return try decoder.decode(User.self, from: jsonData)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id // Compare based on the unique identifier
    }
}
