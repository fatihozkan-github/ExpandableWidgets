<h1>Expandable Widgets</h1>
A package provides expandable widgets for Flutter, written in 100% Dart.

<h2> Abstract </h2>
<h3>Why?</h3>

<h4>Fast</h4>
There are various ways of getting expandable behaviour in Flutter. This package provides boilerplate code and reduces production time.

<h4>Inclusive</h4>

Expandable Widgets offers a variety of uses. Check [More Usecases](#-more-usecases-)

<h4>Easy</h4>
<p>You can get the basic expandable widgets by writing one single line of code.</p>

<h2>Examples</h2>
<h4>General Use:</h4>
<p>You can simply use Expandable with 2 required parameters.</p>

<img src="https://user-images.githubusercontent.com/69001201/162217368-1d600882-5fea-4df0-bef5-dab4366b8751.gif" align="right" width="450px">

```dart
Expandable(
  firstChild: const Text('Hello world!'),
  secondChild: Center(child: const Text('Hello world!')),
),
```

<h4>Extended Example:</h4>
<p>If you add subChild argument you will get an expandable with subtitle. See 1.0.2 or older versions for previous extended expandables.</p>

<img src="https://user-images.githubusercontent.com/69001201/162217577-fe50bb92-3768-491e-91da-98c116a14331.gif" align="right" width="450px">

```dart
Expandable(
  firstChild: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(data, maxLines: 3, textAlign: TextAlign.justify),
  ),
  secondChild: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(data, maxLines: 3, textAlign: TextAlign.justify),
  ),
  subChild: Text("Show Details"),
),
```



<h2>Expandable Text: </h2>
<p> You can use ExpandableText by giving the required parameter, textWidget. ExpandableText will handle the rest. </p>
<img src="https://user-images.githubusercontent.com/69001201/162217681-ac9850c9-113b-49d7-9e3f-df9ef03bf7d8.gif" align="right" width="450px">

```dart
ExpandableText(textWidget: Text(data, maxLines: 3),
```

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

<h2> More Usecases </h2>
<h3>Expandable</h3>

<img src="https://user-images.githubusercontent.com/69001201/162217789-3140fcd3-08cf-439f-9843-7771c9d5ed64.gif" width="450px" align="right">

<p> Let's say you want to use Expandable and Flutter's AnimatedIcon at the same time.</p>
<p> Just add the relevant animationController. Expandable will handle the rest!</p>
<br/>
<br/>
<br/>
  
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
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
```

<p> Even more, one can combine AnimatedIcon and Expandable's rotation animation. </p>
<p> Give the same animation to AnimatedIcon and Expandable and finally,  do not forget to add relevant animationController to Expandable. </p>

```dart
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
```

<h4> Nested Expandable Widgets </h4>
<img src="https://user-images.githubusercontent.com/69001201/162217836-1e85151d-ea49-42fe-ac08-ec2b6bdb5d8d.gif" width="450px" align="right">

```dart
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
```

<h3> ExpandableText </h3>

<p> You can change the location of the arrow </p>

<img src="https://user-images.githubusercontent.com/69001201/162217874-ec3e641b-adc7-4df4-b6eb-24dbbdccd683.gif" width="450px" align="right">

```dart
ExpandableText(
  textWidget: Text(data).copyWith(maxLines: 3),
  arrowLocation: ArrowLocation.bottom,
  finalArrowLocation: ArrowLocation.bottom,
),
```
<br/><br/><br/><br/><br/><br/><br/><br/><br/>
  
<p> You can use helper text </p>

<img src="https://user-images.githubusercontent.com/69001201/162217908-6fdd80f3-4342-4ca6-af2c-91edd1a841ef.gif" width="450px" align="right">

```dart
ExpandableText(textWidget: Text(data, maxLines: 3), helper: Helper.text),
```
  
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

<p> Customized ExpandableText with helper text </p>

<img src="https://user-images.githubusercontent.com/69001201/162217925-8d0bd92b-ec74-4695-a4e9-9716f9538bc0.gif" width="450px" align="right">

```dart
ExpandableText(
  textWidget: Text(data, maxLines: 5, textAlign: TextAlign.justify),
  backgroundColor: Colors.white,
  helper: Helper.text,
  helperTextList: const ['...More', '...Less'],
  helperTextStyle: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
  boxShadow: const [BoxShadow(color: Colors.orange, offset: Offset(2, 2), blurRadius: 4)],
  borderRadius: BorderRadius.circular(20.0),
  padding: const EdgeInsets.all(12.0),
  onPressed: () => print('hi!'),
),
```
  
<br/><br/><br/><br/><br/><br/>

<p> Or you can remove the helper </p>

<img src="https://user-images.githubusercontent.com/69001201/162217945-ca8c41ba-9ee5-4c8c-a041-21597eb863d1.gif" width="450px" align="right">

```dart
ExpandableText(textWidget: Text(data, maxLines: 3), helper: Helper.none),
```

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

For more info please see [example](https://github.com/fatihozkan-github/ExpandableWidgets/blob/master/example/lib/main.dart).
