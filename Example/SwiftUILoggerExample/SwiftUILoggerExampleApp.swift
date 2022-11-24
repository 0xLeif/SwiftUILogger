//
//  SwiftUILoggerExampleApp.swift
//  SwiftUILoggerExample
//
//  Created by Ahmed Shendy on 12/11/2022.
//

import SwiftUI
import SwiftUILogger

let logger = SwiftUILogger(name: "Demo")

@main
struct SwiftUILoggerExampleApp: App {
    @State private var isPresentedLogger: Bool = false
    
    var body: some Scene {
        WindowGroup {
            navigation {
                ContentView()
                    .sheet(isPresented: $isPresentedLogger) {
                        LoggerView(logger: logger)
                    }
                    .toolbar {
                        Button(
                            action: { isPresentedLogger.toggle() },
                            label: { Image(systemName: "ladybug") }
                        )
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
}
