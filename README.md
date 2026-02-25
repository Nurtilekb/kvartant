# _kvartant

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Google Authentication Setup

This project includes a simple example of Google Sign-In using the
`google_sign_in` package. To enable it in your app follow the steps below:

1. Add `google_sign_in: ^6.1.0` to `pubspec.yaml` and run
   `flutter pub get` (already done).
2. Configure a project in the [Google Cloud Console](https://console.cloud.google.com/):
   * Create an OAuth 2.0 Client ID for Android and one for iOS.
   * For Android, register your app's package name and SHA‑1 / SHA‑256
     fingerprints. Use `./gradlew signingReport` to obtain them.
   * Download the generated `google-services.json` and place it under
     `android/app/`.
   * For iOS, download `GoogleService-Info.plist` and add it to the
     Runner target in Xcode.
3. (Optional) If you need additional scopes, modify the `scopes` list in
   `lib/main.dart`.
4. Run the app (`flutter run`). You'll see a "Sign in with Google" button
   and a simple UI showing the user's name, email, and profile picture.

The authentication logic lives in `lib/main.dart`. It listens for
`onCurrentUserChanged` and calls `signIn()` / `disconnect()` as needed.

For more details, refer to the
[google_sign_in package documentation](https://pub.dev/packages/google_sign_in).

The startup screen now presents a combined registration/login page. Users
can choose to register with email/password or switch to a login form. Social
sign-in buttons for Google and Facebook appear at the top.

Facebook authentication is supported via the `flutter_facebook_auth`
package; add required configuration keys and follow the package docs for
platform setup.

# kvartant
