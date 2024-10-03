import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_amplify_app/src/features/authentication/presentation/sign_in_screen.dart';
import 'package:my_amplify_app/src/features/home/home_screen.dart';
import 'package:my_amplify_app/src/features/profile/profile_screen.dart';

enum AppRoute {
  signIn,
  home,
  profile,
}

final currentUserProvider = FutureProvider<AuthUser?>((ref) async {
  try {
    return await Amplify.Auth.getCurrentUser();
  } on AuthException catch (e) {
    debugPrint('Error getting current user: ${e.message}');
    return null; // No user is authenticated
  }
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final amplifyAuth = ref.watch(currentUserProvider);
  return GoRouter(
    initialLocation: '/sign-in',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = amplifyAuth.asData?.value != null;
      if (isLoggedIn) {
        if (state.uri.path == '/sign-in') {
          return '/home';
        }
      } else {
        if (state.uri.path.startsWith('/home')) {
          return '/sign-in';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/sign-in',
        name: AppRoute.signIn.name,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'profile',
            name: AppRoute.profile.name,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});
