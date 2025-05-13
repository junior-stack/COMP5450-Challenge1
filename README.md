# Feature/Display-Store-Messages

This module is part of the Chat AI App, responsible for displaying and storing user messages in a chat history. It provides essential components like login, user registration, chat history management, and user profile display. The module is designed for seamless integration with the larger Chat AI project.

## Project Structure

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

### Module Components

1. Main Application (main.dart)
Entry point of the application, defining the app’s structure and main theme.

2. Constants (constant/)
apiKey.dart: Stores API keys and endpoint URLs.
global.dart: Defines global configurations like route observers.

3. Database (database/)
chat_history_db.dart: Handles SQLite database operations for storing and retrieving chat history.

4. Pages (pages/)
ChatHistoryPage.dart: Displays a list of past chat sessions.
ChatPage.dart: Core chat interface with message handling.
LoginPage.dart: User login interface.
SignupPage.dart: User registration interface.
UserDatabase.dart: Handles in-memory user authentication and registration.
UserInfoPage.dart: Displays user profile information.

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
   git clone <repository_url>
   cd ChatAIApp
2. Install dependencies:
   flutter pub get
3. Add your OpenAI API key:
   Open lib/constant/apiKey.dart
   Replace the API_key value with your actual OpenAI API key.
4. Ensure the following plugins are included in your pubspec.yaml:
   dependencies:
      flutter:
         sdk: flutter
      sqflite: ^2.0.0+3
      path_provider: ^2.0.2
      cupertino_icons: ^1.0.2
