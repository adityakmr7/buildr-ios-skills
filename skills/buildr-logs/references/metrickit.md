# Production Telemetry with `MetricKit`

`MetricKit` aggregates power, performance, launch, and crash metrics collected across real users on iOS devices.

---

## 1. Subscribing to Metric Payloads

```swift
import MetricKit

final class TelemetryManager: NSObject, MXMetricManagerSubscriber {
    static let shared = TelemetryManager()
    
    func startMonitoring() {
        MXMetricManager.shared.add(self)
    }
    
    // Delivered once every 24 hours
    func didReceive(_ payloads: [MXMetricPayload]) {
        for payload in payloads {
            if let cpuMetrics = payload.cpuMetrics {
                print("CPU Time: \(cpuMetrics.cumulativeCPUTime)")
            }
            if let scrollMetrics = payload.animationMetrics {
                print("Scroll Hitch Ratio: \(scrollMetrics.scrollHitchTimeRatio)")
            }
        }
    }
    
    // Delivered shortly after a crash or diagnostic event
    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        for payload in payloads {
            if let crash = payload.crashDiagnostics {
                // Upload symbolicated crash payload to analytics
                print("Crash diagnostics: \(crash.count)")
            }
        }
    }
}
```
