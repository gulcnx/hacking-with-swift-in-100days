//
//  Card.swift
//  FlashZilla
//
//  Created by gülçin çetin on 24.10.2025.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th DOctor in Doctor Who?", answer: "Jodie Whittaker")
}
