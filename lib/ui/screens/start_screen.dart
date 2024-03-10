import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/news_tile.dart';
import '../../providers.dart';
import '../../domain/entities/news_category.dart';
import 'news_screen.dart';
import 'favorites_screen.dart';

final categories = [
  NewsCategory(name: 'business', icon: Icons.business),
  NewsCategory(name: 'technology', icon: Icons.devices),
  NewsCategory(name: 'health', icon: Icons.healing),
  NewsCategory(name: 'sports', icon: Icons.sports_soccer),
];

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsListAsyncValue = ref.watch(newsListProvider);
    final currentCountry = ref.watch(countryProvider);
    final currentCategory = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("engynear's News"),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const FavoritesScreen(),
              ));
            },
          ),
        ],
      ),
      body: newsListAsyncValue.when(
        data: (newsList) => ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            final news = newsList[index];
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newCountry = currentCountry == 'US' ? 'RU' : 'US';
          ref.read(countryProvider.notifier).state = newCountry;
          Hive.box('settingsBox').put('country', newCountry);
        },
        child: Text(currentCountry),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: categories
              .map((category) => IconButton(
                    icon: Icon(category.icon),
                    onPressed: () {
                      ref.read(categoryProvider.notifier).state = category.name;
                      Hive.box('settingsBox').put('category', category.name);
                    },
                    color: currentCategory == category.name
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
