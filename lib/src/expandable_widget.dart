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
    Color? backGroundColor = Colors.white,
    double? elevation = 0,
    ShapeBorder? shape,
    EdgeInsets? padding,
    Duration? animationDuration = const Duration(milliseconds: 100),
    Duration? beforeAnimationDuration,
    DecorationImage? backGroundImage,
    EdgeInsets? cardMargin = const EdgeInsets.all(5.0),
    bool? showArrowIcon = false,
    bool? hoverOn,
    Color? arrowColor,
    Widget? arrowWidget,
    bool? centralizePrimaryWidget = false,
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
          cardMargin: cardMargin,
          hoverOn: hoverOn,
          showArrowIcon: showArrowIcon,
          arrowColor: arrowColor,
          arrowWidget: arrowWidget,
          text: '',
          centralizePrimaryWidget: centralizePrimaryWidget,
        );

  /// • Provides an expandable widget for a long text.
  ///
  /// • See [Expandable] for more details.
  ExpandableWidget.singleTextChild({
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
          backGroundColor: backGroundColor,
          text: text,
          elevation: elevation,
          padding: padding,
          maxLines: maxLines,
          shape: shape,
          animationDuration: animationDuration,
          onPressed: onPressed,
          textStyle: textStyle,
          centralizePrimaryWidget: false,
        );

  ExpandableWidget.extended({
    Widget? primaryWidget,
    Widget? secondaryWidget,
    Widget? additionalWidget,
    Function? onPressed,
    Color? backGroundColor = Colors.white,
    double? elevation = 0,
    ShapeBorder? shape,
    EdgeInsets? padding,
    Duration? animationDuration = const Duration(milliseconds: 100),
    Duration? beforeAnimationDuration,
    DecorationImage? backGroundImage,
    EdgeInsets? cardMargin = const EdgeInsets.all(5.0),
    bool? hoverOn,
    Color? arrowColor,
    bool? initiallyExpanded,
    bool? centralizePrimaryWidget = false,
    bool? centralizeAdditionalWidget = false,
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
          cardMargin: cardMargin,
          hoverOn: hoverOn,
          arrowColor: arrowColor,
          initiallyExpanded: initiallyExpanded,
          text: '',
          centralizePrimaryWidget: centralizePrimaryWidget,
          centralizeAdditionalWidget: centralizeAdditionalWidget,
        );
}
