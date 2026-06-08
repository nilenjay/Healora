# Healora - Premium Healthcare Booking App

Healora is a modern, responsive, and high-fidelity healthcare appointment booking application built with Flutter. Designed with a premium SaaS aesthetic, it empowers patients to discover doctors, explore specializations, and seamlessly book appointments.

## 🚀 Features

- **Doctor Discovery**: Browse doctors dynamically by specialization.
- **Real-Time Search**: Search for doctors by name or specialty using the `SearchScreen`.
- **Appointment Booking**: Secure your consultation slots with comprehensive form validation.
- **Appointment Management**: View and cancel upcoming appointments securely stored on your device.
- **Dynamic Filtering**: Quickly filter doctors using intuitive specialization chips on the Home Screen.
- **Beautiful UI/UX**: Premium aesthetic featuring smooth animations, a dedicated splash screen, and skeleton/empty states.

## 🏗️ Architecture

This project strictly adheres to **Feature-Based Clean Architecture** to ensure high scalability, separation of concerns, and maintainability.

### Layers:
1. **Presentation (UI)**: Pure Flutter widgets using declarative syntax. No business logic resides here.
2. **State Management (Bloc)**: Event-driven BLoC architecture (`flutter_bloc`) handles all state transitions, keeping the UI entirely decoupled from the data.
3. **Domain (Repository Interface)**: Abstract classes define the contract for data fetching (e.g., `DoctorRepository`, `AppointmentRepository`).
4. **Data (Implementation)**: Concrete implementations of the repositories.
   - `LocalDoctorRepository`: Mocks a backend by serving rich, nested JSON data.
   - `LocalAppointmentRepository`: Persists data across app restarts using `SharedPreferences`.

### Folder Structure
```
lib/
├── core/
│   ├── constants/
│   ├── routes/
│   ├── theme/
│   └── widgets/
│
├── features/
│   ├── appointments/
│   ├── auth/
│   ├── doctors/
│   ├── home/
│   ├── profile/
│   └── search/
│
└── main.dart
```

## 🛠️ Setup Instructions

1. Ensure you have the Flutter SDK installed (Stable channel).
2. Clone this repository.
3. Navigate to the project root and run `flutter pub get` to install all dependencies (including `flutter_bloc`, `equatable`, `go_router`, `shared_preferences`, and `uuid`).
4. Run the app using `flutter run`.

## 📈 Future Improvements (Optional Enhancements)

- Implement a real backend (e.g., Firebase, Supabase) replacing the Local JSON repositories.
- Complete the authentication flow using the provided UI screens.
- Add Video Consultation UI and push notifications for appointment reminders.
- Implement Dark Mode support using `AppTheme`.