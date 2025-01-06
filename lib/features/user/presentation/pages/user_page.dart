import 'package:clean_architecture_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture_app/features/user/presentation/bloc/user_event.dart';
import 'package:clean_architecture_app/features/user/presentation/bloc/user_state.dart';
import 'package:clean_architecture_app/features/user/presentation/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatelessWidget {
  final String userId;

  const UserPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            context.read<UserBloc>().add(GetUserEvent(userId));
            return Container();
          } else if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return UserWidget(user: state.user);
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
