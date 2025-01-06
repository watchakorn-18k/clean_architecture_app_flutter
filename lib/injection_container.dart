import 'package:clean_architecture_app/core/database/app_database.dart';
import 'package:clean_architecture_app/features/user/data/datasources/remote/user_remote_datasource.dart';
import 'package:clean_architecture_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:clean_architecture_app/features/user/domain/repositories/user_repository.dart';
import 'package:clean_architecture_app/features/user/domain/usecases/get_user.dart';
import 'package:clean_architecture_app/features/user/domain/usecases/get_user_all.dart';
import 'package:clean_architecture_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  final db = AppDatabase();

  // Bloc

  sl.registerFactory(() => UserBloc(getUser: sl(), getUserAll: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => GetUserAll(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(db));

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}
