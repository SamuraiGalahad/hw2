import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw1/src/newsapp/model/news_model.dart';
import 'package:hw1/src/newsapp/theme/theme_provider.dart';
import 'package:hw1/src/newsapp/web_module.dart';

void main() {
  test('Toggle theme changes the themeData', () {
    final themeProvider = ThemeProvider();
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black),
      ),
    );
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black54,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
      ),
    );

    expect(themeProvider.themeData.brightness, lightTheme.brightness);
    expect(themeProvider.themeData.primaryColor, lightTheme.primaryColor);
    expect(themeProvider.themeData.textTheme.bodyLarge!.color,
        lightTheme.textTheme.bodyLarge!.color);

    themeProvider.toggleTheme();
    expect(themeProvider.themeData.brightness, darkTheme.brightness);
    expect(themeProvider.themeData.primaryColor, darkTheme.primaryColor);
    expect(themeProvider.themeData.textTheme.bodyLarge!.color,
        darkTheme.textTheme.bodyLarge!.color);

    themeProvider.toggleTheme();
    expect(themeProvider.themeData.brightness, lightTheme.brightness);
    expect(themeProvider.themeData.primaryColor, lightTheme.primaryColor);
    expect(themeProvider.themeData.textTheme.bodyLarge!.color,
        lightTheme.textTheme.bodyLarge!.color);
  });

  // test only with Intenet Connection
  test("Testing WebModule main Function working", () async {
    final webModule = WebModule();

    List<News> testList = await webModule.getNewsListTest();

    assert(testList.isNotEmpty);
  });
}
