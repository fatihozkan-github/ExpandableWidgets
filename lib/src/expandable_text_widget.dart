import 'package:expandable_widgets/src/expandable_text.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends ExpandableText {
  /// • Provides an expandable widget for a long text.
  ///
  /// • See [Expandable] for more details.
  ExpandableTextWidget.singleTextChild({
    String? text,
    Color? backGroundColor,
    double? elevation = 0,
    EdgeInsets? padding,
    int? maxLines = 2,
    ShapeBorder? shape,
    Duration? animationDuration = const Duration(milliseconds: 100),
    Function? onPressed,
    TextStyle? textStyle,
  })  : assert(text != null),
        super(
        backgroundColor: backGroundColor,
        text: text,
        elevation: elevation,
        padding: padding,
        maxLines: maxLines,
        shape: shape,
        animationDuration: animationDuration,
        onPressed: onPressed,
        textStyle: textStyle,
      );

}