import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'test_utils.dart';

void main() {
  testWidgets('hitTest????', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestUtils.widgetBase(
        Expandable(
          firstChild: const SizedBox(height: 30, child: Center(child: Text('Hello world!'))),
          secondChild: SizedBox(height: 45, child: Center(child: Column(children: const [Text('Hello'), Text('World!')]))),
          backgroundColor: Colors.grey.withOpacity(0.4),
          clickable: Clickable.everywhere,
        ),
      ),
    );
    // tester.hitTestOnBinding(Offset.infinite);
  });
}

//       await test.pumpWidget(
//         ExpandableText(
//           textWidget: Text(
//             'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
//             maxLines: 3,
//             overflow: TextOverflow.ellipsis,
//           ),
//           elevation: 5,
//           padding: EdgeInsets.all(10),
//           animationDuration: Duration(seconds: 1),
//           showHelperText: true,
//           showArrowWidget: false,
//           onPressed: () => print('test'),
//           hoverOn: true,
//         ),
//       );
//
//       await test.pumpWidget(
//         Expandable.extended(
//           elevation: 10,
//           initiallyExpanded: true,
//           centralizePrimaryWidget: true,
//           centralizeAdditionalWidget: true,
//           firstChild: Container(
//             height: 30,
//             child: Center(child: Text('Important Summary')),
//           ),
//           secondChild: Container(
//             child: Center(
//               child: Column(
//                 children: [
//                   Text('More'),
//                   Text('Details'),
//                   Text('About'),
//                   Text('Something'),
//                 ],
//               ),
//             ),
//           ),
//           additionalChild: Text('Show me details'),
//         ),
//       );
//
//       await test.pumpWidget(
//         Expandable.extended(
//           firstChild: Text('hello world!'),
//           secondChild: Text('STILL D.R.E'),
//           backGroundColor: Colors.orange,
//         ),
//       );
//
//       await test.pumpWidget(
//         Expandable(
//           firstChild: Container(height: 10),
//           secondChild: Container(height: 20),
//           // showArrowIcon: true,
//           backgroundImage: DecorationImage(
//             image: AssetImage('assets/background.png'),
//             repeat: ImageRepeat.repeatX,
//           ),
//           backgroundColor: Colors.transparent,
//         ),
//       );
//     },
//   );
// }
