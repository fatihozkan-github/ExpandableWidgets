import 'dart:async';

import 'package:flutter/material.dart';

abstract class ExpandableText extends StatefulWidget {
  ExpandableText({
    this.textWidget,
    this.onPressed,
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.animationDuration,
    this.beforeAnimationDuration,
    this.backgroundImage,
    this.cardMargin,
    this.initiallyExpanded,
    this.hoverOn,
    this.arrowWidget,

    /// Test
    // this.showArrowIcon,
  });

  /// [Text] widget for [ExpandableTextWidget].
  final Text? textWidget;

  /// • Function that is placed top of the widget tree.
  ///
  /// • Animation starts AFTER this function.
  ///
  /// • For the duration between see [beforeAnimationDuration].
  final Function? onPressed;

  /// • Padding that affects inside of the widget.
  final EdgeInsets? padding;

  /// • Background color of the expandable.
  final Color? backgroundColor;

  /// • Elevation of the expandable widget.
  final double? elevation;

  /// • Shape of the component.
  ///
  /// • Notice that [shape] is a [ShapeBorder], not [BoxShape].
  final ShapeBorder? shape;

  /// • Duration for expand & rotate animations.
  final Duration? animationDuration;

  /// • Duration between [onPressed] & expand animation.
  final Duration? beforeAnimationDuration;

  /// • Background image of the expandable.
  final DecorationImage? backgroundImage;

  /// • Added for taking more control over the widget.
  ///
  /// • Recommended to set 0 if it is used with [backgroundImage].
  final EdgeInsets? cardMargin;

  /// • Icon that changes its direction with respect to expand animation.
  final bool? showArrowIcon = false;

  /// • Whether this expandable widget will be expanded or collapsed at first.
  final bool? initiallyExpanded;

  /// • Whether expand animation will be triggered when hovered over this widget or not .
  ///
  /// • Added for web.
  final bool? hoverOn;

  /// TEST
  final Widget? arrowWidget;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late Animation<double> _sizeAnimation;
  bool _isExpanded = false;
  // bool _isRotated = false;
  bool? initiallyExpanded = false;

  static final Animatable<double> _sizeTween = Tween<double>(
    begin: 00,
    end: 1.0,
  );

  _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    switch (_sizeAnimation.status) {
      case AnimationStatus.completed:
        _sizeController.reverse();
        break;
      case AnimationStatus.dismissed:
        _sizeController.forward();
        break;
      case AnimationStatus.reverse:
      case AnimationStatus.forward:
        break;
    }
  }

  // _toggleRotate() {
  //   setState(() {
  //     _isRotated = !_isRotated;
  //   });
  //   switch (_rotationAnimation.status) {
  //     case AnimationStatus.completed:
  //       _rotationController.reverse();
  //       break;
  //     case AnimationStatus.dismissed:
  //       _rotationController.forward();
  //       break;
  //     case AnimationStatus.reverse:
  //     case AnimationStatus.forward:
  //       break;
  //   }
  // }

  ShapeBorder defaultShapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  );

  @override
  initState() {
    super.initState();
    _sizeController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? Duration(milliseconds: 200),
    );

    // _rotationController = AnimationController(
    //     duration: Duration(milliseconds: 200), vsync: this, lowerBound: 0.5);

    final CurvedAnimation curve =
        CurvedAnimation(parent: _sizeController, curve: Curves.fastOutSlowIn);

    _sizeAnimation = _sizeTween.animate(curve);
    // _rotationAnimation = _rotationTween.animate(_rotationController);
    initiallyExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    if (initiallyExpanded == true) {
      _toggleExpand();
      initiallyExpanded = false;
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: widget.backgroundColor ?? Colors.white,
        elevation: widget.elevation ?? 0,
        shape: widget.shape ?? defaultShapeBorder,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onHover: widget.hoverOn ?? false
              ? (value) {
                  if (value = true) {
                    _toggleExpand();
                    // _toggleRotate();
                  } else if (value = false) {
                    _isExpanded = true;
                  }
                }
              : null,
          onTap: () {
            if (widget.onPressed.toString() != 'null') {
              widget.onPressed!();
            }

            Timer(widget.beforeAnimationDuration ?? Duration(milliseconds: 20),
                () {
              _toggleExpand();
              // _toggleRotate();
            });
          },
          child: Container(
            decoration: BoxDecoration(image: widget.backgroundImage ?? null),
            padding: widget.padding ?? EdgeInsets.all(0),
            child: widget.showArrowIcon!
                ? Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      AnimatedCrossFade(
                        duration: widget.animationDuration!,
                        crossFadeState: _isExpanded
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: Text(
                          widget.textWidget!.data!,
                          style: widget.textWidget!.style ??
                              TextStyle(color: Colors.black),
                        ),
                        secondChild: Row(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    46 -
                                    widget.padding!.right,
                                child: widget.textWidget!),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                              size: 25.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : AnimatedCrossFade(
                    duration: widget.animationDuration!,
                    crossFadeState: _isExpanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Text(
                      widget.textWidget!.data!,
                      style: widget.textWidget!.style ??
                          TextStyle(color: Colors.black),
                    ),
                    secondChild: widget.textWidget!,
                  ),
          ),
        ),
      ),
    );
  }
}
