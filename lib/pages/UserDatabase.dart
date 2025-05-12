class UserDatabase {
  static final UserDatabase _instance = UserDatabase._internal();
  factory UserDatabase() {
    return _instance;
  }

  UserDatabase._internal();

  final Map<String, String> _users = {
    'admin': '1234',
    // default user
  };

  bool login(String username, String password) {
    return _users.containsKey(username) && _users[username] == password;
  }

  bool userExists(String username) {
    return _users.containsKey(username);
  }

  bool register(String username, String password) {
    if (_users.containsKey(username)) {
      return false;
      // user already exists
    }
    _users[username] = password;
    return true;
  }
}