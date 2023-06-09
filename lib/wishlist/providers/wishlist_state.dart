import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/wishlist/wishlist.dart';

/* Commented code is for state Notifier Provider
//https://riverpod.dev/docs/providers/state_notifier_provider
final wishlistStateProvider =
    StateNotifierProvider<WishlistStateNotifier, WishlistState >(
        (ref) => WishlistStateNotifier(ref));
*/

@immutable
class WishlistState {
  final List<BoardGame> games;

  final Set<String> wishlist;

  const WishlistState(
      {this.games = const [],
      this.wishlist = const {},
      });

  WishlistState copyWith({
    List<BoardGame>? games,
    Set<String>? wishlist,
  }) =>
      WishlistState(
        games: games ?? this.games,
        wishlist: wishlist ?? this.wishlist,
      );
}
/*

class WishlistStateNotifier extends StateNotifier<WishlistState> {
  final WishlistRepository _api;

  WishlistStateNotifier(ref)
      : _api = ref.read(repositoryProvider('')),
        super(const WishlistState());

  Future<void> loadGames() async {
    try {
      final response = await _api.getBoardGames();

      state = state.copyWith(
        games: response,
        loading: LoadingState.success,
      );
    } catch (_) {
      state = state.copyWith(
        loading: LoadingState.error,
      );
    }
  }

  Future<void> reloadGames() async {
    state = state.copyWith(
      loading: LoadingState.progress,
    );
    loadGames();
  }
}
*/
