# challenge1-main

This module serves as the core entry point for the Chat AI App, providing the foundational components for user authentication, chat history management, 和 real-time messaging.

## Project Structure
<pre>
lib/
├── constant/
│   ├── apiKey.dart
│   └── global.dart
├── database/
│   └── chat_history_db.dart
├── pages/
│   ├── ChatHistoryPage.dart
│   ├── ChatPage.dart
│   ├── LoginPage.dart
│   ├── SignupPage.dart
│   ├── UserDatabase.dart
│   └── UserInfoPage.dart
├── widgets/
│   └── ChatHistoryWidget.dart
└── main.dart
</pre>
### Module Components

1. Main Application (main.dart)
   - Entry point of the application, defining the app’s structure and main theme.

2. Constants (constant/)
   - apiKey.dart: Stores API keys and endpoint URLs.
   - global.dart: Defines global configurations like route observers.

3. Database (database/)
   - chat_history_db.dart: Handles SQLite database operations for storing and retrieving chat history.

4. GitHub Pages (pages/)
   - ChatHistoryPage.dart: Displays a list of past chat sessions.
   - ChatPage.dart: Core chat interface with message handling.
   - LoginPage.dart: User login interface.
   - SignupPage.dart: User registration interface.
   - UserDatabase.dart: Handles in-memory user authentication and registration.
   - UserInfoPage.dart: Displays user profile information.

5. Widgets (widgets/)
ChatHistoryWidget.dart: Custom widget for rendering chat history items.

#### Key Features

User Authentication (Login & Signup)
Chat History Storage (SQLite Database)
User Profile Display
Real-time Message Display
API Integration for Chatbot Responses

##### Installation & Configuration

1. Clone the repository:
<pre>
   git clone <repository_url>
      cd ChatAIApp
</pre>

2. Install dependencies:
<pre>
   flutter pub get
</pre>

3. Add your OpenAI API key:
<pre>
   Open lib/constant/apiKey.dart
   Replace the API_key value with your actual OpenAI API key.
</pre>

4. Ensure the following plugins are included in your pubspec.yaml:
<pre>
   dependencies:
      flutter:
         sdk: flutter
      sqflite: ^2.0.0+3
      path_provider: ^2.0.2
      cupertino_icons: ^1.0.2
</pre>

5. To run the app on a connected device or emulator:
<pre>
flutter run
</pre>
