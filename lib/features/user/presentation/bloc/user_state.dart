import 'package:clean_architecture_app/features/user/domain/entities/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UsersLoaded extends UserState {
  // State สำหรับข้อมูลผู้ใช้ทั้งหมด
  final List<User> users;
  UsersLoaded(this.users);
}
