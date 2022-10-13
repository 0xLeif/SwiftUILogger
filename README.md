# SwiftUILogger

*TODO*

## What is SwiftUILogger?

A single SwiftUI view that consolidates all log events using a singleton.

## Why use SwiftUILogger?

Global app logging.

## Example Usage

```swift
import SwiftUI
import SwiftUILogger

let logger = SwiftUILogger.default

@main
struct SwiftUILogger_DemoApp: App {
    @State private var isPresentedLogger: Bool = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .sheet(isPresented: $isPresentedLogger) {
                        LoggerView()
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
}

// MARK: - ContentView

struct ContentView: View {
    init() {
        logger.log(level: .info, message: "init")
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
            logger.log(level: .info, message: "onAppear")
        }
    }
}

```
