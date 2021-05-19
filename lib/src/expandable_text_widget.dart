import 'package:expandable_widgets/src/expandable_text.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends ExpandableText {
  /// • Provides an expandable widget for a long text.
  ///
  /// • One should add [maxLines] property to [textWidget] otherwise widget will
  /// not be expandable.
  ///
  /// • See [Expandable] for more details.
  ExpandableTextWidget({
    Color? backGroundColor,
    double? elevation = 0.0,
    EdgeInsets? padding = const EdgeInsets.all(5.0),
    ShapeBorder? shape,
    Duration? animationDuration = const Duration(milliseconds: 100),
    Function? onPressed,
    Text? textWidget,
    bool? hoverOn = false,
    DecorationImage? backgroundImage,
  })  : assert(textWidget != null),
        // assert(textWidget?.maxLines != null),
        super(
          backgroundColor: backGroundColor,
          elevation: elevation,
          padding: padding,
          shape: shape,
          animationDuration: animationDuration,
          onPressed: onPressed,
          textWidget: textWidget,
          hoverOn: hoverOn,
          backgroundImage: backgroundImage,
        );
}
