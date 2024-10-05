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
String _$authStateChangesHash() => r'37ca2b8bba1b4ff1635751b856c85c07d3d5e30d';

/// See also [authStateChanges].
@ProviderFor(authStateChanges)
final authStateChangesProvider =
    StreamProvider<List<AuthUserAttribute>?>.internal(
  authStateChanges,
  name: r'authStateChangesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateChangesRef = StreamProviderRef<List<AuthUserAttribute>?>;
String _$isSignedInStatusHash() => r'7a291348468099e67a85eb309a3ddaaca4b20ec3';

/// See also [isSignedInStatus].
@ProviderFor(isSignedInStatus)
final isSignedInStatusProvider = FutureProvider<bool>.internal(
  isSignedInStatus,
  name: r'isSignedInStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isSignedInStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsSignedInStatusRef = FutureProviderRef<bool>;
String _$fetchUserInfoHash() => r'a7d60d9950c0e1efca943e518100bcb60217f53d';

/// See also [fetchUserInfo].
@ProviderFor(fetchUserInfo)
final fetchUserInfoProvider = FutureProvider<List<AuthUserAttribute>>.internal(
  fetchUserInfo,
  name: r'fetchUserInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchUserInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchUserInfoRef = FutureProviderRef<List<AuthUserAttribute>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
