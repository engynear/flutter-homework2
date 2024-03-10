import '../../data/repositories/news_repository.dart';
import '../../data/models/news.dart';

class FetchNewsUseCase {
  final NewsRepository _newsRepository;

  FetchNewsUseCase(this._newsRepository);

  Future<List<News>> call(String category, String country) async {
    return await _newsRepository.fetchNews(category, country);
  }
}
