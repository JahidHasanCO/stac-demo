import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(photosProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Photos')),
      body: photosAsync.when(
        data: (photos) => ListView.builder(
          itemCount: photos.length,
          itemBuilder: (context, i) {
            final p = photos[i];
            return ListTile(
              leading: Image.network(p.thumbnailUrl),
              title: Text(p.title),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
