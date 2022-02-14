import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';

class Expandable extends StatefulWidget {
  /// • The widget that is placed at the non-collapsing part of the expandable.
  final Widget firstChild;

  /// • The widget that size transition affects.
  final Widget secondChild;

  /// • Animation starts BEFORE and ends AFTER this function.
  ///
  /// • Notice that this function can not be triggered more than once while animating Expandable.
  final Function? onPressed;

  /// • Background color of the expandable.
  final Color backgroundColor;

  /// • Duration for expand & rotate animations.
  final Duration animationDuration;

  /// • Background image of the expandable.
  final DecorationImage? backgroundImage;

  /// • Whether [arrowWidget] will be shown or not.
  final bool? showArrowWidget;

  /// • Whether expandable will be expanded or collapsed at first.
  final bool? initiallyExpanded;

  /// • Provides better alignment for [firstChild].
  final bool centralizeFirstChild;

  /// • Custom widget that changes its direction with respect to expand animation.
  final Widget? arrowWidget;

  /// • Place of the arrow widget.
  final ArrowLocation? arrowLocation;

  final Function? onLongPress;

  /// • Custom animation for size & rotation animations.
  ///
  /// • Notice that there is no separate support for size & rotation animations.
  final Animation<double>? animation;

  /// • Controller for [animation].
  ///
  /// • Useful when one want to interact with the expandable with an external button etc.
  final AnimationController? animationController;

  final void Function(bool)? onHover;

  final Axis direction;

  final List<BoxShadow>? boxShadow;

  /// • [BorderRadius] of Expandable.
  ///
  /// • shape property removed from the version 1.0.2 (no need) and [borderRadius] added.
  final BorderRadius? borderRadius;

  /// • Decide click behaviour of the Expandable.
  ///
  /// • See [Clickable] for possible options.
  final Clickable clickable;

  /// • Expandable class for general use.
  ///
  /// • [backgroundColor], [animationDuration], [centralizeFirstChild], [direction], [clickable] arguments must not be null.
  Expandable({
    required this.firstChild,
    required this.secondChild,
    this.onPressed,
    this.backgroundColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 400),
    this.backgroundImage,
    this.showArrowWidget = true,
    this.initiallyExpanded = false,
    this.centralizeFirstChild = true,
    this.arrowWidget,
    this.arrowLocation = ArrowLocation.right,
    this.borderRadius,
    this.clickable = Clickable.firstChildOnly,

    /// TODO - TEST
    this.onLongPress,
    this.animation,
    this.animationController,
    this.direction = Axis.vertical,
    this.onHover,
    this.boxShadow,
  });
  // : assert(
  //       arrowWidget != null && arrowLocation != null, 'arrowWidget and arrowLocation arguments can not be used at the same time.');

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> with TickerProviderStateMixin {
  Animatable<double> _sizeTween = Tween<double>(begin: 0.0, end: 1.0);
  late AnimationController _controller;
  late Animation<double> _animation;
  bool? _initiallyExpanded = false;

  @override
  void initState() {
    _initiallyExpanded = widget.initiallyExpanded;
    _controller = widget.animationController ?? AnimationController(vsync: this, duration: widget.animationDuration);
    _animation = widget.animation ?? _sizeTween.animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initiallyExpanded == true) _toggleExpand();
    return _buildBody();
  }

  RotationTransition _buildRotation() {
    return RotationTransition(
      turns: Tween(begin: 0.5, end: 0.0).animate(_animation),
      child: widget.arrowWidget == null ? Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black, size: 25.0) : widget.arrowWidget,
    );
  }

  Container _buildBody() => Container(
        child: widget.direction == Axis.vertical ? _buildVerticalExpandable() : _buildHorizontalExpandable(),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          image: widget.backgroundImage ?? null,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(5.0),
          boxShadow: widget.boxShadow ?? [BoxShadow(color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)],
        ),
      );

  Column _buildVerticalExpandable() => Column(
        children: [
          InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onHover: widget.onHover != null ? _onHover() : null,
            onTap: widget.clickable != Clickable.none ? _onPressed : null,
            onLongPress: widget.clickable != Clickable.none ? _onLongPress : null,
            child: widget.showArrowWidget == true
                ? _buildBodyWithArrow()
                : Row(mainAxisAlignment: MainAxisAlignment.center, children: [widget.firstChild]),
          ),
          InkWell(
            child: _buildSecondChild(),
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onHover: widget.onHover != null ? _onHover() : null,
            onTap: widget.clickable == Clickable.everywhere ? _onPressed : null,
            onLongPress: widget.clickable == Clickable.everywhere ? _onLongPress : null,
          ),
        ],
      );

  Row _buildHorizontalExpandable() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onHover: widget.onHover != null ? _onHover() : null,
            onTap: widget.clickable != Clickable.none ? _onPressed : null,
            onLongPress: widget.clickable != Clickable.none ? _onLongPress : null,
            child: widget.showArrowWidget == true
                ? _buildBodyWithArrow()
                : Row(mainAxisAlignment: MainAxisAlignment.center, children: [widget.firstChild]),
          ),
          InkWell(
            child: _buildSecondChild(),
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onHover: widget.onHover != null ? _onHover() : null,
            onTap: widget.clickable == Clickable.everywhere ? _onPressed : null,
            onLongPress: widget.clickable == Clickable.everywhere ? _onLongPress : null,
          ),
        ],
      );

  Flex _buildBodyWithArrow() => Flex(
        direction: widget.direction == Axis.horizontal ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        textDirection: widget.arrowLocation == ArrowLocation.right ? TextDirection.ltr : TextDirection.rtl,
        children: [
          if (widget.centralizeFirstChild) Visibility(visible: false, child: _buildRotation()),
          widget.firstChild,
          _buildRotation(),
        ],
      );

  SizeTransition _buildSecondChild() => SizeTransition(
        axisAlignment: 1,
        axis: widget.direction,
        sizeFactor: _animation,
        child: widget.secondChild,
      );

  void _toggleExpand() {
    if (_initiallyExpanded == true) _initiallyExpanded = false;
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

  Future<void> _onPressed() async {
    if (widget.onPressed != null && !_controller.isAnimating) await widget.onPressed!();
    _toggleExpand();
  }

  Future<void> _onLongPress() async {
    if (widget.onLongPress != null && !_controller.isAnimating) await widget.onLongPress!();
  }

  Function(bool) _onHover() {
    return (value) {
      widget.onHover!;
      if (value == true) {
        _toggleExpand();
      } else if (value == false) {
        if (_initiallyExpanded != true) _controller.reverse();
      }
    };
  }
}
