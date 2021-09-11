import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Expandable extends StatefulWidget {
  /// • Expandable abstract class for general use.
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
    this.expandOnHover = false,
    this.centralizeFirstChild = true,
    this.arrowWidget = const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black, size: 25.0),
    this.arrowLocation = ArrowLocation.right,
    this.borderRadius,

    /// TODO - TEST
    this.onLongPress,
    this.textDirection = TextDirection.ltr,
    this.animation,
    this.animationController,
    this.wrapContent = true,
    this.clickable = Clickable.firstChildOnly,
    this.direction = Axis.vertical,
    this.margin = const EdgeInsets.all(0.0),
  });

  /// TODO: TEST
  final bool wrapContent;
  final Clickable clickable;
  final Axis direction;
  final BorderRadius? borderRadius;
  final EdgeInsets margin;

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

  /// • Whether expand animation will be triggered when hovered over this widget or not.
  ///
  /// • Added for web.
  final bool expandOnHover;

  /// • Provides better alignment for [firstChild].
  final bool centralizeFirstChild;

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
  /// • See [Expandable] & [TextDirection] for more info.
  final TextDirection textDirection;

  /// • Custom animation for size & rotation animations.
  final Animation<double>? animation;

  /// • Controller for [animation].
  ///
  /// • Useful when one want to interact with the expandable with an external button etc.
  final AnimationController? animationController;

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> with TickerProviderStateMixin {
  late AnimationController _generalController;
  late Animation<double> _generalAnimation;
  Animatable<double> _sizeTween = Tween<double>(begin: 0.0, end: 1.0);
  bool? initiallyExpanded = false;
  Widget? defaultRotation;

  _toggleExpand() {
    if (initiallyExpanded == true) initiallyExpanded = false;
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
    initiallyExpanded = widget.initiallyExpanded;
    _generalController = widget.animationController ??
        AnimationController(vsync: this, duration: widget.animationDuration);
    CurvedAnimation curve =
        CurvedAnimation(parent: _generalController, curve: Curves.fastOutSlowIn);
    _generalAnimation = widget.animation ?? _sizeTween.animate(curve);
    defaultRotation = RotationTransition(
      turns: Tween(begin: 0.5, end: 0.0).animate(_generalAnimation),
      child: widget.arrowWidget,
    );
    super.initState();
  }

  @override

  /// TODO: Multiple dispose exception.
  ///
  /// Needs further tests.
  dispose() {
    super.dispose();
    // _generalController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initiallyExpanded == true) _toggleExpand();
    return Directionality(
      textDirection: widget.textDirection,
      child: widget.wrapContent
          ? Row(mainAxisSize: MainAxisSize.min, children: [_getBody()])
          : _getBody(),
    );
  }

  _getBody() => Material(
        color: widget.backgroundColor,
        elevation: widget.elevation,
        clipBehavior: Clip.antiAlias,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(5.0),
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onHover: widget.expandOnHover ? onHover() : null,
          onTap: widget.clickable == Clickable.everywhere ? onTap : () {},
          onLongPress: widget.clickable == Clickable.everywhere ? onLongPress : null,
          child: Container(
            decoration: BoxDecoration(image: widget.backgroundImage ?? null),
            padding: widget.padding,
            child: Flex(
              // direction: widget.direction,
              direction: Axis.vertical,
              children: [
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: widget.clickable != Clickable.none ? onTap : () {},
                  onLongPress: widget.clickable != Clickable.none ? onLongPress : null,
                  child: widget.showArrowWidget == true ? _bodyWithArrow() : widget.firstChild!,
                ),
                _secondaryChild(),
              ],
            ),
          ),
        ),
      );

  _bodyWithArrow() => Flex(
        direction: widget.direction == Axis.horizontal ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        textDirection:
            widget.arrowLocation == ArrowLocation.right ? TextDirection.ltr : TextDirection.rtl,
        children: [
          if (widget.centralizeFirstChild) Opacity(opacity: 0, child: widget.arrowWidget!),
          widget.firstChild!,
          defaultRotation!,
        ],
      );

  _secondaryChild() => SizeTransition(
        axis: widget.direction,
        axisAlignment: 1,
        sizeFactor: _generalAnimation,
        child: widget.secondChild,
      );

  onTap() async {
    if (widget.onPressed != null) await widget.onPressed!();
    _toggleExpand();
  }

  onLongPress() async {
    if (widget.onLongPress != null) await widget.onLongPress!();
  }

  onHover() => (value) {
        if (value == true) {
          _toggleExpand();
        } else if (value == false) {
          if (initiallyExpanded != true) _generalController.reverse();
        }
      };
}
