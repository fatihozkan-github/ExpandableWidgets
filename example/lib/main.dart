import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';

void main() => runApp(ExpandableShowcase());

class ExpandableShowcase extends StatefulWidget {
  @override
  _ExpandableShowcaseState createState() => _ExpandableShowcaseState();
}

class _ExpandableShowcaseState extends State<ExpandableShowcase> with TickerProviderStateMixin {
  final String data =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

  Animatable<double> _sizeTween = Tween<double>(begin: 0.0, end: 1.0);
  late AnimationController _animationController;
  late Animation<double> _animation;

  List<String> month = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    CurvedAnimation curve = CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation = _sizeTween.animate(curve);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text('Expandable Widget Showcase'))),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: [
              SizedBox(height: 10),

              /// General use
              Expandable(
                clickable: Clickable.firstChildOnly,
                firstChild: Container(child: Center(child: Text('Hello world!'))),
                secondChild: Center(child: Column(children: [Text('Hello'), Text('World!')])),
                backgroundColor: Colors.grey.withOpacity(0.4),
                padding: EdgeInsets.all(8.0),
                showArrowWidget: false,
              ),

              /// Nested Expandable Widgets
              Expandable(
                firstChild: Text('Nested Expandable Widgets'),
                expandOnHover: true,
                secondChild: Expandable(
                  firstChild: Text('Second Expandable'),
                  expandOnHover: true,
                  secondChild: Expandable(
                    firstChild: Text('Third Expandable'),
                    secondChild: Text('The End'),
                    expandOnHover: true,
                  ),
                ),
              ),

              ///
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Expandable(
                      clickable: Clickable.firstChildOnly,
                      firstChild: Container(child: Center(child: Text('Hello world!'))),
                      secondChild: Center(child: Column(children: [Text('Hello'), Text('World!')])),
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(8.0),
                      showArrowWidget: false,
                      wrapContent: false,
                    ),
                  ),
                  Expanded(
                    child: Expandable(
                      clickable: Clickable.firstChildOnly,
                      firstChild: Container(child: Center(child: Text('Hello world!'))),
                      secondChild: Center(child: Column(children: [Text('Hello'), Text('World!')])),
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(8.0),
                      showArrowWidget: false,
                      wrapContent: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              Row(
                children: [
                  /// Let's say one wants to use Expandable and Flutter's AnimatedIcon at
                  /// the same time. No problem, Expandable gets you covered!
                  ///
                  /// Do not forget to add the relevant animationController to Expandable!
                  Expandable(
                    firstChild: Text('Settings'),
                    secondChild: Column(
                      children: [Text('Option 1'), Text('Option 2'), Text('Option 3')],
                    ),
                    arrowLocation: ArrowLocation.right,
                    arrowWidget: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _animation),
                    animationController: _animationController,
                  ),

                  /// Even more, one can combine AnimatedIcon and Expandable's rotation animation!
                  ///
                  /// Just give the same animation to AnimatedIcon and Expandable.
                  ///
                  /// Do not forget to add relevant animationController to Expandable!
                  Expandable(
                    firstChild: Text('Settings'),
                    secondChild: Column(
                      children: [Text('Option 1'), Text('Option 2'), Text('Option 3')],
                    ),
                    arrowLocation: ArrowLocation.right,
                    arrowWidget: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _animation),
                    animation: _animation,
                    animationController: _animationController,
                  ),
                ],
              ),
              SizedBox(height: 40),

              /// A list that contains expandable widgets.
              ListView(
                shrinkWrap: true,
                children: [
                  for (int i = 0; i < 12; i++)
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Expandable(
                        firstChild: Container(
                            width: 150,
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today_sharp, color: Colors.blueGrey, size: 20),
                                SizedBox(width: 5),
                                Text(month[i]),
                              ],
                            )),
                        secondChild:
                            Center(child: Column(children: [Text('TODO List'), Text('Task')])),
                        clickable: Clickable.firstChildOnly,
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        borderRadius: BorderRadius.circular(5.0),
                        elevation: 5,
                        arrowLocation: ArrowLocation.right,
                        expandOnHover: true,
                        wrapContent: true,
                        centralizeFirstChild: false,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 40),

              /// Horizontal Expandable widgets.
              ///
              /// In this instance, one should be careful about the last element at each row.
              ///
              /// If expandOnHover is true, there will be an unexpected behaviour(not a bug).
              Wrap(
                direction: Axis.horizontal,
                runSpacing: 10,
                spacing: 10,
                children: [
                  for (int i = 0; i < 12; i++)
                    Expandable(
                      firstChild: Container(height: 150, width: 170),
                      secondChild: Container(
                        width: 300,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Movie Title',
                                    style:
                                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Icon(Icons.favorite_outline_rounded, color: Colors.red)
                                ],
                              ),
                              Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      clickable: Clickable.everywhere,
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      direction: Axis.horizontal,
                      expandOnHover: true,
                      showArrowWidget: false,
                      backgroundImage: DecorationImage(
                        image: AssetImage('poster.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                      animationDuration: Duration(milliseconds: 600),
                    ),
                ],
              ),

              // As a workaround one can use ListView:
              // Container(
              //   height: 246,
              //   constraints: BoxConstraints(
              //     minWidth: 300,
              //   ),
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: [
              //       ListView(
              //         scrollDirection: Axis.horizontal,
              //         controller: _scrollController,
              //         padding: EdgeInsets.symmetric(horizontal: 15),
              //         children: [
              //           for (int i = 0; i < 12; i++)
              //             Padding(
              //               padding: EdgeInsets.all(4.0),
              //               child: Expandable(
              //                 firstChild: Container(height: 150, width: 170),
              //                 secondChild: Container(
              //                   width: 300,
              //                   child: Padding(
              //                     padding: EdgeInsets.all(8.0),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Row(
              //                           children: [
              //                             Text(
              //                               'Movie Title',
              //                               style: TextStyle(
              //                                   color: Colors.white, fontWeight: FontWeight.bold),
              //                             ),
              //                             Spacer(),
              //                             Icon(Icons.favorite_outline_rounded, color: Colors.red)
              //                           ],
              //                         ),
              //                         Text(
              //                             'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              //                             maxLines: 3,
              //                             style: TextStyle(color: Colors.white)),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 clickable: Clickable.everywhere,
              //                 padding: EdgeInsets.zero,
              //                 backgroundColor: Colors.transparent,
              //                 direction: Axis.horizontal,
              //                 expandOnHover: true,
              //                 showArrowWidget: false,
              //                 backgroundImage: DecorationImage(
              //                   image: AssetImage('poster.png'),
              //                   fit: BoxFit.cover,
              //                   alignment: Alignment.topCenter,
              //                 ),
              //                 animationDuration: Duration(milliseconds: 600),
              //               ),
              //             ),
              //         ],
              //       ),
              //       Positioned(
              //         left: 0,
              //         child: RawMaterialButton(
              //           constraints: BoxConstraints(
              //             minWidth: 0,
              //             minHeight: 300,
              //           ),
              //           onPressed: () {
              //             _scrollController.animateTo(0,
              //                 duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
              //           },
              //           elevation: 2.0,
              //           fillColor: Colors.white,
              //           child:
              //               Icon(Icons.keyboard_arrow_left_rounded, color: Colors.black, size: 25),
              //           padding: EdgeInsets.all(5.0),
              //           shape: CircleBorder(),
              //         ),
              //       ),
              //       Positioned(
              //         right: 0,
              //         child: RawMaterialButton(
              //           constraints: BoxConstraints(
              //             minWidth: 0,
              //             minHeight: 300,
              //           ),
              //           onPressed: () {
              //             _scrollController.animateTo(_scrollController.position.maxScrollExtent,
              //                 duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);
              //           },
              //           elevation: 2.0,
              //           fillColor: Colors.white,
              //           child:
              //               Icon(Icons.keyboard_arrow_right_rounded, color: Colors.black, size: 25),
              //           padding: EdgeInsets.all(5.0),
              //           shape: CircleBorder(),
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
