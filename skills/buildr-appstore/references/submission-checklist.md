# App Store Pre-Flight Submission Checklist

Common rejection traps and mandatory requirements.

---

## Top 10 Rejection Traps & Fixes

1. **Account Deletion (Guideline 5.1.1(v))**:
   - If users can sign up, they **must** be able to delete their account and associated personal data directly within the app.
2. **App Store Review Demo Credentials (Guideline 2.1)**:
   - If your app requires login, provide active, pre-populated test credentials in App Store Connect's **App Review Information** notes.
3. **Subscriptions & EULA (Guideline 3.1.2)**:
   - Subscription screens must clearly state title, price, billing period, and provide clickable links to **Terms of Use (EULA)** and **Privacy Policy**.
4. **Sign in with Apple (Guideline 4.8)**:
   - If you offer Google, Facebook, or other third-party social logins, you **must** also offer Sign in with Apple.
5. **Incomplete / Placeholder Content (Guideline 2.3)**:
   - Remove all "Lorem Ipsum", placeholder images, and non-functional buttons.
6. **Background Audio / Location (Guideline 2.5.4)**:
   - If `UIBackgroundModes` is enabled (audio, location, voip), the app must genuinely provide that feature continuously or it will be rejected.
7. **Permission Descriptions**:
   - Ensure `NSCameraUsageDescription`, `NSLocationWhenInUseUsageDescription`, etc., clearly explain *why* the app needs access to the feature.
8. **Export Compliance Flag in `Info.plist`**:
   ```xml
   <key>ITSAppUsesNonExemptEncryption</key>
   <false/>
   ```
   *(Saves having to answer encryption compliance questions on every build).*
