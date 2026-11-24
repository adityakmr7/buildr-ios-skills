# Parameterized Testing in Swift Testing

Parameterized testing allows running a single test function across dozens of different data inputs without writing repetitive loops.

---

## 1. Single Collection Parameterization

```swift
import Testing

struct ValidatorTests {
    @Test("Validates email formats correctly", arguments: [
        ("user@domain.com", true),
        ("support@company.co.uk", true),
        ("invalid-email", false),
        ("@missing-username.com", false),
        ("missing-at.com", false),
        ("", false)
    ])
    func validateEmail(email: String, expectedResult: Bool) {
        let isValid = EmailValidator.isValid(email)
        #expect(isValid == expectedResult, "Email '\(email)' validation mismatch")
    }
}
```

---

## 2. Multi-Collection Cartesian Products

Passing multiple collections generates every combination:

```swift
enum PaymentMethod: CaseIterable {
    case applePay, creditCard, payPal
}

enum Currency: CaseIterable {
    case usd, eur, gbp
}

struct CheckoutTests {
    // Tests all 3 x 3 = 9 combinations automatically
    @Test("Process checkout across currencies and payment methods", arguments: PaymentMethod.allCases, Currency.allCases)
    func testCheckoutMatrix(method: PaymentMethod, currency: Currency) async throws {
        let result = try await PaymentProcessor.process(amount: 100, method: method, currency: currency)
        #expect(result.status == .approved)
    }
}
```

---

## 3. Zipping Collections (Pairwise)

If you do NOT want a cartesian product, but parallel paired inputs:

```swift
@Test("Paired discount codes", arguments: zip(["SUMMER", "WINTER"], [10, 20]))
func testDiscounts(code: String, percent: Int) {
    #expect(DiscountEngine.percentage(for: code) == percent)
}
```
