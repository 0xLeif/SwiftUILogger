//
//  LogTagView.swift
//  
//
//  Created by Ahmed Shendy on 12/11/2022.
//

import SwiftUI
import OrderedCollections

struct LogTagView: View {
    
    @Binding private var selectedTags: OrderedSet<String>
    
    var isSelected: Bool {
        selectedTags.contains(name)
    }

    private let name: String
    
    init(name: String, selectedTags: Binding<OrderedSet<String>>) {
        self.name = name
        self._selectedTags = selectedTags
    }
    
    var body: some View {
        return Button {
            if isSelected {
                selectedTags.remove(name)
            } else {
                selectedTags.append(name)
            }
        } label: {
            ZStack {
                HStack {
                    Spacer()
                    Image(systemName: isSelected ? "checkmark" : "plus")
                        .imageScale(.medium)
                }
                HStack {
                    Text(name)
                        .padding(.trailing, 22)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            .foregroundColor(.white)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .background(isSelected ? Color.blue : Color.gray)
        .cornerRadius(8)
    }
}
