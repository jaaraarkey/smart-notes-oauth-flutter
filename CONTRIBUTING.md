# Contributing to Smart Notes OAuth Flutter

Thank you for considering contributing to Smart Notes OAuth Flutter! 🎉

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing](#testing)

## 📜 Code of Conduct

This project adheres to a code of conduct. By participating, you are expected to uphold this code.

## 🤝 How to Contribute

### Reporting Bugs

1. **Check existing issues** first to avoid duplicates
2. **Use the bug report template** when creating new issues
3. **Provide clear reproduction steps**
4. **Include relevant logs and screenshots**

### Suggesting Features

1. **Check existing feature requests** first
2. **Use the feature request template**
3. **Explain the use case and benefits**
4. **Consider implementation complexity**

### Contributing Code

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Make your changes**
4. **Write tests** for new functionality
5. **Ensure all tests pass**
6. **Follow coding standards**
7. **Submit a pull request**

## 🛠️ Development Setup

### Prerequisites

- Flutter SDK 3.0+
- Dart SDK 3.0+
- Git
- VS Code or Android Studio (recommended)

### Setup Steps

1. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/smart-notes-oauth-flutter.git
   cd smart-notes-oauth-flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

4. **Run tests**
   ```bash
   flutter test
   ```

## 📝 Pull Request Process

1. **Update documentation** if needed
2. **Add tests** for new features
3. **Ensure CI passes** (all checks green)
4. **Request review** from maintainers
5. **Address feedback** promptly
6. **Squash commits** before merging

### PR Checklist

- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No breaking changes (or properly documented)
- [ ] CI/CD pipeline passes

## 🎨 Coding Standards

### Dart/Flutter Guidelines

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format` for consistent formatting
- Run `flutter analyze` to catch issues
- Prefer composition over inheritance
- Use meaningful variable and function names

### Code Organization

```
lib/
├── models/          # Data models
├── screens/         # UI screens/pages  
├── services/        # Business logic
├── widgets/         # Reusable UI components
└── utils/           # Helper functions
```

### Naming Conventions

- **Classes**: `PascalCase` (e.g., `UserProfile`)
- **Files**: `snake_case` (e.g., `user_profile.dart`)
- **Variables/Functions**: `camelCase` (e.g., `getUserData`)
- **Constants**: `SCREAMING_SNAKE_CASE` (e.g., `API_BASE_URL`)

## 🧪 Testing

### Test Types

- **Unit Tests**: Test individual functions/classes
- **Widget Tests**: Test UI components
- **Integration Tests**: Test complete user flows

### Writing Tests

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserService', () {
    test('should return user data when valid token provided', () {
      // Arrange
      // Act  
      // Assert
    });
  });
}
```

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/services/auth_service_test.dart
```

## 🏷️ Issue Labels

- `bug`: Something isn't working
- `enhancement`: New feature or request
- `documentation`: Improvements to docs
- `good first issue`: Good for newcomers
- `help wanted`: Extra attention needed

## 📞 Getting Help

- 💬 **Discussions**: Use GitHub Discussions for questions
- 🐛 **Issues**: Report bugs via GitHub Issues
- 📧 **Email**: Contact maintainers directly for sensitive matters

## 🙏 Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes for significant contributions
- GitHub contributors graph

Thank you for contributing! 🚀
