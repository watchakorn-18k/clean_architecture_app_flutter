import 'package:clean_architecture_app/features/home/presentation/pages/home_page.dart';
import 'package:clean_architecture_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture_app/features/user/presentation/pages/user_all_page.dart';
import 'package:clean_architecture_app/features/user/presentation/pages/user_page.dart';
import 'package:clean_architecture_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name!);

    // Home
    if (uri.path == '/') {
      return MaterialPageRoute(
        builder: (_) => const HomePage(),
      );
    }

    // user/{id}
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'user') {
      final userId = uri.pathSegments[1]; // ดึงค่าของ {id}
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => sl<UserBloc>(), // ส่ง event พร้อม userId
          child: UserPage(userId: userId), // ส่ง userId ให้ UserPage
        ),
      );
    }

    // user/all
    if (uri.path == '/users') {
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => sl<UserBloc>(),
                child: const UserAllPage(),
              ));
    }

    // เส้นทางไม่พบ
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Route not found')),
      ),
    );
  }
}
