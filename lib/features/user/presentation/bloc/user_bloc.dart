// lib/features/user/presentation/bloc/user_bloc.dart
import 'package:clean_architecture_app/core/usecases/no_params.dart';
import 'package:clean_architecture_app/features/user/domain/usecases/get_user.dart';
import 'package:clean_architecture_app/features/user/domain/usecases/get_user_all.dart';
import 'package:clean_architecture_app/features/user/presentation/bloc/user_event.dart';
import 'package:clean_architecture_app/features/user/presentation/bloc/user_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;
  final GetUserAll getUserAll;

  UserBloc({required this.getUser, required this.getUserAll})
      : super(UserInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = await getUser(event.id);

      if (kDebugMode) {
        print('Result: $result');
      }

      result.fold(
        (failure) {
          // เพิ่มการแสดงผลของ failure เพื่อดูรายละเอียด
          if (kDebugMode) {
            print('Failure: $failure');
          }
          emit(UserError('Failed to load user'));
        },
        (user) {
          if (kDebugMode) {
            print('User: $user');
          }
          emit(UserLoaded(user));
        },
      );
    });

    // เพิ่ม event สำหรับการดึงข้อมูลผู้ใช้ทั้งหมด
    on<GetUserAllEvent>((event, emit) async {
      emit(UserLoading());
      final result =
          await getUserAll(NoParams()); // เรียกใช้ GetUserAll Use Case
      result.fold(
        (failure) => emit(UserError('Failed to load all users')),
        (users) => emit(UsersLoaded(users)),
      );
    });
  }
}
