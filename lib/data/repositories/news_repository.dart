import '../models/news.dart';
import '../services/news_service.dart';
import '../storage/local_storage_service.dart';

class NewsRepository {
  final NewsService _newsService = NewsService();
  final LocalStorageService _localStorageService = LocalStorageService();

  Future<List<News>> fetchNews(String category, String country) async {
    try {
      final news =
          await _newsService.fetchNewsByCategoryAndCountry(category, country);
      await _localStorageService.saveNews(news);
      return news;
    } catch (e) {
      return await _localStorageService.loadNews();
    }
  }
}
