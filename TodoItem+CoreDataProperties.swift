//
//  TodoItem+CoreDataProperties.swift
//  coretest
//
//  Created by 駒田隆人 on 2025/10/21.
//

//public import Foundation
//public import CoreData
//
//
//public typealias TodoItemCoreDataPropertiesSet = NSSet
//
//extension TodoItem {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
//        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
//    }
//
//    @NSManaged public var id: UUID?
//    @NSManaged public var title: String?
//    @NSManaged public var isDone: Bool
//
//}
//
//extension TodoItem : Identifiable {
//
//}

import Foundation
import CoreData

extension TodoItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var isDone: Bool
}

extension TodoItem: Identifiable {}
