//
//  FavCharacters.swift
//  RoboList
//
//  Created by Chico Han on 28/09/2024.
//

import Foundation
import SwiftData


@Model
class Character {
    var id: String
    var userId: UUID
    var name: String
    var status: Status
    var species: String
    var locationId: String
    var dimesion: String
    var image: String

    init(id:String,userId:UUID, name: String, status: Status, species: String, locationId:String, dimension:String , image: String) {
        self.id = id
        self.name = name
        self.userId = userId
        self.status = status
        self.species = species
        self.locationId = locationId
        self.dimesion = dimension
        self.image = image
    }
}

@Model
class Location {
    var id: String?
    var dimension: String?

    init(id: String? = nil, dimension: String? = nil) {
        self.id = id
        self.dimension = dimension
    }
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
