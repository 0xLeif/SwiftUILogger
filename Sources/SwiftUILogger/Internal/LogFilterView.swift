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
    
    @ObservedObject private var logger: SwiftUILogger
    @State private var searchText: String = ""
    @State private var contentSize: CGSize = .zero
    @State private var displayedTags: [String] = []
    @State private var selectedTags: OrderedSet<String>
    
    private var isPresented: Binding<Bool>
    
    private var tags: [String]
    
    init(
        logger: SwiftUILogger = .default,
        tags: [String],
        isPresented: Binding<Bool>
    ) {
        self.logger = logger
        self.tags = tags
        self.isPresented = isPresented
        
        self.selectedTags = logger.filteredTags
    }
    
    var body: some View {
        navigation {
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
                    HStack(spacing: 5) {
                        if selectedTags.isEmpty == false {
                            clearToolbarItem
                        }
                        
                        saveToolbarItem
                    }
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
        .onReceive(Just(searchText)) { keyword in
            displayedTags = onSearchKeyword(keyword)
        }
    }
    
    private var tagListView: some View {
        ScrollView(.vertical) {
            GeometryReader { proxy in
                LazyVGrid(
                    columns: [GridItem(.flexible())],
                    spacing: 8
                ) {
                    Group {
                        ForEach(displayedTags, id: \.self) { tagName in
                            LogTagView(
                                name: tagName,
                                selectedTags: $selectedTags
                            )
                        }
                    }
                    .navigationTitle("Filter")
                }
                .background(Color.clear)
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var cancelToolbarItem: some View {
        Button("Cancel") {
            isPresented.wrappedValue = false
        }
    }
    
    private var clearToolbarItem: some View {
        Button("Clear") {
            selectedTags = []
        }
    }
    
    private var saveToolbarItem: some View {
        Button("Apply") {
            logger.filteredTags = selectedTags
            isPresented.wrappedValue = false
        }
    }
    
    // MARK: Helpers
    
    private func onSearchKeyword(_ keyword: String) -> [String] {
        let filtered: [String] = tags.filter {
            $0
                .lowercased()
                .range(
                    of: keyword.lowercased(),
                    options: .caseInsensitive
                ) != nil
        }

        return filtered.isEmpty ? tags : filtered
    }
}
