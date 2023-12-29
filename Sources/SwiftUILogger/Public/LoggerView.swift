import SwiftUI
import OrderedCollections

///
public struct LoggerView: View {
    
    @StateObject private var logger: SwiftUILogger
    @State private var isMinimal: Bool = true
    @State private var isPresentedFilter: Bool = false
    
    private var logs: [SwiftUILogger.Event] { logger.displayedLogs }
    
    private var tags: OrderedSet<String> {
        OrderedSet(
            logger.logs
                .flatMap { $0.metadata.tags }
                .map { $0.value }
        )
    }
    
    private var navigationTitle: String {
        "\(logs.count) \(logger.name.map { "\($0) " } ?? "")Events"
    }
    private let shareAction: (String) -> Void
    
    ///
    public init(
        logger: SwiftUILogger = .default,
        shareAction: @escaping (String) -> Void = { print($0) }
    ) {
        self._logger = StateObject(wrappedValue: logger)
        self.shareAction = shareAction
    }
    
    ///
    public var body: some View {
        navigation {
            Group {
                if logs.isEmpty {
                    Text("Logs will show up here!")
                        .font(.largeTitle)
                } else {
                    ScrollView {
                        LazyVStack {
                            let logCount = logs.count - 1
                            ForEach(0 ... logCount, id: \.self) { index in
                                let log = logs[logCount - index]
                                
                                LogEventView(
                                    event: log,
                                    isMinimal: isMinimal
                                )
                                .padding(.horizontal, 4)
                            }
                        }
                    }
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                HStack {
                    shareBlobButton
                    filterButton
                    toggleMinimalButton
                }
                .disabled(logs.isEmpty)
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
    
    private var shareBlobButton: some View {
        Button(
            action: {
                shareAction(logger.blob)
            },
            label: {
                Image(systemName: "square.and.arrow.up")
            }
        )
    }
    
    private var filterButton: some View {
        Button(
            action: {
                withAnimation {
                    isPresentedFilter.toggle()
                }
            },
            label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
            }
        )
        .sheet(isPresented: $isPresentedFilter) {
            LogFilterView(
                logger: logger,
                tags: Array(tags),
                isPresented: $isPresentedFilter
            )
        }
    }
    
    private var toggleMinimalButton: some View {
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

