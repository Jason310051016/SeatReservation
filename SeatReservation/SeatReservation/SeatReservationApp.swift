//
//  SeatReservationApp.swift
//  SeatReservation
//
//  Created by student on 10/5/2024.
//

import SwiftUI
import SwiftData

@main
struct SeatReservationApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SeatReservationDB.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
           ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
