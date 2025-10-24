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
            //previewでは、一時的な保存用のものであるので本番本尊ではsharedを用いる。
            
            TodoListView(context: persistenceController.container.viewContext)
        }
    }
}
