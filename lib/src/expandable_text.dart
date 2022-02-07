import 'package:expandable_widgets/src/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ExpandableText extends StatefulWidget {
  ExpandableText({
    this.textWidget,
    this.onPressed,
    this.padding = const EdgeInsets.all(4.0),
    this.backgroundColor = Colors.white,
    this.elevation = 0,
    this.animationDuration = const Duration(seconds: 1),
    this.beforeAnimationDuration = const Duration(milliseconds: 20),
    this.backgroundImage,
    this.initiallyExpanded = false,
    this.expandOnHover = false,
    this.arrowWidget = const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black, size: 25.0),
    this.showArrowWidget = false,
    this.textDirection = TextDirection.ltr,
    this.arrowLocation = ArrowLocation.right,
    this.finalArrowLocation = ArrowLocation.right,
    this.showHelperText = false,
    this.helperText = const ['...Show More', '...Show Less'],
    this.helperTextStyle,

    /// TODO : TEST
    this.borderRadius,
    this.direction = Axis.vertical,
  })  : assert(!(showArrowWidget == true && showHelperText == true), 'showArrowIcon and showHelperText cannot both be true.'),
        assert(textWidget != null, 'Provide a Text for textWidget parameter.');

  /// • TODO - TEST
  final List<String> helperText;
  final TextStyle? helperTextStyle;
  final BorderRadius? borderRadius;
  final Axis direction;

  ///
  /// [Text] widget for [ExpandableText].
  final Text? textWidget;

  /// • Function that is placed top of the widget tree.
  ///
  /// • Animation starts AFTER this function.
  ///
  /// • For the duration between see [beforeAnimationDuration].
  final Function? onPressed;

  /// • Padding of the expandable.
  final EdgeInsets? padding;

  /// • Background color of the expandable.
  final Color backgroundColor;

  /// • Elevation of the expandable.
  final double elevation;

  /// • Duration for expand animation.
  final Duration animationDuration;

  /// • Duration between [onPressed] & expand animation.
  final Duration beforeAnimationDuration;

  /// • Background image of the expandable.
  final DecorationImage? backgroundImage;

  /// • Icon that changes its direction with respect to expand animation.
  final bool showArrowWidget;

  /// • Whether this expandable widget will be expanded or collapsed at first.
  final bool initiallyExpanded;

  /// • Whether expand animation will be triggered when hovered over this widget or not.
  ///
  /// • Added for web.
  final bool expandOnHover;

  /// • [TextDirection] of the expandable.
  ///
  /// • Default value is [TextDirection.ltr].
  ///
  /// • Notice that this property does not belong to [textWidget] but [ExpandableText].
  ///
  /// • See ExpandableTextWidget & [TextDirection] for more info.
  final TextDirection textDirection;

  /// • Custom arrow widget.
  final Widget? arrowWidget;

  /// • Place of the arrow widget when this expandable is collapsed.
  final ArrowLocation? arrowLocation;

  /// • Place of the arrow widget when this expandable is expanded.
  final ArrowLocation? finalArrowLocation;

  /// •
  final bool showHelperText;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> with TickerProviderStateMixin {
  Animatable<double> _sizeTween = Tween<double>(begin: 0.0, end: 1.0);
  late AnimationController _controller;
  late Animation<double> _animation;
  late TapGestureRecognizer tapGestureRecognizer;
  bool _isExpanded = false;
  bool? initiallyExpanded = false;
  Text finalText = Text('');

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (initiallyExpanded == true) initiallyExpanded = false;
    });
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.animationDuration);
    CurvedAnimation curve = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _animation = _sizeTween.animate(curve);
    initiallyExpanded = widget.initiallyExpanded;
    tapGestureRecognizer = TapGestureRecognizer()..onTap = _handleTap;
    finalText = Text(
      widget.textWidget!.data!,
      style: widget.textWidget!.style ?? TextStyle(color: Colors.black),
      strutStyle: widget.textWidget!.strutStyle,
      textAlign: widget.textWidget!.textAlign,
      textDirection: widget.textWidget!.textDirection,
      locale: widget.textWidget!.locale,
      softWrap: widget.textWidget!.softWrap,
      textScaleFactor: widget.textWidget!.textScaleFactor,
      semanticsLabel: widget.textWidget!.semanticsLabel,
      textWidthBasis: widget.textWidget!.textWidthBasis,
      textHeightBehavior: widget.textWidget!.textHeightBehavior,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (initiallyExpanded == true) _toggleExpand();
    return Directionality(
      textDirection: widget.textDirection,
      child: Material(
        color: widget.backgroundColor,
        elevation: widget.elevation,
        clipBehavior: Clip.antiAlias,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(5.0),
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onHover: widget.expandOnHover ? _onHover() : null,
          onTap: widget.showHelperText ? null : _onTap,
          child: Container(
            decoration: BoxDecoration(image: widget.backgroundImage ?? null),
            // padding: widget.padding,
            child: widget.showArrowWidget
                ? _bodyWithArrow()
                : widget.showHelperText
                    ? _bodyWithHelper()
                    : _defaultBody(),
          ),
        ),
      ),
    );
  }

  _bodyWithArrow() => AnimatedCrossFade(
        duration: widget.animationDuration,
        crossFadeState: _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: _getFirstChild(),
        secondChild: _getSecondChild(),
      );

  _getFirstChild() {
    Widget _child = Text(
      widget.textWidget!.data!,
      style: widget.textWidget!.style ?? DefaultTextStyle.of(context).style,
      maxLines: _isExpanded ? null : widget.textWidget!.maxLines,
    );
    Widget _arrowWidget = widget.arrowWidget!;
    Axis _direction = Axis.horizontal;
    TextDirection _textDirection = TextDirection.ltr;
    VerticalDirection _verticalDirection = VerticalDirection.up;

    switch (widget.finalArrowLocation) {
      case ArrowLocation.left:
        _child = Expanded(child: _child);
        _textDirection = TextDirection.rtl;
        _arrowWidget = Transform(transform: Matrix4.rotationZ(pi), alignment: Alignment.center, child: widget.arrowWidget);
        break;
      case ArrowLocation.right:
        _child = Expanded(child: _child);
        _arrowWidget = Transform(transform: Matrix4.rotationZ(pi), alignment: Alignment.center, child: widget.arrowWidget);
        break;
      case ArrowLocation.top:
        _direction = Axis.vertical;
        break;
      case ArrowLocation.bottom:
        _direction = Axis.vertical;
        _verticalDirection = VerticalDirection.down;
        break;
      case null:
        return Container();
    }
    return Flex(
      mainAxisSize: MainAxisSize.min,
      direction: _direction,
      textDirection: _textDirection,
      verticalDirection: _verticalDirection,
      children: [_child, _arrowWidget],
    );
  }

  _getSecondChild() {
    Widget _child = Text(
      widget.textWidget!.data!,
      style: widget.textWidget!.style ?? DefaultTextStyle.of(context).style,
      maxLines: _isExpanded ? null : widget.textWidget!.maxLines,
    );
    Widget _arrowWidget = widget.arrowWidget!;
    Axis _direction = Axis.horizontal;
    TextDirection _textDirection = TextDirection.ltr;
    VerticalDirection _verticalDirection = VerticalDirection.up;

    switch (widget.arrowLocation) {
      case ArrowLocation.left:
        _child = Expanded(child: _child);
        _textDirection = TextDirection.rtl;
        _arrowWidget = Transform(transform: Matrix4.rotationZ(pi), alignment: Alignment.center, child: widget.arrowWidget);
        break;
      case ArrowLocation.right:
        _child = Expanded(child: _child);
        _arrowWidget = Transform(transform: Matrix4.rotationZ(pi), alignment: Alignment.center, child: widget.arrowWidget);
        break;
      case ArrowLocation.top:
        _direction = Axis.vertical;
        break;
      case ArrowLocation.bottom:
        _direction = Axis.vertical;
        _verticalDirection = VerticalDirection.down;
        break;
      case null:
        return Container();
    }
    return Flex(
      mainAxisSize: MainAxisSize.min,
      direction: _direction,
      textDirection: _textDirection,
      verticalDirection: _verticalDirection,
      children: [_child, _arrowWidget],
    );
  }

  _bodyWithHelper() => AnimatedCrossFade(
        duration: widget.animationDuration,
        crossFadeState: _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: Text.rich(
          TextSpan(
            text: widget.textWidget!.data,
            style: widget.textWidget!.style ?? DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: widget.helperText.last,
                style: widget.helperTextStyle ??
                    TextStyle(color: Colors.blue, backgroundColor: Colors.white, fontWeight: FontWeight.bold),
                recognizer: tapGestureRecognizer,
              ),
            ],
          ),
        ),
        secondChild: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Text(
              widget.textWidget!.data!,
              style: widget.textWidget!.style ?? DefaultTextStyle.of(context).style,
              maxLines: _isExpanded ? null : widget.textWidget!.maxLines,
            ),
            Positioned(
              child: GestureDetector(
                child: Text(
                  _isExpanded ? '' : widget.helperText.first,
                  style: widget.helperTextStyle ??
                      TextStyle(color: Colors.blue, backgroundColor: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () => _toggleExpand(),
              ),
            ),
          ],
        ),
      );

  _defaultBody() => AnimatedCrossFade(
        duration: widget.animationDuration,
        crossFadeState: _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: finalText,
        secondChild: widget.textWidget!,
      );

  _onTap() async {
    if (widget.onPressed != null) await widget.onPressed!();
    _toggleExpand();
  }

  _handleTap() => _toggleExpand();

  _onHover() => (value) {
        if (value == true) {
          _toggleExpand();
        } else if (value == false) {
          if (initiallyExpanded != true) _controller.reverse();
        }
      };
}
