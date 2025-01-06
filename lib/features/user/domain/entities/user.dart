import 'package:clean_architecture_app/core/database/app_database.dart'
    as app_db;

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });
}

User mapToUserEntity(app_db.User userData) {
  return User(
    id: userData.id,
    name: userData.name,
    email: userData.email,
  );
}
