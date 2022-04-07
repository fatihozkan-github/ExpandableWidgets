import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'test_utils.dart';

void main() {
  group('Minimal ExpandableText Test', () {
    testWidgets('should render minimal ExpandableText', (tester) async {
      await TestUtils.pumpWidgetBasic(tester, ExpandableText(textWidget: const Text('')));
    });

    testWidgets('should find the minimal ExpandableText', (tester) async {
      await TestUtils.pumpWidgetBasic(tester, ExpandableText(textWidget: const Text('')));
      expect(find.byType(ExpandableText), findsOneWidget);
    });

    testWidgets('should hit the minimal ExpandableText', (tester) async {
      await TestUtils.pumpWidgetBasic(tester, ExpandableText(textWidget: const Text(''), onPressed: () => debugPrint('tap!')));
      Finder _finder = find.byType(ExpandableText);
      await tester.ensureVisible(_finder);
      await tester.tap(_finder);
      await tester.pumpAndSettle();
    });
  });

  group('copyWith Tests', () {
    testWidgets('should render after copyWith', (tester) async {
      Text _originalText = const Text('testData', style: TextStyle(color: Colors.black));
      Text _copiedText = _originalText.copyWith(softWrap: true, maxLines: 123);
      await tester.pumpWidget(TestUtils.widgetBase(_copiedText));
    });
  });
}
