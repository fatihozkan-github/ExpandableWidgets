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

  late AnimationController _exteriorController;
  late Animation<double> _exteriorAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    CurvedAnimation curve = CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation = _sizeTween.animate(curve);
    _exteriorController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    CurvedAnimation curve2 = CurvedAnimation(parent: _exteriorController, curve: Curves.linear);
    _exteriorAnimation = _sizeTween.animate(curve2);
    _exteriorAnimation.addListener(() => setState(() {}));
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
              ExpandableText(textWidget: Text(data, maxLines: 3, softWrap: true), showHelperText: true, elevation: 5),
              SizedBox(height: 5),
              ExpandableText(
                textWidget: Text(data, maxLines: 3),
                elevation: 5,
                showArrowWidget: true,
                arrowLocation: ArrowLocation.top,
                finalArrowLocation: ArrowLocation.right,
              ),
              SizedBox(height: 10),
              Expandable(
                firstChild: Expanded(child: Text(data, maxLines: 3, overflow: TextOverflow.ellipsis)),
                showArrowWidget: true,
                wrapContent: false,
                secondChild: Text(data, maxLines: 3, overflow: TextOverflow.ellipsis),
                clickable: Clickable.everywhere,
                onPressed: () => print('done'),
              ),
              SizedBox(height: 30),
              // Container(
              //   constraints: BoxConstraints(
              //     maxWidth: 500,
              //     minWidth: 400,
              //   ),
              //   child: Row(
              //     children: [
              //       ExpandableText(
              //         textWidget: Text(data, maxLines: 3),
              //         elevation: 5,
              //         showArrowWidget: true,
              //         arrowLocation: ArrowLocation.left,
              //         finalArrowLocation: ArrowLocation.right,
              //       ),
              //       ExpandableText(
              //         textWidget: Text(data, maxLines: 3),
              //         elevation: 5,
              //         showArrowWidget: true,
              //         arrowLocation: ArrowLocation.left,
              //         finalArrowLocation: ArrowLocation.right,
              //       ),
              //     ],
              //   ),
              // ),

              ///
              SizedBox(height: 10),

              /// General use
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 30),
                child: Expandable(
                  clickable: Clickable.everywhere,
                  firstChild: Container(child: Center(child: Text('Hello world!'))),
                  secondChild: Center(child: Column(children: [Text('Hello'), Text('World!')])),
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  padding: EdgeInsets.all(8.0),
                  showArrowWidget: false,
                ),
              ),
              SizedBox(height: 10),

              /// Nested Expandable Widgets
              Padding(
                padding: EdgeInsets.all(1.0),
                child: Expandable(
                  padding: EdgeInsets.zero,
                  firstChild: Text('Nested Expandable Widgets'),
                  elevation: 5,
                  centralizeFirstChild: false,
                  secondChild: Expandable(
                    padding: EdgeInsets.zero,
                    firstChild: Text('Second Expandable'),
                    secondChild: Expandable(
                      padding: EdgeInsets.zero,
                      firstChild: Text('Third Expandable'),
                      secondChild: Text('The End'),
                    ),
                  ),
                ),
              ),

              ///
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Expandable(
                        clickable: Clickable.firstChildOnly,
                        firstChild: Container(child: Center(child: Text('Hello world!'))),
                        secondChild: Center(child: Column(children: [Text('Hello'), Text('World!')])),
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        padding: EdgeInsets.all(8.0),
                        // margin: EdgeInsets.all(8.0),
                        showArrowWidget: false,
                        wrapContent: false,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Expandable(
                        clickable: Clickable.firstChildOnly,
                        firstChild: Container(child: Center(child: Text('Hello world!'))),
                        secondChild: Center(child: Column(children: [Text('Hello'), Text('World!')])),
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        padding: EdgeInsets.all(8.0),
                        // margin: EdgeInsets.all(8.0),
                        showArrowWidget: false,
                        wrapContent: false,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              Row(
                children: [
                  /// Let's say you want to use Expandable and Flutter's AnimatedIcon at
                  /// the same time. No problem, Expandable gets you covered!
                  ///
                  /// Do not forget to add the relevant animationController to Expandable!
                  SizedBox(width: 5),
                  Expandable(
                    firstChild: Text('Settings', style: TextStyle(fontSize: 18)),
                    secondChild: Column(children: [Text('Option 1'), Text('Option 2'), Text('Option 3')]),
                    arrowLocation: ArrowLocation.right,
                    arrowWidget: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _animation, size: 18),
                    animationController: _animationController,
                    centralizeFirstChild: false,
                    padding: EdgeInsets.all(4.0),
                    elevation: 5,
                  ),
                  SizedBox(width: 5),

                  /// Even more, one can combine AnimatedIcon and Expandable's rotation animation!
                  ///
                  /// Just give the same animation to AnimatedIcon and Expandable.
                  ///
                  /// Do not forget to add relevant animationController to Expandable!
                  Expandable(
                    elevation: 5,
                    firstChild: Text('Settings', style: TextStyle(fontSize: 18)),
                    secondChild: Column(children: [Text('Option 1'), Text('Option 2'), Text('Option 3')]),
                    arrowLocation: ArrowLocation.right,
                    arrowWidget: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _animation, size: 18),
                    animation: _animation,
                    animationController: _animationController,
                    centralizeFirstChild: false,
                    padding: EdgeInsets.all(4.0),
                  ),
                ],
              ),
              SizedBox(height: 40),

              /// Triggering expandable by a button.
              Row(
                children: [
                  OutlinedButton(
                      onPressed: () {
                        switch (_exteriorAnimation.status) {
                          case AnimationStatus.completed:
                            _exteriorController.reverse();
                            break;
                          case AnimationStatus.dismissed:
                            _exteriorController.forward();
                            break;
                          case AnimationStatus.reverse:
                          case AnimationStatus.forward:
                            break;
                        }
                      },
                      child: Text('Trigger animation')),
                ],
              ),
              Expandable(
                firstChild: Text('Change Icon'),
                secondChild: Text('Icon Changed'),
                arrowWidget: _exteriorAnimation.value >= 0.5 ? Icon(Icons.close) : Icon(Icons.keyboard_arrow_up_rounded),
                animationController: _exteriorController,
                clickable: Clickable.none,
                centralizeFirstChild: false,
              ),

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
                                Icon(Icons.book_rounded, color: Colors.blueGrey, size: 20),
                                SizedBox(width: 5),
                                Text('Book ${i + 1}'),
                              ],
                            )),
                        secondChild: Center(child: Text('Contents')),
                        clickable: Clickable.none,
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        borderRadius: BorderRadius.circular(5.0),
                        elevation: 5,
                        arrowLocation: ArrowLocation.right,
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
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            ],
          ),
        ),
      ),
    );
  }
}
