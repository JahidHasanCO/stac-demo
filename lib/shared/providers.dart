import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final authProvider = StateProvider<bool>((ref) => false);

final photosProvider = FutureProvider<List<Photo>>((ref) async {
  final res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  if (res.statusCode != 200) throw Exception('Failed to load photos');
  final List decoded = jsonDecode(res.body) as List;
  return decoded.take(100).map((e) => Photo.fromJson(e)).toList();
});

class Photo {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({required this.id, required this.title, required this.url, required this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> j) => Photo(
    id: j['id'] as int,
    title: j['title'] as String,
    url: j['url'] as String,
    thumbnailUrl: j['thumbnailUrl'] as String,
  );
}
