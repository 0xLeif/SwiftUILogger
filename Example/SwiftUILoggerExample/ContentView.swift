//
//  ContentView.swift
//  SwiftUILoggerExample
//
//  Created by Ahmed Shendy on 12/11/2022.
//

import SwiftUI
import SwiftUILogger

enum Tag: String, LogTagging {
    case activity
    case analysis
    case information
    case web
    case home
    
    var value: String { self.rawValue }
}

struct ContentView: View {
    
    init() {
        logger.log(
            level: .info,
            message: "init",
            tags: [Tag.activity, .analysis, .home]
        )
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            logger.log(
                level: .info,
                message: "onAppear",
                tags: [Tag.home, .information, .web]
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
