import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_amplify_app/src/common_widgets/primary_button.dart';
import 'package:my_amplify_app/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:my_amplify_app/src/routing/app_router.dart';
import 'package:my_amplify_app/src/utils/async_value_ui.dart';

class SignUpConfirmScreen extends ConsumerStatefulWidget {
  final String email;
  const SignUpConfirmScreen({super.key, required this.email});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpConfirmScreenState();
}

class _SignUpConfirmScreenState extends ConsumerState<SignUpConfirmScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      authControllerProvider,
      (_, state) {
        if (state.hasError) {
          state.showAlertDialogOnError(context);
        } else if (state is AsyncData) {
          debugPrint('verify successful, navigating to confirm screen...');
          context.goNamed(AppRoute.home.name);
        }
      },
    );
    final state = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Your Email')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: 'Code'),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: 'Verify',
              isLoading: state.isLoading,
              onPressed: state.isLoading ? null : () => _signUpConfirm(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signUpConfirm() async {
    final controller = ref.read(authControllerProvider.notifier);
    await controller.signUpConfirm(
        username: widget.email, code: _codeController.text);
  }
}