# iOS Keychain Services & Credential Security

The Keychain provides hardware-accelerated, encrypted storage for small secrets (tokens, keys, passwords).

---

## 1. Type-Safe Keychain CRUD Wrapper

```swift
import Foundation
import Security

enum KeychainError: Error {
    case duplicateEntry
    case itemNotFound
    case unhandledError(status: OSStatus)
}

final class KeychainHelper {
    static let shared = KeychainHelper()
    
    // 1. Save or Update
    func save(key: String, data: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            // Accessible only when device is unlocked, non-migrating to other devices
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            // Update existing
            let updateQuery = [kSecClass as String: kSecClassGenericPassword, kSecAttrAccount as String: key]
            let attributesToUpdate = [kSecValueData as String: data]
            let updateStatus = SecItemUpdate(updateQuery as CFDictionary, attributesToUpdate as CFDictionary)
            guard updateStatus == errSecSuccess else { throw KeychainError.unhandledError(status: updateStatus) }
        } else if status != errSecSuccess {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    // 2. Read
    func read(key: String) throws -> Data {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let data = dataTypeRef as? Data else {
            throw KeychainError.itemNotFound
        }
        return data
    }
    
    // 3. Delete
    func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
```
