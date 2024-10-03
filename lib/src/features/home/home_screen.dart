import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_amplify_app/src/routing/app_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amplify Text'),
        actions: [
          IconButton(
              onPressed: () => context.goNamed(AppRoute.profile.name),
              icon: const Icon(Icons.person))
        ],
      ),
      body: const Center(
        child: Text('Welcome to Amplify Authentication'),
      ),
    );
  }
}
