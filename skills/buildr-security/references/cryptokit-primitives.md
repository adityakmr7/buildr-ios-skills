# Apple `CryptoKit` & Secure Enclave

Apple's `CryptoKit` provides modern, secure cryptographic algorithms.

---

## 1. Symmetric Encryption with AES-GCM

```swift
import CryptoKit
import Foundation

struct SecureEncryption {
    // Generate or retrieve key
    static let symmetricKey = SymmetricKey(size: .bits256)
    
    static func encrypt(plainText: String) throws -> Data {
        let data = Data(plainText.utf8)
        let sealedBox = try AES.GCM.seal(data, using: symmetricKey)
        return sealedBox.combined!
    }
    
    static func decrypt(cipherData: Data) throws -> String {
        let sealedBox = try AES.GCM.SealedBox(combined: cipherData)
        let decryptedData = try AES.GCM.open(sealedBox, using: symmetricKey)
        return String(decoding: decryptedData, as: UTF8.self)
    }
}
```

---

## 2. Hardware Keys with Secure Enclave

Private keys created in the Secure Enclave never touch system RAM and cannot be exported:

```swift
import CryptoKit

func generateEnclaveKey() throws {
    guard SecureEnclave.isAvailable else {
        print("Secure Enclave not available on this device")
        return
    }
    
    // Generates key protected by hardware
    let privateKey = try SecureEnclave.P256.Signing.PrivateKey()
    let dataToSign = Data("transaction_id_1024".utf8)
    
    // Hardware signs payload
    let signature = try privateKey.signature(for: dataToSign)
    print("Signed successfully with Secure Enclave!")
}
```
