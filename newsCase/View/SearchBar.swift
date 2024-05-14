//
//  SearchBar.swift
//  newsCase
//
//  Created by R. Metehan GÖKTAŞ on 14.05.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("Search", text: $text, onCommit: {
                onSearch(text)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            
            Button(action: {
                onSearch(text)
            }) {
                Text("Search")
                    .padding(.horizontal)
            }
        }
    }
}




