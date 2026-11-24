# Background Transfers with `URLSession`

For downloading or uploading files while the app is suspended or terminated.

---

## 1. Configuration

Background sessions run out-of-process in a daemon managed by iOS:

```swift
class DownloadManager: NSObject, URLSessionDownloadDelegate {
    static let shared = DownloadManager()
    
    lazy var backgroundSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "com.mycompany.myapp.downloads")
        config.isDiscretionary = true // Wait for Wi-Fi and power
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func startDownload(url: URL) {
        let task = backgroundSession.downloadTask(with: url)
        task.resume()
    }
    
    // Delegate methods for completion and progress...
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // Move file from temporary location immediately
    }
}
```

---

## 2. Handling App Wakeup

When the transfer finishes while app is terminated, iOS wakes the app:

```swift
func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
    DownloadManager.shared.backgroundCompletionHandler = completionHandler
}
```
