import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_demo/wishlist/api/api.dart';
import 'package:riverpod_demo/wishlist/view/wishlist/wishlist.dart';

final repositoryProvider = Provider.family<WishlistRepository, String>(
  (_, clientId) => WishlistRepository(clientId),
);

// for api: https://www.boardgameatlas.com/api/docs/search
class WishlistRepository {
  WishlistRepository(String clientId);

  final _client = Dio();

  /*Future<List<BoardGame>> getBoardGames() async {
    final result = await _client.get('/search?limit=20');
    final games = result.data['games'];
    return games.map<BoardGame>((game) => BoardGame.fromJson(game)).toList();
  }*/

  Map<String, dynamic> queryParameters(String userid) => {
        "client_id": userid,
        "limit": 20,
      };

  Future<Either<Exception, List<BoardGame>>> fetchData() async {
    try {
      final response = await _client.get(Apis.searchEndpoint,
          queryParameters: queryParameters("JLBr5npPhV"));

      if (response.statusCode == 200) {
        final games = response.data['games'];
        return right(
            games.map<BoardGame>((game) => BoardGame.fromJson(game)).toList());
      } else {
        return left(Exception('Failed to fetch data'));
      }
    } catch (e) {
      return left(Exception('Failed to fetch data: $e'));
    }
  }
}
