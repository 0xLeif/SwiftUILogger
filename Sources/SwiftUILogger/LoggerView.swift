import SwiftUI

public struct LoggerView: View {
    @StateObject private var logger: SwiftUILogger = .default
    @State private var isMinimal: Bool = true

    private let shareAction: (String) -> Void

    public init(
        shareAction: @escaping (String) -> Void = { print($0) }
    ) {
        self.shareAction = shareAction
    }

    public var body: some View {
        navigation {
            ScrollView {
                LazyVStack {
                    ForEach(logger.logs.reversed()) { event in
                        LogEventView(event: event, isMinimal: isMinimal)
                            .padding(.horizontal, 4)
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
        LoggerView()
    }
}
