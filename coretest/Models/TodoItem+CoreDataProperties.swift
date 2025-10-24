//
//  TodoItem+CoreDataProperties.swift
//  coretest
//
//  Created by 駒田隆人 on 2025/10/22.
//
//

public import Foundation
public import CoreData


public typealias TodoItemCoreDataPropertiesSet = NSSet

extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isDone: Bool
    @NSManaged public var title: String

}

extension TodoItem : Identifiable {
//    public static func == (lhc: TodoItem, rhs: TodoItem) -> Bool{
//        return lhs.objectID == rhs.objectID
//    }
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(objectID)
//    }
}
