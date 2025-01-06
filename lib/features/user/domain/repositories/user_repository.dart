import 'package:clean_architecture_app/core/error/failures.dart';
import 'package:clean_architecture_app/features/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String id);
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<String, int>> addUser(User user);
}
