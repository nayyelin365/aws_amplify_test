import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_amplify_app/src/common_widgets/async_value_widget.dart';
import 'package:my_amplify_app/src/features/authentication/data/amplify_auth_repository.dart';
import 'package:my_amplify_app/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:my_amplify_app/src/routing/app_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileValue = ref.watch(currentUserInfoProvider);
    final amplifyController = ref.read(authControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: () async {
                var success = await amplifyController.signOut();
                if (success) {
                  context.goNamed(AppRoute.signIn.name);
                }
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AsyncValueWidget(
                value: profileValue,
                data: (currentUser) => Column(
                      children: [
                        Text('Username: ${currentUser['username'] ?? 'N/A'}'),
                        Text('Email: ${currentUser['email'] ?? 'N/A'}'),
                        Text(
                            'Phone Number: ${currentUser['phone_number'] ?? 'N/A'}'),
                      ],
                    ))
          ],
        ),
      ),
    );
  }
}
