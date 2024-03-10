import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';
import '../../data/models/news.dart';
import '../widgets/news_tile.dart';
import 'news_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<News> favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text('No favorites yet'),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final news = favorites[index];
                return NewsTile(
                  title: news.title,
                  description: news.description,
                  imageUrl: news.urlToImage,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => NewsDetailPage(news: news)),
                    );
                  },
                );
              },
            ),
    );
  }
}
