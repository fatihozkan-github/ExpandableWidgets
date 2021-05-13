import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Expandable Widget Showcase')),
        ),
        body: ListView(
          children: [
            SizedBox(height: 10),

            /// General use
            ExpandableWidget(
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
            ),
            SizedBox(height: 10),

            /// For long texts
            ExpandableWidget.singleTextChild(
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              maxLines: 3,
              elevation: 5,
              padding: EdgeInsets.all(10),
              animationDuration: Duration(seconds: 1),
            ),
            SizedBox(height: 10),

            /// Extended example
            ExpandableWidget.extended(
              elevation: 10,
              initiallyExpanded: true,
              centralizePrimaryWidget: true,
              centralizeAdditionalWidget: true,
              primaryWidget: Container(
                height: 30,
                child: Center(child: Text('Important Summary')),
              ),
              secondaryWidget: Container(
                height: 45,
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
            ),
            SizedBox(height: 10),

            /// Example with background image
            ExpandableWidget(
              primaryWidget: Container(height: 10),
              secondaryWidget: Container(height: 20),
              showArrowIcon: true,
              backgroundImage:
                  DecorationImage(image: AssetImage('flutter.png')),
              backgroundColor: Colors.transparent,
              cardMargin: EdgeInsets.all(0),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
