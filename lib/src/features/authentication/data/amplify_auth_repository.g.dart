// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amplify_auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$amplifyAuthHash() => r'62888c7e66af165178fdf6bed8b22c5bc01e1d93';

/// See also [amplifyAuth].
@ProviderFor(amplifyAuth)
final amplifyAuthProvider = Provider<AmplifyAuthRepository>.internal(
  amplifyAuth,
  name: r'amplifyAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$amplifyAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AmplifyAuthRef = ProviderRef<AmplifyAuthRepository>;
String _$currentUserInfoHash() => r'82360c9e32077468b4213a96baf77a328114ef3c';

/// See also [currentUserInfo].
@ProviderFor(currentUserInfo)
final currentUserInfoProvider =
    AutoDisposeFutureProvider<Map<String, String>>.internal(
  currentUserInfo,
  name: r'currentUserInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserInfoRef = AutoDisposeFutureProviderRef<Map<String, String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
