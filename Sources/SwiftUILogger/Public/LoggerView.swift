import SwiftUI

public struct LoggerView: View {
    @ObservedObject private var logger: SwiftUILogger
    @State private var isMinimal: Bool = true

    private let shareAction: (String) -> Void

    public init(
        logger: SwiftUILogger = .default,
        shareAction: @escaping (String) -> Void = { print($0) }
    ) {
        self.logger = logger
        self.shareAction = shareAction
    }

    public var body: some View {

            navigation {
                Group {
                    if logger.logs.isEmpty {
                        Text("Logs will show up here!")
                            .font(.largeTitle)
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach((logger.logs.count - 1 ... 0), id: \.self) { index in
                                    LogEventView(
                                        event: logger.logs[index],
                                        isMinimal: isMinimal
                                    )
                                    .padding(.horizontal, 4)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("\(logger.logs.count) Events")
                .toolbar {
                    HStack {
                        Button(
                            action: {
                                shareAction(logger.blob)
                            },
                            label: {
                                Image(systemName: "square.and.arrow.up")
                            }
                        )

                        Button(
                            action: {
                                withAnimation {
                                    isMinimal.toggle()
                                }
                            },
                            label: {
                                Image(systemName: isMinimal ? "list.bullet.circle" : "list.bullet.circle.fill")
                            }
                        )
                    }
                    .disabled(logger.logs.isEmpty)
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

struct LoggerView_Previews: PreviewProvider {
    static var previews: some View {
        LoggerView(
            logger: SwiftUILogger(
                name: "Preview",
                logs: [
                    .init(level: .success, message: "init")
                ]
            )
        )
    }
}

