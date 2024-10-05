import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_amplify_app/src/features/authentication/data/amplify_auth_repository.dart';
import 'package:my_amplify_app/src/features/authentication/presentation/sign_in_screen.dart';
import 'package:my_amplify_app/src/features/authentication/presentation/sign_up_confirm_screen.dart';
import 'package:my_amplify_app/src/features/authentication/presentation/sign_up_screen.dart';
import 'package:my_amplify_app/src/features/home/home_screen.dart';
import 'package:my_amplify_app/src/features/profile/profile_screen.dart';
import 'package:my_amplify_app/src/features/splash/splash_screen.dart';
import 'package:my_amplify_app/src/routing/go_router_refresh_stream.dart';
import 'package:my_amplify_app/src/routing/not_found_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_router.g.dart';

enum AppRoute {
  splash,
  signIn,
  signUp,
  signUpConfirm,
  home,
  profile,
}

final navigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final amplifyAuthRepository = ref.watch(amplifyAuthProvider);
  final isSignInStatus = ref.watch(isSignedInStatusProvider);

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final path = state.uri.path;
      final authStateStatus = amplifyAuthRepository.currentUser;

      debugPrint('state.uri.path: ${state.fullPath}');
      debugPrint(
          'authStatus: router ${amplifyAuthRepository.currentUser == null}}');

      if (isSignInStatus.isLoading) {
        return '/';
      }

      if (authStateStatus == null &&
          path != '/signUp' &&
          state.fullPath != '/signUp/signUpConfirm/:email' &&
          path != '/home') {
        debugPrint('@@$path');
        return '/signIn';
      } else {
        if (path == '/signIn' || path == '/') {
          return '/home';
        }
      }

      return null;
    },
    refreshListenable:
        GoRouterRefreshStream(amplifyAuthRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
          path: '/signUp',
          name: AppRoute.signUp.name,
          builder: (context, state) => const SignUpScreen(),
          routes: [
            GoRoute(
              path: 'signUpConfirm/:email',
              name: AppRoute.signUpConfirm.name,
              builder: (context, state) {
                String? email = state.pathParameters['email'];

                return SignUpConfirmScreen(
                  email: email ?? '',
                );
              },
            ),
          ]),
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
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
