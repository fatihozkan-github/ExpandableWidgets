<h1>Expandable Widgets</h1>
A package that provides expandable widgets for Flutter.
Written in %100 Dart.

<h1>Examples</h1>
General use:

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

For long texts:

           ExpandableWidget.singleTextChild(
             text:
                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
             maxLines: 3,
             elevation: 5,
             padding: EdgeInsets.all(10),
             animationDuration: Duration(seconds: 1),
           ),

Extended example:

           ExpandableWidget.extended(
             elevation: 10,
             initiallyExpanded: true,
             centralizePrimaryWidget: false,
             centralizeAdditionalWidget: true,
             primaryWidget: Container(
               height: 30,
               child: Center(child: Text('Important Summary')),
             ),
             secondaryWidget: Container(
               height: 70,
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
             additionalWidget: Text('Show me'),
           ),

Example with background image:
 
           ExpandableWidget(
             primaryWidget: Container(height: 30),
             secondaryWidget: Container(height: 30),
             showArrowIcon: true,
             backgroundImage: DecorationImage(
               image: AssetImage('background.png'),
               repeat: ImageRepeat.repeatX,
             ),
             backgroundColor: Colors.grey.withOpacity(.3),
             cardMargin: EdgeInsets.all(0),
             arrowWidget: Icon(
               Icons.arrow_upward_rounded,
               color: Colors.blue,
               size: 20.0,
             ),
             animationDuration: Duration(seconds: 1),
             centralizePrimaryWidget: true,
            ),