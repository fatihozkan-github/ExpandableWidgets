<h1>Expandable Widgets</h1>
A package that provides expandable widgets for Flutter. Written in %100 Dart.

<h1> Examples </h1>
<h2> General use: </h2>

![general_use](https://user-images.githubusercontent.com/69001201/120908143-15d74b80-c670-11eb-81df-b3a5f83a99ac.gif)

Expandable(
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
 isClickable: true,
 padding: EdgeInsets.all(5.0),
),

<h2> For a long text: </h2>

![expandableText](https://user-images.githubusercontent.com/69001201/120908163-4ae39e00-c670-11eb-880d-c82e944931b2.gif)

ExpandableText(
 elevation: 5,
 padding: EdgeInsets.all(10.0),
 animationDuration: Duration(milliseconds: 500),
 textWidget: Text(
   data,
   maxLines: 3,
   overflow: TextOverflow.ellipsis,
 ),
 showArrowIcon: true,
 initiallyExpanded: false,
 hoverOn: false,
 arrowLocation: ArrowLocation.right,
 finalArrowLocation: ArrowLocation.bottom,
),

<h2> Extended example: </h2>

![extended](https://user-images.githubusercontent.com/69001201/120908186-87af9500-c670-11eb-8bef-b5ba7e424a08.gif)

Expandable.extended(
 elevation: 10,
 isClickable: false,
 initiallyExpanded: true,
 centralizePrimaryWidget: true,
 centralizeAdditionalWidget: true,
 primaryWidget: Container(
   height: 30,
   child: Center(child: Text('Important Summary')),
 ),
 secondaryWidget: Container(
   height: 70,
   child: Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: [
         Text('More'),
         Text('Details'),
         Text('About'),
         Text('Something'),
       ],
     ),
   ),
 ),
 arrowWidget: Icon(
   Icons.keyboard_arrow_up_rounded,
   color: Colors.blueGrey,
   size: 20.0,
 ),
 additionalWidget: Text('Show me'),
 arrowLocation: ArrowLocation.left,
),
            
<h2> Example with background image: </h2>

Expandable(
 primaryWidget: Text('centralizePrimaryWidget: true'),
 secondaryWidget: Row(
   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
   mainAxisSize: MainAxisSize.max,
   children: [
     Container(width: 30, height: 10, color: Colors.black),
     Container(width: 30, height: 10, color: Colors.black),
     Container(width: 30, height: 10, color: Colors.black),
   ],
 ),
 isClickable: false,
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

<h2> Same example with background image but without centralizePrimaryWidget: </h2>

![centralized](https://user-images.githubusercontent.com/69001201/120908212-a44bcd00-c670-11eb-8566-1c022fb05060.gif)

Expandable(
 primaryWidget: Text('centralizePrimaryWidget: false'),
 secondaryWidget: Row(
   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
   mainAxisSize: MainAxisSize.max,
   children: [
     Container(width: 30, height: 10, color: Colors.black),
     Container(width: 30, height: 10, color: Colors.black),
     Container(width: 30, height: 10, color: Colors.black),
   ],
 ),
 isClickable: false,
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
