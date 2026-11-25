import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/rating.dart';

class RatingService {
  static const _projectId = 'capstone-dano';
  static const _host = 'firestore.googleapis.com';
  static const _base = '/v1/projects/$_projectId/databases/(default)/documents/ratings';
  static const _headers = {'Content-Type': 'application/json'};

  Uri _uri([String? id, Map<String, dynamic>? query]) {
    return Uri.https(_host, id == null ? _base : '$_base/$id', query);
  }

  void _check(http.Response res) {
    if (res.statusCode >= 400) {
      throw Exception('Request failed: ${res.statusCode} ${res.body}');
    }
  }

  Map<String, dynamic> _body(Rating rating, {bool isNew = false}) {
    return {
      'fields': {
        'target': {'stringValue': rating.target},
        'stars': {'doubleValue': rating.stars},
        'comment': {'stringValue': rating.comment},
        if (isNew) 'createdAt': {'timestampValue': DateTime.now().toUtc().toIso8601String()},
      },
    };
  }

  double _number(Map<String, dynamic> value) {
    final raw = value['doubleValue'] ?? value['integerValue'];
    return raw is num ? raw.toDouble() : double.parse('$raw');
  }

  Rating _fromDoc(Map<String, dynamic> doc) {
    final fields = doc['fields'] as Map<String, dynamic>;
    final id = (doc['name'] as String).split('/').last;
    return Rating.fromMap(id, {
      'target': (fields['target'] as Map<String, dynamic>)['stringValue'],
      'stars': _number(fields['stars'] as Map<String, dynamic>),
      'comment': (fields['comment'] as Map<String, dynamic>?)?['stringValue'] ?? '',
    });
  }

  Future<void> add(Rating rating) async {
    final res = await http.post(
      _uri(),
      headers: _headers,
      body: json.encode(_body(rating, isNew: true)),
    );
    _check(res);
  }

  Future<List<Rating>> fetchAll() async {
    final ratings = <Rating>[];
    String? token;

    do {
      final res = await http.get(_uri(null, {
        'orderBy': 'createdAt',
        'pageSize': '300',
        if (token != null) 'pageToken': token,
      }));
      _check(res);

      final data = json.decode(res.body) as Map<String, dynamic>;
      final docs = (data['documents'] as List?) ?? [];
      ratings.addAll(docs.map((d) => _fromDoc(d as Map<String, dynamic>)));
      token = data['nextPageToken'] as String?;
    } while (token != null);

    return ratings;
  }

  Future<void> update(Rating rating) async {
    final res = await http.patch(
      _uri(rating.id, {
        'updateMask.fieldPaths': ['target', 'stars', 'comment'],
      }),
      headers: _headers,
      body: json.encode(_body(rating)),
    );
    _check(res);
  }

  Future<void> delete(String id) async {
    final res = await http.delete(_uri(id));
    _check(res);
  }
}
