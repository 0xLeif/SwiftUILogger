//
//  LogTagView.swift
//  
//
//  Created by Ahmed Shendy on 12/11/2022.
//

import SwiftUI

struct LogTagView: View {
    
    @State private var isSelected: Bool = false

    private let name: String
    private var onTapped: (_ isSelected: Bool) -> Void
    
    init(name: String, onTapped: @escaping (_ isSelected: Bool) -> Void) {
        self.name = name
        self.onTapped = onTapped
    }
    
    var body: some View {
        Button {
            isSelected.toggle()
            onTapped(isSelected)
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
