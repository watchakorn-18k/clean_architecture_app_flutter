import 'package:clean_architecture_app/features/user/data/datasources/local/user_db.dart';
import 'package:clean_architecture_app/features/user/data/datasources/local/user_local.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart'; // import User table

part 'app_database.g.dart'; // Drift generate file

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  UserLocalDataSource get userLocalDataSource => UserLocalDataSource(this);
}
