//
//  ContentView.swift
//  MyLibrary
//
//  Created by gülçin çetin on 16.11.2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query var books: [Book]
    @State private var addBook = false
    @State private var sortOrder = [
        SortDescriptor(\Book.name),
        SortDescriptor(\Book.author)
    ]
    @State private var filterType: FilteringType = .none

    var body: some View {
            NavigationStack {
                ZStack{
                    LinearGradient(colors: [.blue, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                VStack{
                    BooksView(sortOrder: sortOrder, filterType: filterType)
                }
                .sheet(isPresented: $addBook) {
                    AddBook(books: books)
                }
                .toolbar{
                    ToolbarItem(placement: .principal){
                        Text("My Books")
                            .foregroundStyle(LinearGradient(colors: [.green, .teal], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .italic()
                            .font(.title)
                            .bold()
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button("", systemImage: "plus") {
                            addBook = true
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        EditButton()
                    }
                    ToolbarItem {
                            Menu("", systemImage: "line.3.horizontal.decrease") {
                                Picker("", selection: $sortOrder){
                                        Text("Sort by Name")
                                            .tag([
                                                SortDescriptor(\Book.name),
                                                SortDescriptor(\Book.author)
                                            ])
                                        Text("Sort by Author")
                                            .tag([
                                                SortDescriptor(\Book.author),
                                                SortDescriptor(\Book.name)
                                            ])
                                    }
                            }
                        }
                        ToolbarItem {
                            Menu("", systemImage: "checklist") {
                                Picker("", selection: $filterType) {
                                    Text("Only Read")
                                        .tag(
                                            FilteringType.read
                                        )
                                    Text("Only Not Read")
                                        .tag(
                                            FilteringType.notRead
                                        )
                                    Text("Show All")
                                        .tag(
                                            FilteringType.none
                                        )
                                }
                            }
                        }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ContentView()
}
