//
//  Day10_TestCoredata.swift
//  coretest
//
//  Created by 駒田隆人 on 2025/10/20.
//
import SwiftUI
import CoreData

struct TestRunCoredata: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: TodoItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoItem.title, ascending: true)]
    ) private var items: FetchedResults<TodoItem>
    @State private var newItem = ""
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0){
                HStack{
                    TextField("新しい項目", text: $newItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    Button(action: {
                        guard !newItem.isEmpty else {return}
                        addItems()
                    }){
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.green)
                    }
                    .disabled(newItem.isEmpty)
                    
                }
//                .background(Color(UIColor.secondarySystemBackground))
                Divider()
                List{
                    ForEach(items, id: \.objectID){ item in
                        HStack{
                            Text(item.title ?? "")
                            Spacer()
                            Image(systemName: item.isDone ? "checkmark.circle.fill": "circle")
                                .foregroundColor(item.isDone ? .green : .gray)
                                .onTapGesture {
                                    ToggleDone(for: item)
                                }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            ToggleDone(for: item)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
//                .listStyle(.plain)
            }
            .navigationTitle("ToDOリスト")
        }
    }
    private func addItems(){
        let new = TodoItem(context: viewContext)
        new.id = UUID()
        new.title = newItem
        new.isDone = false
        saveCoreData()
        newItem = ""
    }
    private func saveCoreData(){
        do {
            try viewContext.save()
        }catch{
            print("保存失敗: \(error)")
        }
    }
    private func deleteItems(at offsets: IndexSet){
        offsets.map {
            items[$0]
        }.forEach(viewContext.delete)
        saveCoreData()
    }
    private func ToggleDone(for item: TodoItem){
        item.isDone.toggle()
        saveCoreData()
    }
}

#Preview {
    TestRunCoredata()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
    
