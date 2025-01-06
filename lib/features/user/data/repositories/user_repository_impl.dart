import 'package:clean_architecture_app/features/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_architecture_app/core/error/failures.dart';
import 'package:clean_architecture_app/features/user/domain/entities/user.dart'
    as user_entity;
import 'package:clean_architecture_app/core/database/app_database.dart'
    as app_db;
import 'package:clean_architecture_app/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final app_db.AppDatabase database;

  UserRepositoryImpl(this.database);

  @override
  Future<Either<Failure, user_entity.User>> getUser(String id) async {
    try {
      final user = await database.getUserById(id);
      if (user != null) {
        final userEntity = mapToUserEntity(user); // แปลงโดยใช้ฟังก์ชันกลาง
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
      final users = await database.getAllUsers();
      final usersEntity = users.map((user) => mapToUserEntity(user)).toList();
      return Right(usersEntity);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<String, int>> addUser(user_entity.User user) async {
    try {
      final userId = await database.insertUser(user as app_db.User);
      return Right(userId);
    } catch (e) {
      return const Left('Failed to add user');
    }
  }
}
