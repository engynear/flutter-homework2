import 'package:hive/hive.dart';

part 'news.g.dart';

@HiveType(typeId: 0)
class News extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final String urlToImage;

  @HiveField(4)
  final String publishedAt;

  @HiveField(5)
  final String content;

  News({
    required this.title,
    this.description = "",
    required this.url,
    this.urlToImage = "",
    required this.publishedAt,
    this.content = "",
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'],
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'],
      content: json['content'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is News &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          url == other.url &&
          urlToImage == other.urlToImage &&
          publishedAt == other.publishedAt &&
          content == other.content;

  @override
  int get hashCode =>
      title.hashCode ^
      description.hashCode ^
      url.hashCode ^
      urlToImage.hashCode ^
      publishedAt.hashCode ^
      content.hashCode;
}
