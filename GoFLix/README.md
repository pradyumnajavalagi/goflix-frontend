# 🎬GoFlix - Flutter Frontend

GoFlix is a Flutter-based mobile application that provides users with a seamless movie browsing experience. This repository contains the frontend implementation of the GoFlix application.

## Features
- Fetch and display a list of movies from the backend API
- Add, update, and delete movies
- Responsive UI with modern Flutter components
- State management using `FutureBuilder`
- API integration with the backend

## Tech Stack
- Flutter (Dart)
- HTTP package for API requests
- Material Design for UI components

## Getting Started
### Prerequisites
- Install Flutter SDK ([Flutter installation guide](https://flutter.dev/docs/get-started/install))
- Ensure you have an emulator or a physical device connected
- Clone the repository

```sh
git clone https://github.com/pradyumnajavalagi/goflix-frontend.git
cd goflix/GoFlix
```

### Installation
1. Install dependencies:
   ```sh
   flutter pub get
   ```
2. Run the app:
   ```sh
   flutter run
   ```

## Project Structure
```
frontend/
│── lib/
│   ├── main.dart            # Entry point of the app
│   ├── movies.dart          # Movie service API calls
│── pubspec.yaml             # Project dependencies
```

## API Integration
The frontend communicates with the backend API running on `http://10.0.2.2:8000/movies`.
Ensure that the backend is running before launching the app.

## Contributing
1. Fork the repository
2. Create a new branch (`feature/your-feature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Create a pull request

## License
This project is licensed under the MIT License. See `LICENSE` for details.

---
Made by [Pradyumna A J](https://github.com/pradyumnajavalagi)