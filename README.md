# 🎯 Skill Gap Analyzer

A premium, AI-powered Flutter application designed to analyze candidate resumes against targeted job roles, identify technical skill gaps, and recommend curated learning resources to bridge those gaps.

Powered by the **Gemini API** for intelligent parsing and analysis, and **Firebase** for user authentication and candidate profile management.

---

## ✨ Features

- **🔐 Secure Authentication**: Email-based signup and sign-in powered by Firebase Authentication.
- **📄 Resume Parser**: Local text extraction from PDF and TXT resumes using `syncfusion_flutter_pdf` and `file_picker`.
- **🧠 AI-Powered Skill Matching**: Leverages Gemini AI to compare resume credentials against 15+ specialized technical roles (such as Web Developer, DevOps, ML Engineer, UI/UX Designer, iOS/Android Developer, and more).
- **📊 Interactive Visualization**: Dynamic reports showing:
  - Match percentage metrics with interactive charts (`fl_chart` and `percent_indicator`).
  - Extracted skills vs. required skills.
  - Bulletproof lists of matched and missing skills.
- **📚 Skill Bridging Resources**: Curated links to official documentation, tutorials, and courses for all missing competencies.
- **🎨 Premium UX/UI Design**: Modern, responsive user interface featuring custom typography (Syne & DM Sans), smooth micro-animations, and a cohesive purple design theme.

---

## 🛠️ Tech Stack & Dependencies

- **Framework**: [Flutter](https://flutter.dev/) (Dart SDK `^3.0.0`)
- **AI Service**: [Gemini API](https://ai.google.dev/) (via Google Generative Language endpoints)
- **Backend Services**: 
  - [Firebase Auth](https://firebase.google.com/docs/auth) (Candidate accounts)
  - [Cloud Firestore](https://firebase.google.com/docs/firestore) (Resume storage & profile states)
- **State & Data Utilities**:
  - `flutter_dotenv` (Secure local environment configurations)
  - `file_picker` (Resume uploading)
  - `syncfusion_flutter_pdf` (On-device PDF extraction)
  - `fl_chart` (Interactive charts & diagrams)
  - `percent_indicator` (Progress visualizers)
  - `google_fonts` (Premium typography rendering)

---

## 📂 Project Structure

```text
lib/
├── data/
│   └── roles_data.dart          # 15+ predefined tech roles with requirements and links
├── models/
│   ├── role_model.dart          # Role model definition
│   └── user_model.dart          # Candidate/User model mapping Firestore documents
├── screens/
│   ├── welcome_screen.dart      # Welcome landing screen
│   ├── signin_screen.dart       # Candidate sign in
│   ├── signup_screen.dart       # Candidate sign up
│   ├── home_screen.dart         # Main Dashboard (Manage Resume / Learning Resources)
│   ├── resume_screen.dart       # Resume picker, parser, and uploader
│   ├── roles_screen.dart        # Target role selection carousel list
│   ├── analyzer_screen.dart     # AI processing & loading feedback animation
│   ├── results_screen.dart      # Visual breakdown of skill matches, missing skills & charts
│   └── resources_screen.dart    # Roadmap recommendations & external learning links
├── services/
│   ├── ai_service.dart          # Gemini API communication layer
│   └── auth_service.dart        # Firebase Auth wrapper (sign in, sign up, logout)
├── theme.dart                   # Centralized design system (colors, borders, gradients)
└── main.dart                    # Application entry point
```

---

## 🚀 Getting Started & Setup

### 1. Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your system.
- A Firebase Project (with Email/Password auth and Firestore enabled).
- A Gemini API Key from [Google AI Studio](https://aistudio.google.com/).

### 2. Configure Environment Variables
1. Copy the example environment template in the `assets/` folder:
   ```bash
   cp assets/config.env.example assets/config.env
   ```
2. Open `assets/config.env` and insert your Gemini API key:
   ```env
   GEMINI_API_KEY=your_actual_gemini_api_key_here
   ```

> [!WARNING]
> Keep `assets/config.env` local. Do not check it into version control. It is already added to `.gitignore`.

### 3. Setup Firebase
1. Initialize Firebase for your app platforms (Android, iOS, Web, Windows) by running:
   ```bash
   flutterfire configure
   ```
   This will update `lib/firebase_options.dart` and register platforms within your Firebase Console.
2. In the Firebase Console:
   - Enable **Email/Password** provider under Authentication.
   - Create a **Cloud Firestore** database in test or production mode.

### 4. Install Dependencies
Run the pub command to fetch all Dart packages:
```bash
flutter pub get
```

### 5. Launch the Application
Run the project on your preferred device:
```bash
flutter run
```

---

## 🔒 Security Best Practices
- **API Keys**: The Gemini API key is loaded locally using `flutter_dotenv` from `assets/config.env` (which is excluded from Git tracking via `.gitignore`).
- **Firebase Configuration**: The Firebase clients use standard API keys generated in `lib/firebase_options.dart` which are safe to commit under public configurations.
