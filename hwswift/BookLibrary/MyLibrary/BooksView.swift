//
//  BooksView.swift
//  MyLibrary
//
//  Created by gülçin çetin on 16.11.2025.
//

import SwiftData
import SwiftUI

enum FilteringType {
    case read, notRead, none
}

struct BooksView: View {
    @Environment(\.modelContext) var modelContext
    var filterType: FilteringType
    @Query var books: [Book]
    
    init(sortOrder: [SortDescriptor<Book>], filterType: FilteringType = .none) {
        self.filterType = filterType
        let predicate: Predicate<Book>
        
        switch filterType {
        case .read:
            predicate = #Predicate { $0.read == true }
        case .notRead:
            predicate = #Predicate { $0.read == false }
        case .none:
            predicate = #Predicate { _ in true }
        }
        _books = Query(filter: predicate, sort: sortOrder)
    }
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(books) { book in
                    HStack {
                        VStack(alignment: .leading){
                            Text("\(book.name)")
                            Text("\(book.author)")
                                .font(.headline)
                        }
                        Spacer()
                        Text(book.read == true ? "read" : "not read")
                            .font(.headline)
                    }
                }
                .onDelete(perform: deleteBook)
            }
        }
    }
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}
