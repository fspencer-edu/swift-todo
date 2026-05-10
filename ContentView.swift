//
//  ContentView.swift
//  ToDo
//
//  Created by Fiona Spencer on 2026-05-10.
//

import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool = false
}

struct ContentView: View {
    @State private var todos: [TodoItem] = []
    @State private var newTodo = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Ender a todo", text: $newTodo)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Add") {
                        addTodo()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                
                List {
                    ForEach($todos) { $todo in
                        HStack {
                            Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(todo.isDone ? .green : .gray)
                                .onTapGesture {
                                    todo.isDone.toggle()
                                }
                            Text(todo.title)
                                .strikethrough(todo.isDone)
                        }
                    }
                    .onDelete(perform: deleteTodo)
                }
            }
            .navigationTitle("Todo List")
        }
    }
    
    func addTodo() {
        let trimmed = newTodo.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {return}
        
        todos.append(TodoItem(title: trimmed))
        newTodo = ""
    }
    
    func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
