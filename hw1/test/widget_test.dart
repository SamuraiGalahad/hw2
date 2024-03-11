// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw1/src/newsapp/model/news_model.dart';
import 'package:hw1/src/newsapp/widget/detail_screen.dart';
import 'package:hw1/src/newsapp/widget/favorite_screen.dart';
import 'package:hw1/src/newsapp/widget/row_item.dart';

void main() {
  testWidgets('ColumnItem Widget Test', (WidgetTester tester) async {
    News news = News(
      id: '1',
      name: 'News Name',
      title: 'News Title',
      description: 'News Description',
      url: 'https://example.com/news',
      urlToImage: 'https://example.com/image.jpg',
      publishedAt: '2022-02-20T12:00:00Z',
      content: 'News Content',
      author: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ColumnItem(news),
        ),
      ),
    );

    expect(find.text('News Name'), findsOneWidget);

    expect(find.text('News Title'), findsOneWidget);

    expect(find.text('View'), findsOneWidget);
  });

  testWidgets('DetailsScreen Widget Test', (WidgetTester tester) async {
    News news = News(
      id: '1',
      name: 'News Name',
      title: 'News Title',
      description: 'News Description',
      url: 'https://example.com/news',
      urlToImage: 'https://example.com/image.jpg',
      publishedAt: '2022-02-20T12:00:00Z',
      content: 'News Content',
      author: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DetailsScreen(news),
        ),
      ),
    );

    expect(find.text('News Title'), findsOneWidget);

    expect(find.text('News Name'), findsOneWidget);

    expect(find.text('News Content'), findsOneWidget);

    expect(find.text('Visit source'), findsOneWidget);

    expect(find.byIcon(CupertinoIcons.heart_solid), findsOneWidget);
  });

  group('FavoriteScreen Widget Test', () {
    testWidgets('Test if FavoriteScreen widget builds',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: FavoriteScreen()));
      expect(find.byType(FavoriteScreen), findsOneWidget);
    });
  });
}
