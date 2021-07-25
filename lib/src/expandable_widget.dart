import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'constants.dart';

abstract class ExpandableWidget extends StatefulWidget {
  /// • Expandable abstract class for general use.
  ExpandableWidget({
    this.firstChild,
    this.secondChild,
    this.additionalChild,
    this.onPressed,
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.animationDuration,
    this.beforeAnimationDuration,
    this.backgroundImage,
    this.showArrowWidget,
    this.initiallyExpanded,
    this.hoverOn,
    this.centralizeFirstChild,
    this.arrowWidget,
    this.centralizeAdditionalChild,
    this.isClickable,
    this.arrowLocation,

    /// TODO - TEST
    this.onLongPress,
    this.textDirection,
    this.isEverywhereClickable,
    this.animation,
    this.animationController,
  });

  /// • The widget that is placed at the non-collapsing part of the expandable.
  final Widget? firstChild;

  /// • The widget that [sizeTransition] affects.
  final Widget? secondChild;

  /// • Used for [ExpandableWidget.extended].
  ///
  /// • Brings an arrow widget which is next to it.
  ///
  /// • Notice that one will not be able to use [showArrowWidget] with [additionalChild].
  final Widget? additionalChild;

  /// • Function that is placed top of the widget tree.
  ///
  /// • Animation starts AFTER this function.
  ///
  /// • For the duration between see [beforeAnimationDuration].
  final Function? onPressed;

  /// • Padding of the expandable.
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

  /// • Whether [arrowWidget] will be shown or not.
  final bool? showArrowWidget;

  /// • Whether this expandable widget will be expanded or collapsed at first.
  final bool? initiallyExpanded;

  /// • Whether expand animation will be triggered when hovered over this widget or not.
  ///
  /// • Added for web.
  final bool? hoverOn;

  /// • Provides better alignment for [firstChild].
  final bool? centralizeFirstChild;

  /// • Provides better alignment for [additionalChild].
  final bool? centralizeAdditionalChild;

  /// • Decide whether this widget will be clickable everywhere or not.
  final bool? isClickable;

  /// • Custom widget that changes its direction with respect to expand animation.
  final Widget? arrowWidget;

  /// • Place of the arrow widget.
  final ArrowLocation? arrowLocation;

  /// • onLongPress
  final Function? onLongPress;

  /// • [TextDirection] of the expandable.
  ///
  /// • Default value is [TextDirection.ltr].
  ///
  /// • See [ExpandableWidget] & [TextDirection] for more info.
  final TextDirection? textDirection;

  /// • Decide whether the expandable will be clickable at everywhere or only at the [primaryChild].
  final bool? isEverywhereClickable;

  /// • Custom animation for size & rotation animations.
  final Animation<double>? animation;

  /// • Controller for [animation].
  ///
  /// • Useful when one want to interact with the expandable with an external button etc.
  final AnimationController? animationController;

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> with TickerProviderStateMixin {
  late AnimationController _generalController;
  late Animation<double> _generalAnimation;
  bool _isExpanded = false;
  bool? initiallyExpanded = false;
  Widget? defaultRotation;
  bool? isClickable;

  final Animatable<double> _sizeTween = Tween<double>(begin: 00, end: 1.0);

  _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (initiallyExpanded == true) initiallyExpanded = false;
    });
    switch (_generalAnimation.status) {
      case AnimationStatus.completed:
        _generalController.reverse();
        break;
      case AnimationStatus.dismissed:
        _generalController.forward();
        break;
      case AnimationStatus.reverse:
      case AnimationStatus.forward:
        break;
    }
  }

  @override
  initState() {
    isClickable = widget.isClickable;
    initiallyExpanded = widget.initiallyExpanded;
    _generalController = widget.animationController ??
        AnimationController(
            vsync: this, duration: widget.animationDuration ?? Duration(milliseconds: 200));

    CurvedAnimation curve =
        CurvedAnimation(parent: _generalController, curve: Curves.fastOutSlowIn);

    _generalAnimation = widget.animation ?? _sizeTween.animate(curve);

    defaultRotation = RotationTransition(
      turns: Tween(begin: 0.5, end: 0.0).animate(_generalAnimation),
      child: widget.arrowWidget ?? defaultIcon,
    );
    super.initState();
  }

  @override
  dispose() {
    _generalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initiallyExpanded == true) _toggleExpand();
    return Directionality(
      textDirection: widget.textDirection ?? TextDirection.ltr,
      child: Material(
        color: widget.backgroundColor ?? Colors.white,
        elevation: widget.elevation ?? 0,
        shape: widget.shape ?? defaultShapeBorder,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onHover: widget.hoverOn ?? false ? onHover() : null,
          onTap: widget.isEverywhereClickable! ? onTap : null,
          onLongPress: widget.isEverywhereClickable! ? onLongPress() : null,
          child: Container(
            decoration: BoxDecoration(image: widget.backgroundImage ?? null),
            padding: widget.padding ?? EdgeInsets.all(20.0),
            child: Wrap(
              children: [
                GestureDetector(
                  onTap: onTap,
                  onLongPress: onLongPress,
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: widget.showArrowWidget == true
                        ? _bodyWithArrow()
                        : widget.additionalChild != null
                            ? _additionalChild()
                            : widget.firstChild!,
                  ),
                ),
                _secondaryChild(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bodyWithArrow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        textDirection:
            widget.arrowLocation == ArrowLocation.right ? TextDirection.ltr : TextDirection.rtl,
        children: [
          if (widget.centralizeFirstChild! && widget.arrowWidget == null)
            holderIcon
          else if (widget.centralizeFirstChild! && widget.arrowWidget != null)
            Opacity(opacity: 0, child: widget.arrowWidget!),
          widget.firstChild!,
          defaultRotation!,
        ],
      );

  _secondaryChild() =>
      SizeTransition(axisAlignment: 0.0, sizeFactor: _generalAnimation, child: widget.secondChild);

  _additionalChild() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              widget.firstChild!,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                textDirection: widget.arrowLocation == ArrowLocation.right
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                children: [
                  if (widget.centralizeAdditionalChild! && widget.arrowWidget == null)
                    holderIcon
                  else if (widget.centralizeFirstChild! && widget.arrowWidget != null)
                    Opacity(opacity: 0, child: widget.arrowWidget!),
                  widget.additionalChild!,
                  defaultRotation!,
                ],
              ),
            ],
          )
        ],
      );

  /// TODO - Fix those functions.
  onTap() {
    if (isClickable!) if (widget.onPressed.toString() != 'null') {
      widget.onPressed!();
    }
    if (isClickable!)
      Timer(widget.beforeAnimationDuration ?? Duration(milliseconds: 20), () {
        _toggleExpand();
      });
  }

  onHover() {
    return (value) {
      if (widget.isClickable!) if (value = true) {
        _toggleExpand();
      } else if (value = false) {
        _isExpanded = true;
      }
    };
  }

  onLongPress() {
    if (widget.onLongPress.toString() != 'null') {
      widget.onLongPress!();
    } else
      onTap();
  }
}
