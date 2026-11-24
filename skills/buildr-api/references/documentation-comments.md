# Documentation Comments & Complexity Declarations

Professional Swift APIs include DocC-compatible Markdown documentation comments.

---

## 1. Structure of a Swift Doc Comment

```swift
/// Computes the total discounted price for all eligible cart items.
///
/// This method traverses all line items, applies the active promotional rule,
/// and rounds down according to the store's currency rules.
///
/// - Parameters:
///   - promoCode: The promotional voucher string to validate.
///   - currency: The ISO-4217 currency code.
/// - Returns: A `Decimal` value representing the final charge amount.
/// - Throws: `CheckoutError.invalidPromoCode` if the promo cannot be applied.
///
/// - Complexity: O(n), where n is the number of items in the cart.
public func calculateDiscount(promoCode: String?, currency: CurrencyCode) throws -> Decimal {
    // ...
}
```

---

## 2. Complexity Disclosure Rules

Always disclose algorithmic complexity when it is non-obvious:
- If a property access is $\mathcal{O}(n)$ rather than $\mathcal{O}(1)$, document it prominently (or preferably convert it to a method `calculateTotal()` instead of a computed property).
- Inform callers if an operation triggers disk I/O or network serialization.
