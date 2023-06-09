import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_demo/wishlist/providers/wishlist_state.dart';
import 'package:riverpod_demo/wishlist/wishlist.dart';

part 'async_notifier.g.dart';

//https://docs-v2.riverpod.dev/docs/providers/notifier_provider

/* remove this when use riverpod_annotation
final wishlistAsyncNotifierProvider =
    AsyncNotifierProvider<WishlistAsyncNotifier, WishlistState>(
        () => WishlistAsyncNotifier());
*/

@riverpod
List<BoardGame> wishlistGames(WishlistGamesRef ref) {
  final state = ref.watch(wishlistAsyncNotifierProvider).value;
  if (state == null) {
    return [];
  }

  return state.wishlist
      .map<BoardGame>(
        (id) => state.games.singleWhere(
          (game) => game.id == id,
        ),
      )
      .toList();
}

@riverpod
class WishlistAsyncNotifier extends _$WishlistAsyncNotifier {
  WishlistRepository get _api => ref.read(repositoryProvider('JLBr5npPhV'));

  @override
  Future<WishlistState> build() => _loadGames();

  Future<WishlistState> _loadGames() async {
    final response = await _api.fetchData() ;

    List<BoardGame> listOfBoardGames = [];
    response.fold(
      (exception) async {
        throw Exception('API request failed with status code: $exception');
      },
      (data) {
        listOfBoardGames.addAll(data);
      }, // Handle success case
    );
    return WishlistState(games: listOfBoardGames);
  }

  Future<void> reloadGames() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadGames());
  }

  void addToWishlist(String id) {
    state = AsyncValue.data(state.value!.copyWith(
      wishlist: {...state.value!.wishlist, id},
    ));
  }

  bool isWishListed(String id) => state.value!.wishlist.contains(id);

  void removeFromWishlist(String id) {
    state = AsyncValue.data(state.value!.copyWith(
      wishlist: {...state.value!.wishlist..remove(id)},
      // (...) spread operator :  It is used to "spread" the elements of an iterable (such as a list or a set) into another iterable or as arguments to a function
      // two use case:
      // 1. Spreading elements in a collection
      // 2. Spreading arguments in a function call
      // (..) cascade operator : It allows you to perform multiple operations on the same object without repeating the object reference
    ));
  }
}
