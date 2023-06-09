// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wishlistGamesHash() => r'b4b62feaecb04805f52eb05bfb211bfb1a2dd5c9';

/// See also [wishlistGames].
@ProviderFor(wishlistGames)
final wishlistGamesProvider = AutoDisposeProvider<List<BoardGame>>.internal(
  wishlistGames,
  name: r'wishlistGamesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wishlistGamesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WishlistGamesRef = AutoDisposeProviderRef<List<BoardGame>>;
String _$wishlistAsyncNotifierHash() =>
    r'8f967c32c380b8d75889ef568117101fa1dd03e2';

/// See also [WishlistAsyncNotifier].
@ProviderFor(WishlistAsyncNotifier)
final wishlistAsyncNotifierProvider = AutoDisposeAsyncNotifierProvider<
    WishlistAsyncNotifier, WishlistState>.internal(
  WishlistAsyncNotifier.new,
  name: r'wishlistAsyncNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wishlistAsyncNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WishlistAsyncNotifier = AutoDisposeAsyncNotifier<WishlistState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
