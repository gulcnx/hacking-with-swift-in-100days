//
//  User.swift
//  SwiftDataProject
//
//  Created by gülçin çetin on 15.09.2025.
//

import SwiftData
import SwiftUI

@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
