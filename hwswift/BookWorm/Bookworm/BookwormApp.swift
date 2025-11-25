//
//  BookwormApp.swift
//  Bookworm
//
//  Created by gülçin çetin on 1.09.2025.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Book.self)
    }
}
