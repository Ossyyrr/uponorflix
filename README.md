# 🎬 uponorflix

Uponorflix is a prototype for managing and viewing movies and series, developed in Flutter following best practices for decoupled architecture.

---

## 🛠️ Installation and Run

1. Clone the repository:
   ```sh
   git clone https://github.com/Ossyyrr/uponorflix.git
   cd uponorflix
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Run the app:
   ```sh
   flutter run
   ```

---

## 🚀 Testing

To generate Mockito auto-generated files, run:

```sh
dart run build_runner build
```

---

## 📁 Project Structure

- `lib/` Main source code
- `data/` Data access logic
- `domain/` Entities and business logic
- `presentation/` Screens, widgets, and presentation logic
- `l10n/` Internationalization files
- `di/` Dependency injector

---

## ✨ Features

- **Main screens:** Home, Settings, Video, Form.
- **Movie management:** Create, edit, delete, add, and edit movies.
- **Validations:** In the movie form.
- **Search:** Quickly find movies.
- **Filters:** By categories and type (movie/series).
- **Carousel:** Featured movies.
- **YouTube:** Integration to watch trailers.
- **Feedback:** SnackBar when deleting a movie.
- **Sample data:** Initial movie load.
- **Internationalization:** Multilanguage support (es/en).
- **Theme:** Light and dark mode.
- **Orientation:** Supports landscape and portrait.
- **Custom icon:** For the app.
- **Google Fonts:** Custom fonts.
- **Accessibility:** Use of Semantics in SettingsScreen.
- **Persistence:** Theme and language with `Shared_preferences`.
- **Decoupled architecture:** BLoC and Clean Architecture.
- **Dependency injection:** With `get_it`.
- **Tests:** Examples of unit, BLoC, and widget tests.
- **Firebase Firestore:** Data storage integration.

---

## 📦 Technologies

- Flutter
- Firebase Firestore
- BLoC
- get_it
- Shared_preferences
- Google Fonts

---

## 📱 Supported Platforms

- iOS
- Android

---

## 📄 License

This project is for technical evaluation purposes only and must not be distributed or used in production.

---

## 📝 Notes

- This project follows a decoupled architecture to facilitate maintenance and scalability.

---

## 📬 Contact

For questions or suggestions: [ossyyrr@gmail.com](mailto:ossyyrr@gmail.com)

> **ℹ️ This project was developed by Patricia Manzanero Jiménez as a technical test for Uponor between 16/06/25 and 20/06/25.**
