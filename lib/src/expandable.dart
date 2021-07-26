import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:expandable_widgets/src/expandable_widget.dart';
import 'package:flutter/material.dart';

class Expandable extends ExpandableWidget {
  /// • Provides an expandable widget for general use.
  ///
  /// • See [ExpandableWidget] for more details.
  Expandable({
    Widget? firstChild,
    Widget? secondChild,
    Function? onPressed,
    Color? backgroundColor = Colors.white,
    double? elevation = 0,
    ShapeBorder? shape,
    EdgeInsets? padding = const EdgeInsets.all(20.0),
    Duration? animationDuration = const Duration(milliseconds: 100),
    Duration? beforeAnimationDuration,
    DecorationImage? backgroundImage,
    bool? showArrowWidget = false,
    bool? hoverOn,
    Widget? arrowWidget,
    bool? centralizePrimaryWidget = false,
    bool? isEverywhereClickable = false,
    bool? isClickable = true,
    ArrowLocation? arrowLocation = ArrowLocation.right,
    Function? onLongPress,
    Animation<double>? animation,
    AnimationController? animationController,
  })  : assert(firstChild != null),
        assert(arrowLocation != ArrowLocation.bottom && arrowLocation != ArrowLocation.top),
        super(
          firstChild: firstChild,
          secondChild: secondChild,
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: shape,
          animationDuration: animationDuration,
          beforeAnimationDuration: beforeAnimationDuration,
          padding: padding,
          backgroundImage: backgroundImage,
          hoverOn: hoverOn,
          showArrowWidget: showArrowWidget,
          arrowWidget: arrowWidget,
          centralizeFirstChild: centralizePrimaryWidget,
          isEverywhereClickable: isEverywhereClickable,
          arrowLocation: arrowLocation,
          onLongPress: onLongPress,
          isClickable: isClickable,
          animation: animation,
          animationController: animationController,
          // rotationController: rotationAnimationController,
          // rotationAnimation: rotationAnimation,
        );

  /// • Almost similar to [Expandable].
  ///
  /// • Takes an [additionalWidget] which behaves like subtitle.
  ///
  /// • [additionalWidget] brings an iconWidget next to it.
  ///
  /// • See [ExpandableWidget] for more details.
  Expandable.extended({
    Widget? firstChild,
    Widget? secondChild,
    Widget? additionalChild,
    Function? onPressed,
    Color? backGroundColor = Colors.white,
    double? elevation = 0,
    ShapeBorder? shape,
    EdgeInsets? padding = const EdgeInsets.all(20.0),
    Duration? animationDuration = const Duration(milliseconds: 100),
    Duration? beforeAnimationDuration,
    DecorationImage? backgroundImage,
    bool? hoverOn,
    bool? initiallyExpanded,
    bool? centralizePrimaryWidget = false,
    bool? centralizeAdditionalWidget = false,
    Widget? arrowWidget,
    bool? isEverywhereClickable = false,
    bool? isClickable = true,
    ArrowLocation? arrowLocation = ArrowLocation.right,
    Function? onLongPress,
    Animation<double>? animation,
    AnimationController? animationController,
  })  : assert(additionalChild != null,
            "additionalChild cannot be empty. Calling Expandable.extended is pointless without additionalChild."),
        assert(arrowLocation != ArrowLocation.bottom && arrowLocation != ArrowLocation.top),
        super(
          firstChild: firstChild,
          secondChild: secondChild,
          additionalChild: additionalChild,
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
          centralizeFirstChild: centralizePrimaryWidget,
          centralizeAdditionalChild: centralizeAdditionalWidget,
          arrowWidget: arrowWidget,
          isClickable: isClickable,
          isEverywhereClickable: isEverywhereClickable,
          arrowLocation: arrowLocation,
          onLongPress: onLongPress,
          animation: animation,
          animationController: animationController,
        );
}
