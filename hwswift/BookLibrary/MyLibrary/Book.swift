//
//  Book.swift
//  MyLibrary
//
//  Created by gülçin çetin on 16.11.2025.
//

import Foundation
import SwiftData

@Model
class Book {
    var name: String
    var author: String
    var read: Bool
    
    init(name: String, author: String, read: Bool) {
        self.name = name
        self.author = author
        self.read = read
    }
}
