//
//  TodoListView.swift
//  coretest
//
//  Created by 駒田隆人 on 2025/10/23.
//
import SwiftUI
import CoreData
import Combine

struct TodoListView: View {
    @StateObject private var viewModel: TodoViewModel
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: TodoViewModel(context: context))
    }
    var body: some View {
        NavigationStack{
            VStack(spacing: 16){
                HStack{
                    TextField("新しい項目を追加", text: $viewModel.newItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: viewModel.addTodo){
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.green)
                    }
                    .disabled(viewModel.newItem.isEmpty)
                }
                .padding()
                List{
                    ForEach(viewModel.items, id: \.self){ item in
                        NavigationLink(destination: TodoDetailView(viewModel: viewModel, id: item.id!)){
                            HStack{
                                Text(item.title)
                                Spacer()
                                Button{
                                    viewModel.toggleDone(for: item)
                                }label: {
                                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(item.isDone ? .green : .gray)
                                }
                            }
                        }
                    }
                    .onDelete(perform: viewModel.delete)
                }
                .listStyle(.plain)
                .navigationTitle("MVVM ToDO")
            }
        }
    }
}
