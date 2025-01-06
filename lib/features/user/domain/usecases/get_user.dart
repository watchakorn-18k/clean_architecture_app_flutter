import 'package:clean_architecture_app/core/error/failures.dart';
import 'package:clean_architecture_app/core/usecases/usecase.dart';
import 'package:clean_architecture_app/features/user/domain/entities/user.dart';
import 'package:clean_architecture_app/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUser implements UseCase<User, String> {
  final UserRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(String params) async {
    return await repository.getUser(params);
  }
}
