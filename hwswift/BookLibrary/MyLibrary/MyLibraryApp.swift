//
//  MyLibraryApp.swift
//  MyLibrary
//
//  Created by gülçin çetin on 16.11.2025.
//

import SwiftData
import SwiftUI

@main
struct MyLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
