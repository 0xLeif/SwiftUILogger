import XCTest
@testable import SwiftUILogger

final class SwiftUILoggerTests: XCTestCase {
    func testExample() throws {
        let localLogger = SwiftUILogger.default

        SwiftUILogger.default.log(level: .success, message: "New Log!")

        XCTAssertEqual(localLogger.logs.count, 1)
    }
}
