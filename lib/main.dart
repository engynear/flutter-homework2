import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/models/news.dart';
import 'ui/screens/start_screen.dart';
import 'ui/themes/light_theme.dart' show lightTheme;
import 'ui/themes/dark_theme.dart' show darkTheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settingsBox');
  Hive.registerAdapter(NewsAdapter());
  await Hive.openBox<News>('favorites');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'engynear`s news',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: const StartScreen(),
    );
  }
}
