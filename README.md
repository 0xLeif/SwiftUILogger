# SwiftUILogger

*Logging to a SwiftUI View*

## What is SwiftUILogger?

SwiftUILogger allows you to log events by reference. Then you can display all the events using the LoggerView and passing the logger into the initalizer.

## Why use SwiftUILogger?

SwiftUILogger can be used while developing and testing your application to quickly see the debug logs without needing to be attached to LLDB session or Xcode.

## Example Usage

```swift
import SwiftUI
import SwiftUILogger

let logger = SwiftUILogger(name: "Demo")

@main
struct SwiftUILogger_DemoApp: App {
    @State private var isPresentedLogger: Bool = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
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
