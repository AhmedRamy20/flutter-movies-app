<div align="center">

  <!-- App Logo/Banner -->
  <img width="100" height="100" alt="logo" src="https://github.com/user-attachments/assets/d184bb3d-ce4b-46a6-b494-3052b851734b" />
  
  # 🎬 **MOVIES APP** - Your Personal Movie Universe

  [![Flutter](https://img.shields.io/badge/Flutter-3.16+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.2+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
  [![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
  [![TMDB](https://img.shields.io/badge/TMDB-01B4E4?logo=themoviedatabase&logoColor=white)](https://www.themoviedb.org)
  [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
  [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
  
  <h3>A modern, feature-rich movie streaming application built with Flutter</h3>

  [🎯 Features](#-features) • 
  [📱 Screenshots](#-screenshots) • 
  [🏗️ Architecture](#%EF%B8%8F-architecture) • 
  [🚀 Getting Started](#-getting-started) • 
  [📦 Tech Stack](#-tech-stack) • 
  [🤝 Contributing](#-contributing)

</div>

---

## ✨ **Features**

### 🎯 Core Functionality
| Feature | Description |
|---------|-------------|
| 🎬 **Browse Movies** | Discover trending, popular, top-rated & upcoming movies |
| 🔍 **Smart Search** | Real-time search with debouncing |
| ❤️ **Favorites** | fav & unfav any movie you like ant it will sync across devices |
| 📽️ **Movie Trailers** | Watch YouTube trailers in-app |
| 👤 **User Auth** | Secure email/password authentication |
| 🌓 **Dark/Light Theme** | Eye-friendly themes for day/night |

### 🚀 Technical Highlights
- ⚡ **BLoC Pattern** - Clean & scalable state management
- 💾 **Offline Support** - Hydrated BLoC for local persistence for theme
- ☁️ **Cloud Sync** - Favorites sync across devices with Firestore
- 🎨 **Smooth UI** - Custom animations & shimmer effects

---

## 📸 **Screenshots**

<div align="center">
  <table>
    <tr>
      <td align="center">
        <strong>Home Screen</strong><br/>
        <img width="250" height="444" alt="home" src="https://github.com/user-attachments/assets/a37be430-2ab9-427a-b1e2-624648f66eb5" />
      </td>
      <td align="center">
        <strong>Movie Details</strong><br/>
        <img width="250" height="444" alt="details" src="https://github.com/user-attachments/assets/6b036d43-a9ff-4b78-953a-662ba40ccf3f" />
      </td>
      <td align="center">
        <strong>Favorites</strong><br/>
        <img width="250" height="444" alt="fav" src="https://github.com/user-attachments/assets/e5094634-ab19-4580-ae3c-2532e24e88f1" />
      </td>
    </tr>
    <tr>
      <td align="center">
        <strong>Search</strong><br/>
       <img width="250" height="444" alt="search" src="https://github.com/user-attachments/assets/1546e584-751a-414a-ae07-5e93aa0c6ebc" />
      </td>
      <td align="center">
        <strong>Login Screen</strong><br/>
        <img width="250" height="444" alt="login" src="https://github.com/user-attachments/assets/9828d09b-2703-4d2c-a046-5bc3d91f9947" />
      </td>
      <td align="center">
        <strong>Register Screen</strong><br/>
        <img width="250" height="444" alt="create account" src="https://github.com/user-attachments/assets/6a5ee768-1164-4ccc-99ad-f4109fcdbca2" />
      </td>
       <td align="center">
        <strong>Dark mode</strong><br/>
        <img width="250" height="444" alt="dark" src="https://github.com/user-attachments/assets/73c22402-eece-48de-aec5-b55d17c8183c" />
      </td>
      <td align="center">
        <strong>watch trailer</strong><br/>
       <img width="250" height="444" alt="trailer" src="https://github.com/user-attachments/assets/d76abefc-3b8a-4e3e-89bc-426630167040" />
      </td>
    </tr>

    
  </table>
</div>

---

## 📦 **Tech Stack**

### 🎨 Frontend
| Technology | Version | Purpose |
|------------|---------|---------|
| [Flutter](https://flutter.dev) | SDK 3.11+ | UI Framework |
| [Dart](https://dart.dev) | 3.11+ | Programming Language |
| [BLoC](https://bloclibrary.dev) | ^9.2.1 | State Management |
| [Hydrated BLoC](https://pub.dev/packages/hydrated_bloc) | ^11.0.0 | Theme & Preferences Persistence |
| [Shimmer](https://pub.dev/packages/shimmer) | ^3.0.0 | Loading Effects |


### ☁️ Backend & Cloud
| Technology | Version | Purpose |
|------------|---------|---------|
| [Firebase Core](https://firebase.google.com) | ^4.10.0 | Firebase Initialization |
| [Firebase Auth](https://firebase.google.com/products/auth) | ^6.5.2 | User Authentication |
| [Cloud Firestore](https://firebase.google.com/products/firestore) | ^6.5.0 | Favorites Database |
| [TMDB API](https://www.themoviedb.org/documentation/api) | v3 | Movie Data |

### 🔧 Utilities & Networking
| Technology | Version | Purpose |
|------------|---------|---------|
| [Dio](https://pub.dev/packages/dio) | ^5.9.2 | HTTP Client & API Calls |
| [Connectivity Plus](https://pub.dev/packages/connectivity_plus) | ^7.1.1 | Network Connection Monitoring (soon) |
| [WebView Flutter](https://pub.dev/packages/webview_flutter) | ^4.8.0 | YouTube Trailers |
| [Path Provider](https://pub.dev/packages/path_provider) | ^2.1.5 | File System Access |
| [Equatable](https://pub.dev/packages/equatable) | ^2.0.8 | Value Equality |

### 🛠️ Development Dependencies
| Technology | Version | Purpose |
|------------|---------|---------|
| [Flutter Test](https://flutter.dev/docs/testing) | SDK | Unit & Widget Testing |
| [Flutter Lints](https://pub.dev/packages/flutter_lints) | ^6.0.0 | Code Style & Linting |

### 📦 Complete pubspec.yaml Dependencies

```yaml
dependencies:
  # State Management
  bloc: ^9.2.1
  flutter_bloc: ^9.1.1
  hydrated_bloc: ^11.0.0
  
  # Firebase
  firebase_core: ^4.10.0
  firebase_auth: ^6.5.2
  cloud_firestore: ^6.5.0
  
  # Networking
  dio: ^5.9.2
  connectivity_plus: ^7.1.1
  
  # UI
  shimmer: ^3.0.0
  webview_flutter: ^4.8.0
  cupertino_icons: ^1.0.8
  
  # Utilities
  path_provider: ^2.1.5
  equatable: ^2.0.8
  

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

## 🏗️ **Architecture**

📦 Movies_App
┣ 📂 lib
┃ ┣ 📂 busieness_logic # State Management (BLoC/Cubits)
┃ ┃ ┣ 📂 bloc # Auth, Home, Search, Theme, Details
┃ ┃ ┗ 📂 cubit # Connection, Favorites
┃ ┣ 📂 data # Data Layer
┃ ┃ ┣ 📂 model # Movie models
┃ ┃ ┣ 📂 repository # Repository pattern
┃ ┃ ┣ 📂 web_service # TMDB API & Firebase Auth
┃ ┃ ┗ 📂 firestore_service # Cloud Firestore operations
┃ ┣ 📂 presentation # UI Layer
┃ ┃ ┣ 📂 home # views & widgets
┃ ┃ ┣ 📂 details # views & widgets
┃ ┃ ┣ 📂 auth # Login/Register views & widgets
┃ ┣ 📂 core # Core utilities
┃ ┃ ┣ 📂 config # Themes, colors
┃ ┃ ┣ 📂 constants # API endpoints, routes
┃ ┃ ┗ 📂 extensions # Custom extensions
┃ ┃ ┗ 📂 exceptions # Custom exceptions
┃ ┃ ┗ 📂 enum # Custom enums
┃ ┣ 📂 helpers # Helper classes
┃ ┣ 📂 utils # dialogs
┃ ┗ 📜 main.dart # App entry point
┣ 📂 assets # Images, icons
┗ 📜 pubspec.yaml # Dependencies

## 🚀 **Getting Started**

### Prerequisites

- Flutter SDK (>=SDK 3.11+)
- Dart SDK (>=3.11+)
- Android Studio / VS Code
- Android device/emulator or iOS (Mac with Xcode)
- [TMDB API Key](https://www.themoviedb.org/signup)

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/yourusername/movies_app.git
cd movies_app

### Install dependencies
  flutter pub get


### 3. Setup Firebase

| Step | Platform | Action | File Location |
|------|----------|--------|---------------|
| 1 | All | Create Firebase project | - |
| 2 | All | Enable Email/Password Auth | - |
| 3 | All | Enable Cloud Firestore | - |
| 4 | Android | Download google-services.json | `android/app/` |
| 4 | iOS | Download GoogleService-Info.plist | `ios/Runner/` |
| 4 | Web | Copy Firebase SDK config | `web/index.html` |

### 4. Add TMDB API Key
add in => lib/core/constants/apis.dart
const String tmdbApiKey = 'YOUR_TMDB_API_KEY_HERE';

### 5. Run the app
# Android
flutter run

# iOS

## 🤝 **Contributing**

Contributions are what make the open-source community amazing! Any contributions you make are **greatly appreciated**.

### How to Contribute

| Step | Action |
|------|--------|
| 1 | Fork the Project |
| 2 | Create your Feature Branch (`git checkout -b feature/AmazingFeature`) |
| 3 | Commit your Changes (`git commit -m 'Add some AmazingFeature'`) |
| 4 | Push to the Branch (`git push origin feature/AmazingFeature`) |
| 5 | Open a Pull Request |

### Code Style Guidelines
- Follow the [Flutter style guide](https://flutter.dev/docs/development/ui/layout)

### Reporting Issues

When reporting a bug, please include:
- Steps to reproduce
- Expected behavior
- Screenshots if applicable


---

## 📄 **License**

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)


