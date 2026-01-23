# Firebase Setup Instructions

## Steps to Configure Firebase

### 1. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or select an existing project
3. Follow the setup wizard

### 2. Add Android App
1. Click "Add app" and select Android
2. Register your app with package name: `com.example.ecommerce`
3. Download `google-services.json`
4. Place it in `android/app/` directory

### 3. Add iOS App (Optional)
1. Click "Add app" and select iOS
2. Register your app with bundle ID: `com.example.ecommerce`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory

### 4. Enable Authentication Methods
1. In Firebase Console, go to Authentication
2. Click "Get Started"
3. Enable the following sign-in methods:
   - Email/Password
   - Google

### 5. Update Android Configuration
Add to `android/app/build.gradle.kts` (if not already present):

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Add this line
}
```

Add to `android/build.gradle.kts`:

```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.0")
    }
}
```

### 6. Configure Google Sign-In (Android)
1. In Firebase Console, go to Authentication > Sign-in method > Google
2. Enable Google sign-in
3. Download the SHA-1 fingerprint:
   ```
   cd android
   ./gradlew signingReport
   ```
4. Add SHA-1 to Firebase project settings

### 7. Run Flutter Pub Get
```bash
flutter pub get
```

### 8. Run the App
```bash
flutter run
```

## Important Notes

- Make sure `google-services.json` is in `android/app/`
- For iOS, ensure `GoogleService-Info.plist` is in `ios/Runner/`
- Enable required authentication methods in Firebase Console
- Test on a real device for Google Sign-In

## Guest Mode Features
- Browse products
- Add items to cart
- View product details
- **Cannot** place orders until signed up

## Signed-In User Features
- All guest features
- Place orders
- View order history
- Save addresses
- Track deliveries
