import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_amplify_app/src/common_widgets/custom_text_button.dart';
import 'package:my_amplify_app/src/common_widgets/primary_button.dart';
import 'package:my_amplify_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:my_amplify_app/src/constants/app_sizes.dart';
import 'package:my_amplify_app/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:my_amplify_app/src/routing/app_router.dart';
import 'package:my_amplify_app/src/utils/async_value_ui.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      authControllerProvider,
      (_, state) {
        if (state.hasError) {
          state.showAlertDialogOnError(context);
        } else if (state is AsyncData) {
          debugPrint('Sign-up successful, navigating to confirm screen...');
          context.goNamed(AppRoute.signUpConfirm.name,
              pathParameters: {'email': _emailController.text});
        }
      },
    );
    final state = ref.watch(authControllerProvider);
    return Scaffold(
        appBar: AppBar(title: const Text('SignUp')),
        body: ResponsiveScrollableCard(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                    text: 'SignUp',
                    isLoading: state.isLoading,
                    onPressed: () => _signUp()),
                gapH8,
                CustomTextButton(
                  text: 'Login',
                  onPressed: () => context.pop(),
                ),
              ])),
        ));
  }

  Future<void> _signUp() async {
    final controller = ref.read(authControllerProvider.notifier);
    await controller.signUp(
        username: _emailController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }
}
