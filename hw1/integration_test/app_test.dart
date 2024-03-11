import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw1/src/app/app.dart';
import 'package:hw1/src/newsapp/theme/theme_provider.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Проверка перехода на DetailsScreen и самого DetailsScreen",
      (widgetTester) async {
    await widgetTester.pumpWidget(ChangeNotifierProvider(
        create: (context) => ThemeProvider(), child: App()));
    await widgetTester.pumpAndSettle();
    final viewButton = find.byType(Button95);
    await widgetTester.pump();

    expect(viewButton, findsAtLeast(1));

    await widgetTester.tap(viewButton.first);

    await widgetTester.pumpAndSettle(const Duration(milliseconds: 400));

    final titleField = find.byType(Title);
    expect(titleField, findsOneWidget);

    final iconButtonField = find.byType(IconButton);
    expect(iconButtonField, findsExactly(2));

    final textField = find.byType(Text);
    expect(textField, findsExactly(4));

    final imageField = find.byType(CachedNetworkImage);
    expect(imageField, findsExactly(1));
  });

  testWidgets("Проверка лайков", (widgetTester) async {
    await widgetTester.pumpWidget(ChangeNotifierProvider(
        create: (context) => ThemeProvider(), child: App()));
    await widgetTester.pumpAndSettle();
    final viewButton = find.byType(Button95);
    await widgetTester.pump();

    expect(viewButton, findsAtLeast(1));

    await widgetTester.tap(viewButton.first);

    await widgetTester.pumpAndSettle(const Duration(milliseconds: 400));

    final iconButtonField = find.byType(IconButton);
    expect(iconButtonField, findsExactly(2));

    await widgetTester.tap(iconButtonField.first);

    final NavigatorState navigator = widgetTester.state(find.byType(Navigator));
    navigator.pop();
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 400));

    final selectorField = find.byType(Tab);
    expect(selectorField, findsExactly(2));

    await widgetTester.tap(selectorField.last);
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 400));

    await widgetTester.pump();

    expect(viewButton, findsAtLeast(1));
  });
}
