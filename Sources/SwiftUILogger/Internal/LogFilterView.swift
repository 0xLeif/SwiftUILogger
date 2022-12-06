//
//  LogFilterView.swift
//  
//
//  Created by Ahmed Shendy on 12/11/2022.
//

import SwiftUI
import Combine
import OrderedCollections

struct LogFilterView: View {
    
    @State private var searchText: String = ""
    @State private var contentSize: CGSize = .zero
    @State private var filteredTags: [String] = []
    @Binding private var selectedTags: OrderedSet<String>
    
    private var isPresented: Binding<Bool>
    
    private var allTags: [String]
    
    init(
        isPresented: Binding<Bool>,
        allTags: [String],
        selectedTags: Binding<OrderedSet<String>>
    ) {
        self.isPresented = isPresented
        self.allTags = allTags
        self._selectedTags = selectedTags
    }
    
    var body: some View {
        return navigation {
            VStack {
                searchBar
                
                Divider()
                    .padding(.vertical, 5)
                
                tagListView
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelToolbarItem
                }
    
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveToolbarItem
                }
            }
        }
    }
    
    @ViewBuilder
    private func navigation(content: () -> some View) -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content()
            }
        } else {
            NavigationView {
                content()
            }
        }
    }
    
    private var searchBar: some View {
        SearchBar(
            searchText: $searchText,
            placeholder: "Search for tags"
        )
        .navigationTitle("Filter")
        .onReceive(Just(searchText)) { keyword in
            filteredTags = onSearchKeyword(keyword)
        }
    }
    
    private var tagListView: some View {
        ScrollView(.vertical) {
            GeometryReader { proxy in
                LazyVGrid(
                    columns: [GridItem(.flexible())],
                    spacing: 8
                ) {
                    ForEach(filteredTags, id: \.self) { tagName in
                        LogTagView(
                            name: tagName,
                            isSelected: selectedTags.contains(tagName),
                            onTapped: { isTapped in
                                if isTapped,
                                   let index = filteredTags.firstIndex(of: tagName) {
                                    selectedTags.append(filteredTags[index])
                                    
                                } else if let index = selectedTags.firstIndex(of: tagName) {
                                    selectedTags.remove(at: index)
                                }
                            }
                        )
                    }
                }
                .background(
                    Color.clear
                )
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var cancelToolbarItem: some View {
        Button("Cancel") {
            isPresented.wrappedValue = false
        }
    }
    
    private var saveToolbarItem: some View {
        Button("Save") {
            isPresented.wrappedValue = false
        }
    }
    
    // MARK: Helpers
    
    private func onSearchKeyword(_ keyword: String) -> [String] {
        let filtered: [String] = allTags.filter {
            $0
                .lowercased()
                .range(
                    of: keyword.lowercased(),
                    options: .caseInsensitive
                ) != nil
        }

        return filtered.isEmpty ? allTags : filtered
    }
}
