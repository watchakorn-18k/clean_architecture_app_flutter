import 'package:clean_architecture_app/features/user/data/datasources/local/user_local.dart';
import 'package:clean_architecture_app/features/user/data/datasources/remote/user_remote_datasource.dart';
import 'package:clean_architecture_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:clean_architecture_app/features/user/domain/repositories/user_repository.dart';
import 'package:clean_architecture_app/features/user/domain/usecases/get_user.dart';
import 'package:clean_architecture_app/features/user/domain/usecases/get_user_all.dart';
import 'package:clean_architecture_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture_app/injection_container.dart';

class UserModule {
  static void register() {
    // Datasources
    sl.registerLazySingleton<UserLocalDataSource>(
        () => UserLocalDataSource(sl()));

    // Bloc
    sl.registerFactory(() => UserBloc(getUser: sl(), getUserAll: sl()));

    // Use cases
    sl.registerLazySingleton(() => GetUser(sl()));
    sl.registerLazySingleton(() => GetUserAll(sl()));

    // Repository
    sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

    // Data sources
    sl.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(client: sl()));
  }
}
