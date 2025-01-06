// feature/user/data/datasources/user_local_data_source.dart

import 'package:clean_architecture_app/core/database/app_database.dart';

class UserLocalDataSource {
  final AppDatabase appDatabase;

  UserLocalDataSource(this.appDatabase);

  // Query for a user by ID
  Future<User?> getUserById(String id) async {
    final query = appDatabase.select(appDatabase.users)
      ..where((user) => user.id.equals(int.parse(id)));
    return query.getSingleOrNull(); // Returns user or null
  }

  // Insert a user
  Future<int> insertUser(User user) =>
      appDatabase.into(appDatabase.users).insert(user);

  // Get all users
  Future<List<User>> getAllUsers() async {
    final query = await appDatabase.select(appDatabase.users).get();
    return query;
  }
}
