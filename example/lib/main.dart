import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExpandableShowcase());

class ExpandableShowcase extends StatefulWidget {
  const ExpandableShowcase({Key? key}) : super(key: key);

  @override
  _ExpandableShowcaseState createState() => _ExpandableShowcaseState();
}

class _ExpandableShowcaseState extends State<ExpandableShowcase> with TickerProviderStateMixin {
  final String data =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

  final Animatable<double> _sizeTween = Tween<double>(begin: 0.0, end: 1.0);
  late AnimationController _animationController;
  late Animation<double> _animation;

  late AnimationController _exteriorController;
  late Animation<double> _exteriorAnimation;

  final Expandable _showcaseExpandable = Expandable(
    clickable: Clickable.firstChildOnly,
    firstChild: const Text('Hello world!'),
    secondChild: Center(child: Column(children: const [Text('Hello'), Text('World!')])),
    backgroundColor: Colors.white,
    showArrowWidget: false,
  );

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
  void dispose() {
    _exteriorController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expandable Widgets',
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text('Expandable Widget Showcase'))),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: [
            const SizedBox(height: 20),

            Expandable(
              firstChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data, maxLines: 3, textAlign: TextAlign.justify),
              ),
              secondChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data, maxLines: 3, textAlign: TextAlign.justify),
              ),
              subChild: Text("asadsa"),
            ),

            const SizedBox(height: 100),

            /// Simple case
            ExpandableText(textWidget: Text(data, maxLines: 3, textAlign: TextAlign.justify)),

            const SizedBox(height: 20),

            /// General use
            ExpandableText(textWidget: Text(data, maxLines: 3), helper: Helper.none),

            const SizedBox(height: 20),

            /// Usage with helperText
            ExpandableText(textWidget: Text(data, maxLines: 3), helper: Helper.text, onPressed: () => print('hi!')),

            const SizedBox(height: 20),

            /// Custom helperText
            ExpandableText(
              textWidget: Text(data, maxLines: 5, textAlign: TextAlign.justify),
              helper: Helper.text,
              backgroundColor: Colors.white,
              helperTextList: const ['...More', '...Less'],
              boxShadow: const [BoxShadow(color: Colors.orange, offset: Offset(2, 2), blurRadius: 4)],
              helperTextStyle: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
              borderRadius: BorderRadius.circular(20.0),
              padding: const EdgeInsets.all(12.0),
            ),

            const SizedBox(height: 20),

            ExpandableText(
              textWidget: Text(data).copyWith(maxLines: 3),
              arrowLocation: ArrowLocation.bottom,
              finalArrowLocation: ArrowLocation.bottom,
            ),

            const SizedBox(height: 20),

            /// General use
            Expandable(firstChild: const Text('Hello world!'), secondChild: Center(child: const Text('Hello world!'))),

            const SizedBox(height: 20),

            /// 2 expandable widgets in a row.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(flex: 2, child: Padding(padding: EdgeInsets.only(right: 8.0), child: _showcaseExpandable)),
                Expanded(child: _showcaseExpandable),
              ],
            ),

            const SizedBox(height: 20),

            Expandable(
              showArrowWidget: true,
              onPressed: () => print('done!'),
              clickable: Clickable.everywhere,
              firstChild: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data, maxLines: 3, overflow: TextOverflow.ellipsis),
                ),
              ),
              secondChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data, maxLines: 3, overflow: TextOverflow.ellipsis),
              ),
            ),

            const SizedBox(height: 30),

            /// Nested Expandable Widgets
            Expandable(
              firstChild: Text('Nested Expandable Widgets'),
              secondChild: Expandable(
                borderRadius: BorderRadius.zero,
                boxShadow: [],
                firstChild: Text('Second Expandable'),
                secondChild: Expandable(
                  borderRadius: BorderRadius.zero,
                  boxShadow: [],
                  firstChild: Text('Third Expandable'),
                  secondChild: Center(child: Text('The End')),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Let's say you want to use Expandable and Flutter's AnimatedIcon at the same time.
                /// Just add the relevant animationController. Expandable will handle the rest!
                Expandable(
                  firstChild: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('Settings', style: TextStyle(fontSize: 18)),
                  ),
                  secondChild: Column(children: [Text('Option 1'), Text('Option 2'), Text('Option 3')]),
                  animationController: _animationController,
                  arrowLocation: ArrowLocation.left,
                  arrowWidget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _animation, size: 16),
                  ),
                ),

                /// Even more, one can combine AnimatedIcon and Expandable's rotation animation!
                ///
                /// Give the same animation to AnimatedIcon and Expandable.
                ///
                /// Do not forget to add relevant animationController to Expandable!
                Expandable(
                  firstChild: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('Settings', style: TextStyle(fontSize: 18)),
                  ),
                  secondChild: Column(children: [Text('Option 1'), Text('Option 2'), Text('Option 3')]),
                  animation: _animation,
                  animationController: _animationController,
                  arrowLocation: ArrowLocation.left,
                  arrowWidget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _animation, size: 16),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            /// Triggering expandable by a button.
            Center(
              child: ElevatedButton(
                child: Text('Trigger animation'),
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
              ),
            ),

            const SizedBox(height: 5),

            Expandable(
              firstChild: Text('Change Icon'),
              secondChild: Center(child: Text('Icon Changed')),
              arrowWidget: _exteriorAnimation.value >= 0.5 ? Icon(Icons.close) : Icon(Icons.keyboard_arrow_up_rounded),
              animationController: _exteriorController,
              clickable: Clickable.none,
            ),

            const SizedBox(height: 40),

            /// List of expandable widgets.
            Column(
              children: [
                for (int i = 0; i < 6; i++)
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Expandable(
                      firstChild: Expanded(
                        child: ListTile(
                          leading: Icon(Icons.book_rounded, color: Colors.blueGrey),
                          title: Text('Book ${i + 1}'),
                          subtitle: Text('Author ${i + 1}'),
                        ),
                      ),
                      secondChild: Center(child: Text('Contents')),
                      onHover: (value) {},
                      animationDuration: Duration(seconds: 1),
                      centralizeFirstChild: false,
                      clickable: Clickable.firstChildOnly,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
