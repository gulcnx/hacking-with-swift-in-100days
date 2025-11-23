//
//  AddBook.swift
//  MyLibrary
//
//  Created by gülçin çetin on 16.11.2025.
//

import SwiftData
import SwiftUI

struct AddBook: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    var books: [Book]
    @State private var name = ""
    @State private var author = ""
    @State private var read = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.cyan, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Image(.hippo)
                    
                    VStack {
                        TextField("Enter name of book", text: $name)
                            .padding()
                        TextField("Enter name of author", text: $author)
                            .padding()
                        Toggle("Have you read it yet?" , isOn: $read)
                            .padding()
                            .tint(.blue)
                    }
                    .padding()
                    .background(Color.cyan.opacity(0.6))
                    .frame(width: 350)
                    .padding()
                    .clipShape(.capsule)
                }
            }
            .navigationTitle("Add Book")
            .toolbar {
                ToolbarItem{
                    Button("", systemImage: "checkmark") {
                        let newBook = Book(name: name, author: author, read: read)
                        modelContext.insert(newBook)
                        
                        dismiss()
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                }
            }
        }
    }
}
