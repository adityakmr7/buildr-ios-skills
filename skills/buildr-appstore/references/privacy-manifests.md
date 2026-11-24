# Privacy Manifests: `PrivacyInfo.xcprivacy`

Apple strictly mandates privacy manifests for all apps and third-party SDKs submitted to the App Store.

---

## 1. Creating the File

Create a property list file named `PrivacyInfo.xcprivacy` and add it to your main app target bundle.

---

## 2. Declaring Required Reason APIs

If your app or any dependency touches certain system APIs, you must declare an approved reason code:

### 1. `NSPrivacyAccessedAPICategoryUserDefaults`
- **Reason Code `CA92.1`**: Access info from same app (e.g. read/write preferences for this app).

### 2. `NSPrivacyAccessedAPICategoryFileTimestamp`
- **Reason Code `C617.1`**: Access timestamps of files inside the app container.

### 3. `NSPrivacyAccessedAPICategoryDiskSpace`
- **Reason Code `E174.1`**: Check disk space to ensure there is room before downloading a file.

### 4. `NSPrivacyAccessedAPICategorySystemBootTime`
- **Reason Code `35F9.1`**: Measure time elapsed between events occurring inside the app.

---

## 3. Sample `PrivacyInfo.xcprivacy` (XML)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>NSPrivacyTracking</key>
    <false/>
    <key>NSPrivacyTrackingDomains</key>
    <array/>
    <key>NSPrivacyAccessedAPITypes</key>
    <array>
        <dict>
            <key>NSPrivacyAccessedAPIType</key>
            <string>NSPrivacyAccessedAPICategoryUserDefaults</string>
            <key>NSPrivacyAccessedAPITypeReasons</key>
            <array>
                <string>CA92.1</string>
            </array>
        </dict>
    </array>
    <key>NSPrivacyCollectedDataTypes</key>
    <array/>
</dict>
</plist>
```
