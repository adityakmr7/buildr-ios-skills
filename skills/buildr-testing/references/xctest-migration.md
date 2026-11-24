# Migration Guide: `XCTest` to `Swift Testing`

Translating legacy `XCTest` concepts and assertions to modern Swift Testing.

---

## 1. Class vs Struct / Macro Mapping

| XCTest | Swift Testing |
| :--- | :--- |
| `import XCTest` | `import Testing` |
| `class MyTests: XCTestCase` | `struct MyTests` or `@Suite struct MyTests` |
| `func testSomething()` | `@Test func something()` |
| `func testSomethingWithCustomName()` | `@Test("Descriptive test name") func something()` |
| `override func setUp() async throws` | `init() async throws` |
| `override func tearDown() async throws` | `deinit` |

---

## 2. Assertion Equivalents

| Legacy `XCTest` Assertion | Modern `Swift Testing` Macro |
| :--- | :--- |
| `XCTAssert(x)` | `#expect(x)` |
| `XCTAssertTrue(x)` | `#expect(x)` |
| `XCTAssertFalse(x)` | `#expect(!x)` |
| `XCTAssertEqual(a, b)` | `#expect(a == b)` |
| `XCTAssertNotEqual(a, b)` | `#expect(a != b)` |
| `XCTAssertNil(x)` | `#expect(x == nil)` |
| `XCTAssertNotNil(x)` | `let val = try #require(x)` or `#expect(x != nil)` |
| `XCTAssertGreaterThan(a, b)` | `#expect(a > b)` |
| `XCTAssertThrowsError(try expr())` | `#expect(throws: (any Error).self) { try expr() }` |
| `XCTAssertNoThrow(try expr())` | `try expr()` (let standard throwing fail the test) |
| `expectation(description:)` | `await confirmation(...)` |

---

## 3. Migration Example

### Before (`XCTest`):
```swift
class OrderTests: XCTestCase {
    var order: Order!
    
    override func setUp() {
        super.setUp()
        order = Order()
    }
    
    func testAddItems() {
        order.addItem("Coffee", price: 3.50)
        XCTAssertEqual(order.total, 3.50)
        XCTAssertFalse(order.items.isEmpty)
    }
}
```

### After (`Swift Testing`):
```swift
@Suite("Order Processing")
struct OrderTests {
    var order = Order()
    
    @Test("Adding items calculates total correctly")
    mutating func addItems() {
        order.addItem("Coffee", price: 3.50)
        #expect(order.total == 3.50)
        #expect(!order.items.isEmpty)
    }
}
```
