Expandable widget

<h1>Introduction</h1>
A package that provides expandable widgets.


<h1>Examples</h1>
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
              backGroundColor: Colors.grey.withOpacity(0.4),
              showArrowIcon: true,
            ),


            /// For long texts
            ExpandableWidget.singleTextChild(
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              maxLines: 3,
              elevation: 5,
              padding: EdgeInsets.all(10),
              animationDuration: Duration(seconds: 1),
            ),

             /// Extended example
             ExpandableWidget.extended(
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
               elevation: 10,
               additionalWidget: Text('Show more!'),
               arrowColor: Colors.blueGrey,
               initiallyExpanded: true,
               // showArrowIcon: true,
             ),

             /// Example with background image
             ExpandableWidget(
               primaryWidget: Container(height: 10),
               secondaryWidget: Container(height: 20),
               showArrowIcon: true,
               arrowColor: Colors.black,
               backGroundImage: DecorationImage(
                 image: AssetImage('flutter.png'),
               ),
               backGroundColor: Colors.transparent,
               cardPadding: EdgeInsets.all(0),
             ),

             ExpandableWidget(
               primaryWidget: Container(),
               secondaryWidget: Text('Hello world'),
             ),