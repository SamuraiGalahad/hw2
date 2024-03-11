import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'model/news_model.dart';

class LikesModule {
  static SharedPreferences? prefs;

  Future<void> addNews(News news) async {
    prefs = await SharedPreferences.getInstance();
    List<News> prev = await readLikedNewsFromPrefs();

    prev.add(news);

    String likedJson = jsonEncode(prev);

    await prefs!.setString('likedNews', likedJson);
  }

  Future<List<News>> readLikedNewsFromPrefs() async {
    prefs = await SharedPreferences.getInstance();
    try {
      String? newsJson = prefs?.getString('likedNews');
      if (newsJson != null) {
        List<dynamic> newsData = jsonDecode(newsJson);
        List<News> newsList =
            newsData.map((data) => News.fromJson(data)).toList();
        return newsList;
      }
    } catch (error) {
      print('Error getting news from SharedPreferences: $error');
      return [];
    }
    return [];
  }
}
