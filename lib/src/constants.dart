import 'package:flutter/material.dart';

enum ArrowLocation {
  top,
  bottom,
  left,
  right,
}

ShapeBorder defaultShapeBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(20)),
);

Widget holderIcon = Icon(
  Icons.keyboard_arrow_up_rounded,
  color: Colors.transparent,
  size: 25.0,
);

Widget defaultIcon = Icon(
  Icons.keyboard_arrow_up_rounded,
  color: Colors.black,
  size: 25.0,
);
