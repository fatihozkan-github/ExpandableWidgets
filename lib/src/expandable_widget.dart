import 'package:expandable_widgets/src/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableWidget extends Expandable {
  /// • Provides an expandable widget for general use.
  ///
  /// • See [Expandable] for more details.
  ExpandableWidget({
    Widget? primaryWidget,
    Widget? secondaryWidget,
    Function? onPressed,
    Color? backGroundColor,
    double? elevation,
    ShapeBorder? shape,
    EdgeInsets? padding,
    Duration? animationDuration,
    Duration? beforeAnimationDuration,
    DecorationImage? backGroundImage,
    EdgeInsets? cardPadding,
    bool? showArrowIcon = false,
    bool? hoverOn,
    Color? arrowColor,
  })  : assert(primaryWidget != null),
        super(
          primaryWidget: primaryWidget,
          secondaryWidget: secondaryWidget,
          onPressed: onPressed,
          backGroundColor: backGroundColor,
          elevation: elevation,
          shape: shape,
          animationDuration: animationDuration,
          beforeAnimationDuration: beforeAnimationDuration,
          padding: padding,
          backGroundImage: backGroundImage,
          cardPadding: cardPadding,
          hoverOn: hoverOn,
          showArrowIcon: showArrowIcon,
          arrowColor: arrowColor,
          text: '',
        );

  /// • Provides an expandable widget for a long text.
  ///
  /// • See [Expandable] for more details.
  ExpandableWidget.singleTextChild({
    String? text,
    Color? backGroundColor,
    double? elevation,
    EdgeInsets? padding,
    int? maxLines = 2,
    ShapeBorder? shape,
    Duration? animationDuration,
    Function? onPressed,
    TextStyle? textStyle,
  })  : assert(text != null),
        super(
          backGroundColor: backGroundColor,
          text: text,
          elevation: elevation,
          padding: padding,
          maxLines: maxLines,
          shape: shape,
          animationDuration: animationDuration,
          onPressed: onPressed,
          textStyle: textStyle,
        );

  ExpandableWidget.extended({
    Widget? primaryWidget,
    Widget? secondaryWidget,
    Widget? additionalWidget,
    Function? onPressed,
    Color? backGroundColor,
    double? elevation,
    ShapeBorder? shape,
    EdgeInsets? padding,
    Duration? animationDuration,
    Duration? beforeAnimationDuration,
    DecorationImage? backGroundImage,
    EdgeInsets? cardPadding,
    bool? hoverOn,
    Color? arrowColor,
    bool? initiallyExpanded,
  })  : assert(primaryWidget != null || secondaryWidget != null),
        super(
          primaryWidget: primaryWidget,
          secondaryWidget: secondaryWidget,
          additionalWidget: additionalWidget,
          onPressed: onPressed,
          backGroundColor: backGroundColor,
          elevation: elevation,
          shape: shape,
          animationDuration: animationDuration,
          beforeAnimationDuration: beforeAnimationDuration,
          padding: padding,
          backGroundImage: backGroundImage,
          cardPadding: cardPadding,
          hoverOn: hoverOn,
          arrowColor: arrowColor,
          initiallyExpanded: initiallyExpanded,
          text: '',
        );
}
