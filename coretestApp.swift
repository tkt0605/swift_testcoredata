//
//  coretestApp.swift
//  coretest
//
//  Created by 駒田隆人 on 2025/10/20.
//

import SwiftUI
import CoreData

@main
struct coretestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            DebugTextFieldView()
            TestRunCoredata()
                    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
