import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('description', (WidgetTester test) async {
    // await test.pumpWidget(ExpandableWidget.singleTextChild(
    //   // primaryWidget: Text('hello world!', textDirection: TextDirection.ltr),
    //   text: 'ASDSFDGHJKLKŞJLJHDDSFDGHJKLKJLGHFDSASSFGHJKL',
    // ));

    await test.pumpWidget(ExpandableWidget.extended(
      primaryWidget: Text('hello world!'),
      secondaryWidget: Text('STILL D.R.E'),
      backGroundColor: Colors.orange,
      showArrowIcon: true,
    ));
  });
}
