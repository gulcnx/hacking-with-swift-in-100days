//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by gülçin çetin on 15.09.2025.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
