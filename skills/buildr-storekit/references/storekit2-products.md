# StoreKit 2: Products, Purchases & Verification

StoreKit 2 is built natively for modern Swift and concurrency.

---

## 1. Fetching Products & Purchasing

```swift
import StoreKit
import SwiftUI

@MainActor
@Observable
final class StoreManager {
    var products: [Product] = []
    var purchasedProductIDs = Set<String>()
    
    func fetchProducts(productIdentifiers: [String]) async {
        do {
            self.products = try await Product.products(for: productIdentifiers)
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    func purchase(_ product: Product) async throws -> Bool {
        let result = try await product.purchase()
        
        switch result {
        case .success(let verificationResult):
            let transaction = try checkVerified(verificationResult)
            // Deliver content to user
            self.purchasedProductIDs.insert(transaction.productID)
            // Always finish the transaction
            await transaction.finish()
            return true
            
        case .userCancelled:
            return false
            
        case .pending:
            // e.g. "Ask to Buy" parental approval
            return false
            
        @unknown default:
            return false
        }
    }
}
```

---

## 2. JWS Verification Function

Apple signs transactions with JSON Web Signatures (JWS):

```swift
func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
    switch result {
    case .unverified:
        throw StoreError.failedVerification
    case .verified(let safeValue):
        return safeValue
    }
}
```

---

## 3. Transaction Updates Listener

Start this listener immediately at app launch:

```swift
func listenForTransactions() -> Task<Void, Never> {
    Task(priority: .background) {
        for await result in Transaction.updates {
            do {
                let transaction = try checkVerified(result)
                await updatePurchasedState(for: transaction)
                await transaction.finish()
            } catch {
                print("Transaction failed verification: \(error)")
            }
        }
    }
}
```
