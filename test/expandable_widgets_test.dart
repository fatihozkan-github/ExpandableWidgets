import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:expandable_widgets/src/expandable_text_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('description', (WidgetTester test) async {
    await test.pumpWidget(ExpandableWidget(
      primaryWidget: Container(
        height: 30,
        child: Center(child: Text('Hello world!')),
      ),
      secondaryWidget: Container(
        height: 45,
        child: Center(
          child: Column(
            children: [
              Text('Hello'),
              Text('World!'),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.withOpacity(0.4),
      showArrowIcon: true,
      centralizePrimaryWidget: true,
    ));

    await test.pumpWidget(ExpandableTextWidget.singleTextChild(
      text:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      maxLines: 3,
      elevation: 5,
      padding: EdgeInsets.all(10),
      animationDuration: Duration(seconds: 1),
    ));

    await test.pumpWidget(ExpandableWidget.extended(
      elevation: 10,
      initiallyExpanded: true,
      centralizePrimaryWidget: true,
      centralizeAdditionalWidget: true,
      primaryWidget: Container(
        height: 30,
        child: Center(child: Text('Important Summary')),
      ),
      secondaryWidget: Container(
        child: Center(
          child: Column(
            children: [
              Text('More'),
              Text('Details'),
              Text('About'),
              Text('Something'),
            ],
          ),
        ),
      ),
      additionalWidget: Text('Show me details'),
    ));

    await test.pumpWidget(ExpandableWidget.extended(
      primaryWidget: Text('hello world!'),
      secondaryWidget: Text('STILL D.R.E'),
      backGroundColor: Colors.orange,
    ));

    await test.pumpWidget(ExpandableWidget(
      primaryWidget: Container(height: 10),
      secondaryWidget: Container(height: 20),
      showArrowIcon: true,
      backgroundImage: DecorationImage(
        image: AssetImage('background.png'),
        repeat: ImageRepeat.repeatX,
      ),
      backgroundColor: Colors.transparent,
      cardMargin: EdgeInsets.all(0),
    ));
  });
}
