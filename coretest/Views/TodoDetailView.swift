//
//  TodoDetailView.swift
//  coretest
//
//  Created by 駒田隆人 on 2025/10/23.

import SwiftUI
//import CoreData
import Combine

struct TodoDetailView: View {
    @ObservedObject var viewModel: TodoViewModel
    let id: UUID
    var body: some View {
        if let binding = viewModel.optionalBinding(for: id){
            VStack(spacing: 16){
                TextField("タイトルを入力", text: binding.title)
                    .font(.title3)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Toggle("完了", isOn: binding.isDone)
                    .toggleStyle(.switch)
                    .padding()
                Spacer()
            }
            .padding()
            .navigationTitle(
                Text(verbatim: "\(binding.title.wrappedValue)の詳細")
            )
        }else{
            Text("⚠️ 該当する項目がありません。")
                .foregroundStyle(.red)
        }
    }
}
