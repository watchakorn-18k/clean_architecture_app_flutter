import 'package:clean_architecture_app/core/database/app_database.dart';

import 'package:clean_architecture_app/features/user/user_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Register AppDatabase
  sl.registerLazySingleton(() => AppDatabase());

  // Register UserModule
  UserModule.register();

  // External
  sl.registerLazySingleton(() => http.Client());
}
