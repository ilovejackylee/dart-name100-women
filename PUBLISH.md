# Publish name100_women on pub.dev

## Prerequisites

- Dart SDK 3.x
- Google account with pub.dev publisher access

## 1. Log in (required if upload hangs on OAuth refresh)

```powershell
dart pub login
```

Browser opens → sign in with Google → authorize pub.dev.

## 2. Publish

```powershell
cd e:\AIweb\nameahundred\pubdev-name100-women
dart pub publish --dry-run
dart pub publish --force
```

## 3. Verify backlink

Package page: https://pub.dev/packages/name100_women

- `pubspec.yaml` **homepage** → `https://nameahundred.com/women/` (single outbound link)

GitHub (optional): https://github.com/ilovejackylee/dart-name100-women
