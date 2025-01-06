import 'package:clean_architecture_app/core/database/app_database.dart'
    as app_db;
import 'package:clean_architecture_app/features/user/data/datasources/local/user_local.dart';
import 'package:clean_architecture_app/features/user/domain/entities/user.dart'
    as user_entity;
import 'package:dartz/dartz.dart';
import 'package:clean_architecture_app/core/error/failures.dart';
import 'package:clean_architecture_app/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;

  // Constructor รับ UserLocalDataSource แทน AppDatabase
  UserRepositoryImpl(this.userLocalDataSource);

  @override
  Future<Either<Failure, user_entity.User>> getUser(String id) async {
    try {
      final user = await userLocalDataSource.getUserById(id);
      if (user != null) {
        final userEntity = mapToUserEntity(user);
        return Right(userEntity);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<user_entity.User>>> getAllUsers() async {
    try {
      final users = await userLocalDataSource.getAllUsers();
      final usersEntity = users.map((user) => mapToUserEntity(user)).toList();
      return Right(usersEntity);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<String, int>> addUser(user_entity.User user) async {
    try {
      final userDb = mapToUserDb(user);
      final userId = await userLocalDataSource.insertUser(userDb);
      return Right(userId);
    } catch (e) {
      return const Left('Failed to add user');
    }
  }

  user_entity.User mapToUserEntity(app_db.User userDb) {
    return user_entity.User(
      id: userDb.id,
      name: userDb.name,
      email: userDb.email,
    );
  }

  app_db.User mapToUserDb(user_entity.User userEntity) {
    return app_db.User(
      id: int.parse(userEntity.id as String),
      name: userEntity.name,
      email: userEntity.email,
    );
  }
}
