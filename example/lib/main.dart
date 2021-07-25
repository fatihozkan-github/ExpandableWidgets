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

  static final Animatable<double> _sizeTween = Tween<double>(begin: 00, end: 1.0);

  late AnimationController _animationController;
  late Animation<double> _animation;

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
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 20,
            spacing: 30,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(height: 10),

              /// General use
              Expandable(
                firstChild: Container(child: Center(child: Text('Hello world!'))),
                secondChild: Container(
                  child: Center(
                    child: Column(
                      children: [Text('Hello'), Text('World!')],
                    ),
                  ),
                ),
                backgroundColor: Colors.grey.withOpacity(0.4),
                showArrowIcon: true,
                centralizePrimaryWidget: true,
                isEverywhereClickable: false,
                padding: EdgeInsets.all(5.0),
              ),
              TextButton(
                  child: Text('Open the valve'),
                  onPressed: () {
                    _animationController.forward();
                    if (_animationController.isCompleted) _animationController.reverse();
                  }),

              ///
              Expandable(
                firstChild: RotationTransition(
                  turns: _animation,
                  child: Icon(Icons.add_circle_outline_rounded, color: Colors.red),
                ),
                secondChild: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
                ),
                showArrowIcon: false,
                centralizePrimaryWidget: true,
                isClickable: false,
                isEverywhereClickable: false,
                padding: EdgeInsets.all(5.0),
                animation: _animation,
                animationController: _animationController,
              ),

              /// For long texts
              ExpandableText(
                elevation: 5,
                padding: EdgeInsets.all(10.0),
                animationDuration: Duration(milliseconds: 500),
                textWidget: Text(data, maxLines: 3, overflow: TextOverflow.ellipsis),
                showArrowIcon: false,
                showHelperText: true,
                initiallyExpanded: false,
                hoverOn: false,
                arrowLocation: ArrowLocation.right,
                finalArrowLocation: ArrowLocation.bottom,
              ),

              /// Extended example
              Expandable.extended(
                centralizeAdditionalWidget: true,
                arrowLocation: ArrowLocation.left,
                firstChild: Text('Team'),
                additionalChild: Text('Show Roaster'),
                secondChild: Container(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < 5; i++)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              Icon(Icons.person_outline_rounded),
                              Text('Player ${i + 1}'),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              /// Example with background image
              Expandable(
                firstChild: Text('centralizePrimaryWidget: true'),
                secondChild: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(width: 30, height: 10, color: Colors.black),
                    Container(width: 30, height: 10, color: Colors.black),
                    Container(width: 30, height: 10, color: Colors.black),
                  ],
                ),
                isClickable: true,
                showArrowIcon: true,
                backgroundImage: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  repeat: ImageRepeat.repeatX,
                ),
                backgroundColor: Colors.grey.withOpacity(0.3),
                arrowWidget: Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.blueGrey,
                  size: 20.0,
                ),
                animationDuration: Duration(seconds: 1),
                centralizePrimaryWidget: true,
              ),

              /// Example without centralizePrimaryWidget
              Expandable(
                firstChild: Text('centralizePrimaryWidget: false'),
                secondChild: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(width: 30, height: 10, color: Colors.black),
                    Container(width: 30, height: 10, color: Colors.black),
                    Container(width: 30, height: 10, color: Colors.black),
                  ],
                ),
                isClickable: true,
                showArrowIcon: true,
                backgroundImage: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  repeat: ImageRepeat.repeatX,
                ),
                backgroundColor: Colors.grey.withOpacity(0.3),
                arrowWidget: Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.blueGrey,
                  size: 20.0,
                ),
                animationDuration: Duration(seconds: 1),
                centralizePrimaryWidget: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
