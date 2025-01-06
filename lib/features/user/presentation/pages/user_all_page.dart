import 'package:clean_architecture_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture_app/features/user/presentation/bloc/user_event.dart';
import 'package:clean_architecture_app/features/user/presentation/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAllPage extends StatelessWidget {
  const UserAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Users')),
      body: _buildUserList(),
    );
  }

  _buildUserList() {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitial) {
        context.read<UserBloc>().add(GetUserAllEvent());
        return const Center(child: CircularProgressIndicator());
      }
      if (state is UserLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is UserError) {
        return Center(child: Text(state.message));
      }
      if (state is UsersLoaded) {
        return ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            final user = state.users[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),
            );
          },
        );
      }
      return Container();
    });
  }
}
