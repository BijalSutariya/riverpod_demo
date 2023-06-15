import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/wishlist/providers/async_notifier.dart';
import 'package:riverpod_demo/wishlist/view/wishlist/wishlisted_view.dart';

class WishlistApp extends ConsumerStatefulWidget {
  const WishlistApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WishlistAppState();
}



class _WishlistAppState extends ConsumerState<WishlistApp> {

  @override
  Widget build(BuildContext context) {
    //watch the provider and rebuild when the value changes

    ref.listen<AsyncValue<void>>(
      wishlistAsyncNotifierProvider,
          (_, state) => state.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      ),
    );
    final wishlistState = ref.watch(wishlistAsyncNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist App'),
      ),
      body: wishlistState.when(
        data: (data) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: data.games.length,
            itemBuilder: (context, index) {
              final game = data.games[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        game.imageUrl,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.blueGrey])),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            game.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: InkWell(
                        onTap: () {
                          final vm =
                              ref.read(wishlistAsyncNotifierProvider.notifier);

                          if (vm.isWishListed(game.id)) {
                            vm.removeFromWishlist(game.id);
                          } else {
                            vm.addToWishlist(game.id);
                          }
                        },
                        child: Align(
                          child: Icon(
                            Icons.favorite,
                            color: data.wishlist.contains(game.id)
                                ? Colors.redAccent
                                : Colors.black38,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('problem in loading games'),
              const SizedBox(
                height: 16.0,
              ),
              OutlinedButton(
                  onPressed: () {
                    ref
                        .read(wishlistAsyncNotifierProvider.notifier)
                        .reloadGames();
                  },
                  child: const Text('try again'))
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: wishlistState.value == null
          ? null
          : Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: FloatingActionButton(
                    onPressed: _launchWishlistedView,
                    tooltip: 'View wishlist',
                    child: const Icon(Icons.auto_fix_high_outlined),
                  ),
                ),
                if (wishlistState.value!.wishlist.isNotEmpty)
                  Positioned(
                      right: -4,
                      bottom: 40,
                      child: CircleAvatar(
                        backgroundColor: Colors.tealAccent,
                        radius: 12,
                        child: Text(wishlistState.value!.wishlist.length.toString()),
                      ))
              ],
            ),
    );
  }

  void _launchWishlistedView() {
    Navigator.push(
      context,
      PageRouteBuilder(
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          pageBuilder: (_, __, ___) => const WishListedView()),
    );
  }
}
