# Network Security & Certificate Pinning

Mitigate Man-In-The-Middle (MITM) attacks by verifying server certificates or public key pins.

---

## 1. Certificate Pinning via `URLSessionDelegate`

```swift
import Foundation
import Security

final class PinnedSessionDelegate: NSObject, URLSessionDelegate {
    private let pinnedCertificateData: Data // Loaded from local app bundle (.cer file)
    
    init(pinnedCertificateData: Data) {
        self.pinnedCertificateData = pinnedCertificateData
    }
    
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Evaluate trust with policy
        var error: CFError?
        let isTrusted = SecTrustEvaluateWithError(serverTrust, &error)
        guard isTrusted else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Compare server certificate with pinned bundle certificate
        if let serverCertificates = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate],
           let serverCert = serverCertificates.first {
            let serverCertData = SecCertificateCopyData(serverCert) as Data
            if serverCertData == pinnedCertificateData {
                completionHandler(.useCredential, URLCredential(trust: serverTrust))
                return
            }
        }
        
        // Certificate did not match! Reject connection.
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}
```
