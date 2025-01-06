// lib/features/user/domain/usecases/get_user_all.dart

import 'package:clean_architecture_app/core/usecases/no_params.dart';
import 'package:clean_architecture_app/features/user/domain/entities/user.dart';
import 'package:clean_architecture_app/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_architecture_app/core/error/failures.dart';
import 'package:clean_architecture_app/core/usecases/usecase.dart';

class GetUserAll implements UseCase<List<User>, NoParams> {
  // รับพารามิเตอร์แบบ NoParams
  final UserRepository repository;

  GetUserAll(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await repository.getAllUsers(); // ดึงข้อมูลผู้ใช้ทั้งหมด
  }
}
