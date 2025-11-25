//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by gülçin çetin on 10.10.2025.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
