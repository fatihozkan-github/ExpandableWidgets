import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class TestUtils {
  static MaterialApp widgetBase(Widget child) => MaterialApp(home: Scaffold(body: child));

  static Future pumpWidgetBasic(WidgetTester tester, Widget child) async => await tester.pumpWidget(widgetBase(child));

  static Future<void> renderSpeedTest(Widget child, WidgetTester tester,
      {Duration duration = const Duration(milliseconds: 500), bool basic = true, bool printRenderTime = true}) async {
    Stopwatch _testWatch = Stopwatch()..start();
    await pumpWidgetBasic(tester, child).whenComplete(() => _testWatch.stop());

    if (printRenderTime) print(_testWatch.elapsed.inMilliseconds.toString() + ' milliseconds');

    expect(true, _testWatch.elapsedMilliseconds < duration.inMilliseconds,
        reason: 'Render Time: ${_testWatch.elapsed.inMilliseconds} milliseconds\n'
            'Expected Render Time: ${duration.inMilliseconds} milliseconds');
    _testWatch.reset();
  }
}
