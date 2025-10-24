//
//  TodoViewModel.swift
//  coretest
//
//  Created by 駒田隆人 on 2025/10/23.
//
import SwiftUI
import CoreData
import Combine

final class TodoViewModel: ObservableObject {
    @Published var newItem = ""
    @Published var items: [TodoItem] = []
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchTodos()
    }
    func addTodo(){
        guard !newItem.isEmpty else {return}
        let todo = TodoItem(context: context)
        todo.id = UUID()
        todo.title = newItem
        todo.isDone = false
        saveContext()
        fetchTodos()
        newItem = ""
    }
    func toggleDone(for item: TodoItem){
        item.isDone.toggle()
        saveContext()
        fetchTodos()
    }
    func delete(at offsets: IndexSet){
        offsets.map {
            items[$0]
        }.forEach(context.delete)
        saveContext()
        fetchTodos()
    }
    private func fetchTodos(){
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TodoItem.title, ascending: true)]
        do{
            items = try context.fetch(request)
        }catch{
            print("⚠️ Fetch失敗: \(error)")
        }
    }
    private func saveContext(){
        do{
            try context.save()
        }catch{
            print("⚠️ 保存失敗: \(error)")
        }
    }
    func optionalBinding(for id: UUID) -> Binding<TodoItem>?{
        guard let index = items.firstIndex(where: { $0.id == id }) else { return nil }
        return Binding(
            get: { self.items[index] },
            set: { self.items[index] = $0 }
        )
    }
}
