# StoreKit Local Testing in Xcode

Test in-app purchases and subscriptions without connecting to App Store Connect or having live internet access.

---

## 1. Setting Up a `.storekit` File

1. In Xcode: **File** → **New** → **File...** → Select **StoreKit Configuration File**.
2. Save as `Products.storekit`.
3. Add products:
   - Non-consumable (e.g., Lifetime Unlock).
   - Auto-renewable subscription (e.g., Monthly Pro, Yearly Pro) with a Subscription Group.

---

## 2. Attaching to the Xcode Scheme

1. Select scheme selector → **Edit Scheme...** (⌘<).
2. Select **Run** → **Options**.
3. Set **StoreKit Configuration** to `Products.storekit`.

---

## 3. Simulating Edge Cases in Xcode

In Xcode's debug console or the **Transaction Manager** (**Debug** → **StoreKit** → **Manage Transactions**):
- **Simulate Accelerated Time**: Set subscription renewals to renew every 30 seconds instead of 1 month.
- **Simulate "Ask to Buy"**: Triggers `.pending` state.
- **Simulate Refunds & Revocations**: Verifies that your app revokes user entitlements when a refund occurs.
