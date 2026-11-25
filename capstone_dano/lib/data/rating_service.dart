import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/rating.dart';

class RatingService {
  static const _host = 'capstone-dano-default-rtdb.firebaseio.com';

  Uri _uri([String? id]) => Uri.https(_host, id == null ? 'ratings.json' : 'ratings/$id.json');

  void _check(http.Response res) {
    if (res.statusCode >= 400) {
      throw Exception('Request failed: ${res.statusCode}');
    }
  }

  Future<void> add(Rating rating) async {
    final res = await http.post(_uri(), body: json.encode(rating.toMap()));
    _check(res);
  }

  Future<List<Rating>> fetchAll() async {
    final res = await http.get(_uri());
    _check(res);
    final data = json.decode(res.body);
    if (data == null) return [];
    final map = data as Map<String, dynamic>;
    return map.entries
        .map((e) => Rating.fromMap(e.key, e.value as Map<String, dynamic>))
        .toList();
  }

  Future<void> update(Rating rating) async {
    final res = await http.patch(_uri(rating.id), body: json.encode(rating.toMap()));
    _check(res);
  }

  Future<void> delete(String id) async {
    final res = await http.delete(_uri(id));
    _check(res);
  }
}
