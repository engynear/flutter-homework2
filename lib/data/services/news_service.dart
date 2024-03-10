import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class NewsService {
  final String apiKey = '55f41fc0f4b348d0ad422d5f8a102f85';
  final String baseUrl = 'https://newsapi.org/v2';
  final int pageSize = 10;

  Future<List<News>> fetchNewsByCategoryAndCountry(
      String category, String country,
      {int page = 1}) async {
    // final response = await http.get(Uri.parse('$baseUrl/top-headlines?country=$country&category=$category&pageSize=$pageSize&page=$page&apiKey=$apiKey'));
    const String toDate = '2024-03-10';
    String language = country == 'US' ? 'en' : 'ru';
    final response = await http.get(Uri.parse(
      '$baseUrl/everything?q=+$category&from=2024-03-01&to=$toDate&language=$language&sortBy=publishedAt&pageSize=$pageSize&page=$page&apiKey=$apiKey',
    ));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['articles'].isEmpty) return [];
      List<News> newsList =
          data['articles'].map<News>((json) => News.fromJson(json)).toList();
      newsList.removeWhere((news) => news.title == '[Removed]');
      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
