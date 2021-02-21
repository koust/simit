import XCTest
@testable import simit

final class simitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(simit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
