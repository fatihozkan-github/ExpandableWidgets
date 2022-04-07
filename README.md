<h1>Expandable Widgets</h1>
A package provides expandable widgets for Flutter, written in 100% Dart.

<h2> Abstract </h2>
<h3>Why?</h3>

<h4>Fast</h4>
There are various ways of getting expandable behaviour in Flutter. This package provides boilerplate code and reduces production time.

<h4>Inclusive</h4>
Expandable Widgets offers a variety of uses. Check [More Usecases](#more-usescases)

<h4>Easy</h4>
<p>You can get the basic expandable widgets by writing one single line of code.</p>

<h2>Examples</h2>
<h4>General Use:</h4>
<p>You can simply use Expandable with 2 required parameters.</p>
<p> For more features see (More Usecases)[#more-usescases] </p>

![general_use](https://user-images.githubusercontent.com/69001201/120908143-15d74b80-c670-11eb-81df-b3a5f83a99ac.gif)

```
Expandable(
  firstChild: const Text('Hello world!'),
  secondChild: Center(child: const Text('Hello world!')),
),
```

<h4>Extended Example:</h4>
<p>If you add subChild argument you will get an expandable with subtitle. See 1.0.2 or older versions for previous extended expandables.</p>

![extended](https://user-images.githubusercontent.com/69001201/120908186-87af9500-c670-11eb-8bef-b5ba7e424a08.gif)

```
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
For more features see [More Usecases](#more-usescases)

![expandableText](https://user-images.githubusercontent.com/69001201/120908163-4ae39e00-c670-11eb-880d-c82e944931b2.gif)

```
ExpandableText(textWidget: Text(data, maxLines: 3),
```

<h2> More Usecases </h2>
<h3>Expandable</h3>
<h4> Nested Expandable Widgets </h4>

```
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

```
ExpandableText(
  textWidget: Text(data).copyWith(maxLines: 3),
  arrowLocation: ArrowLocation.bottom,
  finalArrowLocation: ArrowLocation.bottom,
),
```

<p> You can use helper text </p>

```
ExpandableText(textWidget: Text(data, maxLines: 3), helper: Helper.text),
```

<p> Customized ExpandableText </p>

```
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

<p> Or you can remove the helper </p>

```
ExpandableText(textWidget: Text(data, maxLines: 3), helper: Helper.none),
```
