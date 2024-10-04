import 'package:flutter/material.dart';
import 'package:my_amplify_app/src/constants/app_sizes.dart';

/// Text button to be used as an [AppBar] action
class ActionTextButton extends StatelessWidget {
  const ActionTextButton(
      {super.key, required this.text, this.onPressed, this.isLoading = false});
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: TextButton(
        onPressed: onPressed,
        style:
            ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.black)),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(text,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white)),
      ),
    );
  }
}
