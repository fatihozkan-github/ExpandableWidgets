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
    Color? backgroundColor = Colors.white,
    double? elevation = 0,
    ShapeBorder? shape,
    EdgeInsets? padding,
    Duration? animationDuration = const Duration(milliseconds: 100),
    Duration? beforeAnimationDuration,
    DecorationImage? backgroundImage,
    EdgeInsets? cardMargin = const EdgeInsets.all(5.0),
    bool? showArrowIcon = false,
    bool? hoverOn,
    Widget? arrowWidget,
    bool? centralizePrimaryWidget = false,
  })  : assert(primaryWidget != null),
        super(
          primaryWidget: primaryWidget,
          secondaryWidget: secondaryWidget,
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: shape,
          animationDuration: animationDuration,
          beforeAnimationDuration: beforeAnimationDuration,
          padding: padding,
          backgroundImage: backgroundImage,
          cardMargin: cardMargin,
          hoverOn: hoverOn,
          showArrowIcon: showArrowIcon,
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
          backgroundColor: backGroundColor,
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

  /// • Almost similar to [ExpandableWidget].
  ///
  /// • Takes an [additionalWidget] which behaves like subtitle.
  ///
  /// • [additionalWidget] brings an iconWidget next to it.
  ///
  /// • See [Expandable] for more details.
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
    DecorationImage? backgroundImage,
    EdgeInsets? cardMargin = const EdgeInsets.all(5.0),
    bool? hoverOn,
    bool? initiallyExpanded,
    bool? centralizePrimaryWidget = false,
    bool? centralizeAdditionalWidget = false,
    Widget? arrowWidget,
  })  : assert(primaryWidget != null || secondaryWidget != null),
        super(
          primaryWidget: primaryWidget,
          secondaryWidget: secondaryWidget,
          additionalWidget: additionalWidget,
          onPressed: onPressed,
          backgroundColor: backGroundColor,
          elevation: elevation,
          shape: shape,
          animationDuration: animationDuration,
          beforeAnimationDuration: beforeAnimationDuration,
          padding: padding,
          backgroundImage: backgroundImage,
          cardMargin: cardMargin,
          hoverOn: hoverOn,
          initiallyExpanded: initiallyExpanded,
          text: '',
          centralizePrimaryWidget: centralizePrimaryWidget,
          centralizeAdditionalWidget: centralizeAdditionalWidget,
          arrowWidget: arrowWidget,
        );
}
