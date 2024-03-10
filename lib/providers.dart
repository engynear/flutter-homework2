import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'data/models/news.dart';
import 'data/repositories/news_repository.dart';

final pageProvider = StateProvider<int>((ref) => 1);
final countryProvider = StateProvider<String>((ref) {
  final box = Hive.box('settingsBox');
  return box.get('country', defaultValue: 'US') ?? 'US';
});
final categoryProvider = StateProvider<String>((ref) {
  final box = Hive.box('settingsBox');
  return box.get('category', defaultValue: 'business') ?? 'business';
});
final newsListProvider = FutureProvider.autoDispose<List<News>>((ref) async {
  final category = ref.watch(categoryProvider);
  final country = ref.watch(countryProvider);
  final repository = ref.read(newsRepositoryProvider);
  return repository.fetchNews(category, country);
});

final newsRepositoryProvider = Provider((ref) => NewsRepository());

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<News>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<News>> {
  FavoritesNotifier() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final box = Hive.box<News>('favorites');
    state = box.values.toList();
  }

  void addFavorite(News news) {
    final box = Hive.box<News>('favorites');
    box.add(news);
    state = [...state, news];
  }

  void removeFavorite(News news) {
    final box = Hive.box<News>('favorites');
    box.delete(news.key);
    state = state.where((item) => item.key != news.key).toList();
  }
}
