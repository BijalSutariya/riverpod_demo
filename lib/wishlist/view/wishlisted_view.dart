import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/wishlist/providers/async_notifier.dart';

class WishListedView extends ConsumerWidget {
  const WishListedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishListed = ref.watch(wishlistGamesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: wishListed.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Your wishlist is empty',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Add some games'))
                ],
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: wishListed.length,
              itemBuilder: (context, index) {
                final game = wishListed[index];
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
                                  colors: [
                                Colors.transparent,
                                Colors.blueGrey
                              ])),
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
                            final vm = ref
                                .read(wishlistAsyncNotifierProvider.notifier);
                            vm.removeFromWishlist(game.id);
                          },
                          child: const Align(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
