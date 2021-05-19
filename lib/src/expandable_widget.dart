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
    EdgeInsets? padding = const EdgeInsets.all(5.0),
    Duration? animationDuration = const Duration(milliseconds: 100),
    Duration? beforeAnimationDuration,
    DecorationImage? backgroundImage,
    bool? showArrowIcon = false,
    bool? hoverOn,
    Widget? arrowWidget,
    bool? centralizePrimaryWidget = false,
    bool? isClickable,
  })  : assert(primaryWidget != null),
        assert((isClickable == false && arrowWidget != null) ||
            (isClickable == true)),
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
          hoverOn: hoverOn,
          showArrowIcon: showArrowIcon,
          arrowWidget: arrowWidget,
          centralizePrimaryWidget: centralizePrimaryWidget,
          isClickable: isClickable,
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
    EdgeInsets? padding = const EdgeInsets.all(5.0),
    Duration? animationDuration = const Duration(milliseconds: 100),
    Duration? beforeAnimationDuration,
    DecorationImage? backgroundImage,
    bool? hoverOn,
    bool? initiallyExpanded,
    bool? centralizePrimaryWidget = false,
    bool? centralizeAdditionalWidget = false,
    Widget? arrowWidget,
    bool? isClickable,
  })  : assert(primaryWidget != null || secondaryWidget != null),
        assert((isClickable == false && arrowWidget != null) ||
            (isClickable == true)),
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
          hoverOn: hoverOn,
          initiallyExpanded: initiallyExpanded,
          centralizePrimaryWidget: centralizePrimaryWidget,
          centralizeAdditionalWidget: centralizeAdditionalWidget,
          arrowWidget: arrowWidget,
          isClickable: isClickable,
        );
}
