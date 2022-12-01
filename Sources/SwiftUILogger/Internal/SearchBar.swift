//
//  SearchBar.swift
//  
//
//  Created by Ahmed Shendy on 12/11/2022.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding private var searchText: String
    private let placeholder: String
    
    init(searchText: Binding<String>, placeholder: String) {
        self._searchText = searchText
        self.placeholder = placeholder
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.lightGray).opacity(0.25))
            
            HStack(alignment: .center) {
                Image(systemName: "magnifyingglass")
                    .imageScale(.medium)
                TextField(placeholder, text: $searchText)
            }
            .foregroundColor(.gray)
            .padding(.horizontal, 15)
        }
        .frame(height: 40)
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}
