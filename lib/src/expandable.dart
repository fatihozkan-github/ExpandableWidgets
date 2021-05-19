import 'dart:async';
import 'package:flutter/material.dart';

abstract class Expandable extends StatefulWidget {
  /// • Expandable abstract class for general use.
  Expandable({
    this.primaryWidget,
    this.secondaryWidget,
    this.onPressed,
    this.padding,
    this.backgroundColor,
    this.text,
    this.elevation,
    this.maxLines,
    this.shape,
    this.animationDuration,
    this.beforeAnimationDuration,
    this.backgroundImage,
    this.cardMargin,
    this.showArrowIcon,
    this.initiallyExpanded,
    this.textStyle,
    this.hoverOn,
    this.additionalWidget,
    this.centralizePrimaryWidget,
    this.arrowWidget,
    this.centralizeAdditionalWidget,
    this.textWidget,
  });

  /// • The widget that is placed at the non-collapsing part of the expandable.
  final Widget? primaryWidget;

  /// • The widget that [sizeTransition] affects.
  final Widget? secondaryWidget;

  /// • Used for [ExpandableWidget.extended].
  ///
  /// • Brings an arrow widget which is next to it.
  final Widget? additionalWidget;

  /// • Function that is placed top of the widget tree.
  ///
  /// • Animation starts AFTER this function.
  ///
  /// • For the duration between see [beforeAnimationDuration].
  final Function? onPressed;

  /// • Padding that affects inside of the widget.
  final EdgeInsets? padding;

  /// • Needed for [ExpandableWidget.singleTextChild].
  final String? text;

  /// • Determines the maximum line of the [text] when the expandable is collapsed.
  final int? maxLines;

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
  final bool? showArrowIcon;

  /// • Whether this expandable widget will be expanded or collapsed at first.
  final bool? initiallyExpanded;

  /// • [TextStyle] for [text] at [ExpandableWidget.singleTextChild].
  final TextStyle? textStyle;

  /// • Whether expand animation will be triggered when hovered over this widget or not .
  ///
  /// • Added for web.
  final bool? hoverOn;

  /// • Provides better alignment for [primaryWidget].
  final bool? centralizePrimaryWidget;

  /// • Provides better alignment for [additionalWidget].
  final bool? centralizeAdditionalWidget;

  /// TEST
  final Widget? arrowWidget;
  final Widget? textWidget;

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late Animation<double> _sizeAnimation;
  bool _isExpanded = false;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  bool _isRotated = false;
  bool? initiallyExpanded = false;

  static final Animatable<double> _rotationTween = Tween<double>(
    begin: 0.0,
    end: 2,
  );
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

  _toggleRotate() {
    setState(() {
      _isRotated = !_isRotated;
    });
    switch (_rotationAnimation.status) {
      case AnimationStatus.completed:
        _rotationController.reverse();
        break;
      case AnimationStatus.dismissed:
        _rotationController.forward();
        break;
      case AnimationStatus.reverse:
      case AnimationStatus.forward:
        break;
    }
  }

  @override
  initState() {
    super.initState();
    _sizeController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? Duration(milliseconds: 200),
    );

    _rotationController = AnimationController(
        duration: Duration(milliseconds: 200), vsync: this, lowerBound: 0.5);

    final CurvedAnimation curve =
        CurvedAnimation(parent: _sizeController, curve: Curves.fastOutSlowIn);

    _sizeAnimation = _sizeTween.animate(curve);
    _rotationAnimation = _rotationTween.animate(_rotationController);
    // _sizeController.addListener(() {
    //   setState(() {});
    // });
    initiallyExpanded = widget.initiallyExpanded;
  }

  @override
  dispose() {
    _sizeController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  Widget defaultIcon = Icon(
    Icons.keyboard_arrow_up_rounded,
    color: Colors.black,
    size: 25.0,
  );
  Widget holderIcon = Icon(
    Icons.keyboard_arrow_up_rounded,
    color: Colors.transparent,
    size: 25.0,
  );

  ShapeBorder defaultShapeBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)));

  @override
  Widget build(BuildContext context) {
    RotationTransition defaultRotation = RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
      child: widget.arrowWidget ?? defaultIcon,
    );

    if (initiallyExpanded == true) {
      _toggleExpand();
      initiallyExpanded = false;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onHover: widget.hoverOn ?? false
              ? (value) {
                  if (value = true) {
                    _toggleExpand();
                    _toggleRotate();
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
              _toggleRotate();
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: widget.backgroundImage ?? null,
            ),
            child: Card(
              margin: widget.cardMargin,
              elevation: widget.elevation,
              shape: widget.shape ?? defaultShapeBorder,
              color: widget.backgroundColor,
              child: Padding(
                padding: widget.padding ?? EdgeInsets.all(0),
                child: Column(
                  children: [
                    widget.text!.isNotEmpty
                        ? AnimatedCrossFade(
                            duration: widget.animationDuration!,
                            crossFadeState: _isExpanded
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            firstChild:
                                Text(widget.text!, style: widget.textStyle),
                            secondChild: widget.textWidget ??
                                Text(
                                  widget.text!,
                                  style: widget.textStyle,
                                  maxLines: widget.maxLines,
                                  overflow: TextOverflow.ellipsis,
                                ),
                          )
                        : widget.showArrowIcon == true
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (widget.centralizePrimaryWidget!)
                                    holderIcon,
                                  if (widget.centralizePrimaryWidget! &&
                                      widget.arrowWidget != null)
                                    Opacity(
                                      opacity: 0,
                                      child: widget.arrowWidget,
                                    ),
                                  widget.primaryWidget!,
                                  defaultRotation,
                                ],
                              )
                            : widget.additionalWidget != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          widget.primaryWidget!,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              if (widget
                                                  .centralizeAdditionalWidget!)
                                                holderIcon,
                                              widget.additionalWidget!,
                                              RotatedBox(
                                                quarterTurns: 2,
                                                child: RotationTransition(
                                                  turns: Tween(
                                                          begin: 0.0, end: 1.0)
                                                      .animate(
                                                          _rotationController),
                                                  child: widget.arrowWidget ??
                                                      defaultIcon,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : widget.primaryWidget!,
                    SizeTransition(
                      axisAlignment: 0.0,
                      sizeFactor: _sizeAnimation,
                      child: widget.secondaryWidget,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
