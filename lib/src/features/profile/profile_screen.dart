import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_amplify_app/src/common_widgets/action_text_button.dart';
import 'package:my_amplify_app/src/common_widgets/alert_dialogs.dart';
import 'package:my_amplify_app/src/common_widgets/async_value_widget.dart';
import 'package:my_amplify_app/src/features/authentication/data/amplify_auth_repository.dart';
import 'package:my_amplify_app/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:my_amplify_app/src/utils/async_value_ui.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileValue = ref.watch(currentUserInfoProvider);
    ref.listen<AsyncValue>(
      authControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          ActionTextButton(
            text: 'Logout',
            isLoading: state.isLoading,
            onPressed: state.isLoading
                ? null
                : () async {
                    final logout = await showAlertDialog(
                      context: context,
                      title: 'Are you sure?',
                      cancelActionText: 'Cancel',
                      defaultActionText: 'Logout',
                    );
                    if (logout == true) {
                      ref.read(authControllerProvider.notifier).signOut();
                    }
                  },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
