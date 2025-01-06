import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                child: const Text('View All Users'),
                onPressed: () {
                  Navigator.pushNamed(context, '/users');
                }),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('View User Details'),
              onPressed: () {
                Navigator.pushNamed(
                    context, '/user/1'); // Using route with user ID
              },
            )
          ],
        ),
      ),
    );
  }
}
