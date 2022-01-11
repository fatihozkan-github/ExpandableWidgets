import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';

class Expandable extends StatefulWidget {
  /// TODO: TEST
  final bool wrapContent;
  final Clickable clickable;
  final Axis direction;
  final BorderRadius? borderRadius;
  // final EdgeInsets margin;

  /// • The widget that is placed at the non-collapsing part of the expandable.
  final Widget? firstChild;

  /// • The widget that [sizeTransition] affects.
  final Widget? secondChild;

  /// • Function that is placed top of the widget tree.
  ///
  /// • Animation starts AFTER this function.
  ///
  /// • For the duration between see [beforeAnimationDuration].
  final Function? onPressed;

  /// • Padding of the expandable.
  final EdgeInsets padding;

  /// • Background color of the expandable.
  final Color backgroundColor;

  /// • Elevation of the expandable widget.
  final double elevation;

  /// • Duration for expand & rotate animations.
  final Duration animationDuration;

  /// • Duration between [onPressed] & expand animation.
  final Duration beforeAnimationDuration;

  /// • Background image of the expandable.
  final DecorationImage? backgroundImage;

  /// • Whether [arrowWidget] will be shown or not.
  final bool? showArrowWidget;

  /// • Whether this expandable widget will be expanded or collapsed at first.
  final bool? initiallyExpanded;

  // /// • Whether expand animation will be triggered when hovered over this widget or not.
  // ///
  // /// • Added for web.
  // final bool expandOnHover;

  /// • Provides better alignment for [firstChild].
  final bool centralizeFirstChild;

  /// • Custom widget that changes its direction with respect to expand animation.
  final Widget? arrowWidget;

  /// • Place of the arrow widget.
  final ArrowLocation? arrowLocation;

  /// • onLongPress
  final Function? onLongPress;

  // /// • [TextDirection] of the expandable.
  // ///
  // /// • Default value is [TextDirection.ltr].
  // ///
  // /// • See [Expandable] & [TextDirection] for more info.
  // final TextDirection textDirection;

  /// • Custom animation for size & rotation animations.
  final Animation<double>? animation;

  /// • Controller for [animation].
  ///
  /// • Useful when one want to interact with the expandable with an external button etc.
  final AnimationController? animationController;

  final Function(bool)? onHover;

  /// • Expandable class for general use.
  Expandable({
    this.firstChild,
    this.secondChild,
    this.onPressed,
    this.padding = const EdgeInsets.all(8.0),
    this.backgroundColor = Colors.white,
    this.elevation = 0,
    this.animationDuration = const Duration(seconds: 1),
    this.beforeAnimationDuration = const Duration(milliseconds: 20),
    this.backgroundImage,
    this.showArrowWidget = true,
    this.initiallyExpanded = false,
    // this.expandOnHover = false,
    this.centralizeFirstChild = true,
    this.arrowWidget = const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black, size: 25.0),
    this.arrowLocation = ArrowLocation.right,
    this.borderRadius,

    /// TODO - TEST
    this.onLongPress,
    // this.textDirection = TextDirection.ltr,
    this.animation,
    this.animationController,
    this.wrapContent = true,
    this.clickable = Clickable.firstChildOnly,
    this.direction = Axis.vertical,
    // this.margin = const EdgeInsets.all(0.0),
    this.onHover,
  });

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> with TickerProviderStateMixin {
  Animatable<double> _sizeTween = Tween<double>(begin: 0.0, end: 1.0);
  late AnimationController _controller;
  late Animation<double> _animation;
  bool? initiallyExpanded = false;
  Widget? defaultRotation;

  @override
  initState() {
    initiallyExpanded = widget.initiallyExpanded;
    _controller = widget.animationController ?? AnimationController(vsync: this, duration: widget.animationDuration);
    CurvedAnimation curve = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _animation = widget.animation ?? _sizeTween.animate(curve);
    defaultRotation = RotationTransition(turns: Tween(begin: 0.5, end: 0.0).animate(_animation), child: widget.arrowWidget);
    super.initState();
  }

  // @override
  // dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    if (initiallyExpanded == true) _toggleExpand();
    return Directionality(textDirection: Directionality.of(context), child: _getBody());
  }

  _getBody() => Material(
        color: widget.backgroundColor,
        elevation: widget.elevation,
        clipBehavior: Clip.antiAlias,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(5.0),
        child: Container(
          decoration: BoxDecoration(image: widget.backgroundImage ?? null),
          child: Column(
            children: [
              InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: widget.clickable != Clickable.none ? _onPressed : null,
                onLongPress: widget.clickable != Clickable.none ? _onLongPress : null,
                onHover: widget.onHover != null ? _onHover() : null,
                child: Padding(
                  padding: widget.padding,
                  child: widget.showArrowWidget == true ? _bodyWithArrow() : widget.firstChild!,
                ),
              ),
              InkWell(
                child: _secondaryChild(),
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onHover: widget.onHover != null ? _onHover() : null,
                onTap: widget.clickable == Clickable.everywhere ? _onPressed : null,
                onLongPress: widget.clickable == Clickable.everywhere ? _onLongPress : null,
              ),
            ],
          ),
        ),
      );

  _bodyWithArrow() => Flex(
        direction: widget.direction == Axis.horizontal ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        textDirection: widget.arrowLocation == ArrowLocation.right ? TextDirection.ltr : TextDirection.rtl,
        children: [
          if (widget.centralizeFirstChild) Opacity(opacity: 0, child: widget.arrowWidget!),
          widget.firstChild!,

          /// TODO:
          defaultRotation!,
        ],
      );

  _secondaryChild() => SizeTransition(
        axis: widget.direction,
        axisAlignment: 1,
        sizeFactor: _animation,
        child: widget.secondChild,
      );

  _toggleExpand() {
    if (initiallyExpanded == true) initiallyExpanded = false;
    switch (_animation.status) {
      case AnimationStatus.completed:
        _controller.reverse();
        break;
      case AnimationStatus.dismissed:
        _controller.forward();
        break;
      case AnimationStatus.reverse:
      case AnimationStatus.forward:
        break;
    }
  }

  _onPressed() async {
    if (widget.onPressed != null && !_controller.isAnimating) await widget.onPressed!();
    _toggleExpand();
  }

  _onLongPress() async {
    if (widget.onLongPress != null && !_controller.isAnimating) await widget.onLongPress!();
  }

  _onHover() => (value) {
        widget.onHover!;
        if (value == true) {
          _toggleExpand();
        } else if (value == false) {
          if (initiallyExpanded != true) _controller.reverse();
        }
      };
}
