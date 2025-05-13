# challenge1-UserInfo

This module handles the user info and chat history management for the Chat AI App. It includes functionalities for chat history display, chat database management, user authentication, 和 API key configuration. This module is essential for maintaining user interaction history and managing chat sessions.

## Project Structure

<pre>
lib/
├── main.dart
├── constant/
│   └── apiKey.dart
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
</pre>

### Module Components

1. Main Application (main.dart)
  - Entry point of the application, defining the app’s structure and main theme.

2. Constants (constant/)
  - apiKey.dart: Stores API keys and endpoint URLs.

3. Database (database/)
  - chat_history_db.dart: Handles SQLite database operations for storing and retrieving chat history.

4. GitHub Pages (pages/)
  - ChatHistoryPage.dart: Displays a list of past chat sessions and provides navigation options for new chats and profile views.
  - ChatPage.dart: Core chat interface, supports real-time message display and AI response.
  - LoginPage.dart: User login interface, handles user authentication.
  - SignupPage.dart: User registration interface, allows new users to create accounts.
  - UserDatabase.dart: In-memory user authentication for login and registration.
  - UserInfoPage.dart: Displays user profile information, including avatar, email, phone, and account settings.

5. Widgets (widgets/)
  - ChatHistoryWidget.dart: Custom widget for rendering chat history items in a scrollable list.

#### Key Features

  - Chat History Management (SQLite Database)
  - Real-time Message Display
  - API Integration for Chatbot Responses
  - User Authentication (Login & Signup)
  - User Profile Management (Basic)

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
  - Open lib/constant/apiKey.dart
  - Replace the API_key value with your actual OpenAI API key.
4. To run the app on a connected device or emulator:
<pre>
flutter run
</pre>
