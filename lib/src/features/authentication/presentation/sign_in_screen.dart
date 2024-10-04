import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_amplify_app/src/common_widgets/custom_text_button.dart';
import 'package:my_amplify_app/src/common_widgets/primary_button.dart';
import 'package:my_amplify_app/src/common_widgets/responsive_center.dart';
import 'package:my_amplify_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:my_amplify_app/src/constants/app_sizes.dart';
import 'package:my_amplify_app/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:my_amplify_app/src/routing/app_router.dart';
import 'package:my_amplify_app/src/utils/async_value_ui.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      authControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: ResponsiveScrollableCard(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'SignIn',
                isLoading: state.isLoading,
                onPressed: state.isLoading ? null : () => _submit(),
              ),
              gapH8,
              CustomTextButton(
                text: 'SignUp',
                onPressed: state.isLoading
                    ? null
                    : () => context.pushNamed(AppRoute.signUp.name),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final controller = ref.read(authControllerProvider.notifier);
    await controller.signIn(
        email: _usernameController.text, password: _passwordController.text);
  }
}
