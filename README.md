# 📝 Smart Notes OAuth - Flutter Frontend

A modern Flutter application for note-taking with Google OAuth authentication, designed to work with a Rust GraphQL backend.

## ✨ Features

- 🔐 **Google OAuth Authentication** - Secure sign-in with Google accounts
- 📱 **Cross-platform** - Works on iOS, Android, Web, and Desktop
- 🎨 **Modern UI** - Beautiful Material Design interface
- 🔄 **Real-time Sync** - Notes synchronized with Rust backend via GraphQL
- 👤 **User Profiles** - Display user information and avatars
- 📝 **Note Management** - Create, read, update, and delete notes (coming soon)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- A running Rust GraphQL backend server
- Google OAuth credentials

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd smart_notes_oauth
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Google OAuth**
   - Set up Google OAuth credentials in your Google Cloud Console
   - Configure the credentials for your target platforms (iOS/Android/Web)

4. **Update backend URL**
   - Edit `lib/services/backend_service.dart`
   - Update the `baseUrl` to point to your Rust backend server

5. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Architecture

The app follows a clean architecture pattern with the following structure:

```
lib/
├── models/          # Data models
│   ├── auth_response.dart
│   └── user.dart
├── screens/         # UI screens
│   ├── home_screen.dart
│   └── login_screen.dart
└── services/        # Business logic
    ├── auth_service.dart
    └── backend_service.dart
```

## 🔧 Key Components

- **AuthService**: Manages Google OAuth authentication and user state
- **BackendService**: Handles communication with the Rust GraphQL backend
- **User Model**: Represents user data structure
- **AuthResponse Model**: Handles authentication response data

## 🌐 Backend Integration

This Flutter app is designed to work with a Rust GraphQL backend. The backend should provide:

- Google OAuth token validation
- User management
- Notes CRUD operations
- JWT token authentication

## 📱 Platform Support

- ✅ iOS
- ✅ Android  
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🛠️ Development

### Running Tests
```bash
flutter test
```

### Building for Production
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📚 Dependencies

- `flutter`: Framework
- `provider`: State management
- `google_sign_in`: Google OAuth authentication
- `shared_preferences`: Local storage
- `http`: HTTP requests

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google for OAuth integration
- Rust community for the backend inspiration
