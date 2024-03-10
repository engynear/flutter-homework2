import 'package:hive/hive.dart';
import '../models/news.dart';

class LocalStorageService {
  Future<void> saveNews(List<News> news) async {
    var box = await Hive.openBox('newsBox');
    await box.put('news', news.map((n) => n.toJson()).toList());
  }

  Future<List<News>> loadNews() async {
    var box = await Hive.openBox('newsBox');
    final newsJson = box.get('news', defaultValue: []);
    return newsJson.map<News>((n) => News.fromJson(n)).toList();
  }
}
