import 'package:expandable_widgets/src/enums.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'extensions.dart';
import 'dart:math';

class ExpandableText extends StatefulWidget {
  /// [Text] widget for [ExpandableText].
  final Text textWidget;

  /// • Animation starts BEFORE and ends AFTER this function.
  ///
  /// • Notice that this function can not be triggered more than once while animating Expandable.
  final Function? onPressed;

  /// • Padding of the expandable.
  final EdgeInsets padding;

  /// • Background color of the expandable.
  final Color backgroundColor;

  /// • Duration for expand animation.
  final Duration animationDuration;

  /// • Background image of the expandable.
  final DecorationImage? backgroundImage;

  /// • Icon that changes its direction with respect to expand animation.
  final bool showArrowWidget;

  /// • Whether this expandable widget will be expanded or collapsed at first.
  final bool initiallyExpanded;

  /// • Custom arrow widget.
  final Widget? arrowWidget;

  /// • Place of the arrow widget when this expandable is collapsed.
  final ArrowLocation? arrowLocation;

  /// • Place of the arrow widget when this expandable is expanded.
  final ArrowLocation? finalArrowLocation;

  /// • TODO - TEST
  final bool showHelperText;
  final List<String> helperText;
  final TextStyle? helperTextStyle;
  final BorderRadius? borderRadius;
  final Axis direction;
  final void Function(bool)? onHover;

  ExpandableText({
    required this.textWidget,
    this.onPressed,
    this.padding = const EdgeInsets.all(4.0),
    this.backgroundColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 500),
    this.backgroundImage,
    this.initiallyExpanded = false,
    this.onHover,
    this.arrowWidget = const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black, size: 25.0),
    this.showArrowWidget = false,
    this.arrowLocation = ArrowLocation.right,
    this.finalArrowLocation = ArrowLocation.right,
    this.showHelperText = false,
    this.helperText = const ['...Show More', '...Show Less'],
    this.helperTextStyle,
    this.borderRadius,
    this.direction = Axis.vertical,
  }) : assert(!(showArrowWidget == true && showHelperText == true), 'showArrowIcon and showHelperText cannot both be true.');

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> with TickerProviderStateMixin {
  Animatable<double> _sizeTween = Tween<double>(begin: 0.0, end: 1.0);
  // late TapGestureRecognizer _tapGestureRecognizer;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _initiallyExpanded = false;
  bool _isExpanded = false;

  void _toggleExpand() {
    _isExpanded = !_isExpanded;
    if (_initiallyExpanded == true) _initiallyExpanded = false;
    setState(() {});
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
    _animation = _sizeTween.animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    _initiallyExpanded = widget.initiallyExpanded;
    // _tapGestureRecognizer = TapGestureRecognizer()..onTap = _handleTap;
  }

  @override
  Widget build(BuildContext context) {
    if (_initiallyExpanded == true) _toggleExpand();
    return _buildBody();
  }

  Container _buildBody() => Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          image: widget.backgroundImage ?? null,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(5.0),
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)],
        ),
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onHover: _onHover(),
          onTap: widget.showHelperText ? null : _onTap,
          child: Padding(
            padding: widget.padding,
            child: widget.showArrowWidget
                ? _bodyWithArrow()
                : widget.showHelperText
                    ? _bodyWithHelper()
                    : _defaultBody(),
          ),
        ),
      );

  AnimatedCrossFade _bodyWithHelper() {
    TextStyle _defaultHelperStyle = TextStyle(color: Colors.blue, backgroundColor: Colors.white, fontWeight: FontWeight.bold);
    bool _shouldAddHelper =
        widget.textWidget.copyWith(maxLines: _isExpanded ? null : widget.textWidget.maxLines, softWrap: true).hasOverflow();
    print(_shouldAddHelper);

    return AnimatedCrossFade(
      duration: widget.animationDuration,
      crossFadeState: !_isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Text(
            widget.textWidget.data!,
            style: widget.textWidget.style ?? DefaultTextStyle.of(context).style,
            maxLines: _isExpanded ? null : widget.textWidget.maxLines,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
          // if (_shouldAddHelper)
          Positioned(
            child: GestureDetector(
              child: Text(_isExpanded ? '' : widget.helperText.first, style: widget.helperTextStyle ?? _defaultHelperStyle),
              onTap: () => _toggleExpand(),
            ),
          ),
        ],
      ),
      secondChild: Text.rich(
        TextSpan(
          text: widget.textWidget.data,
          style: widget.textWidget.style ?? DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: widget.helperText.last,
              style: widget.helperTextStyle?.copyWith(backgroundColor: Colors.white) ?? _defaultHelperStyle,
              // recognizer: _tapGestureRecognizer,
              recognizer: TapGestureRecognizer()..onTap = _handleTap,
              mouseCursor: SystemMouseCursors.click,
            ),
          ],
        ),
      ),
    );
  }

  /// Seems ok.
  AnimatedCrossFade _defaultBody() => AnimatedCrossFade(
        firstChild: widget.textWidget.copyWith(softWrap: true),
        secondChild: widget.textWidget.copyWith(maxLines: 999999),
        duration: widget.animationDuration,
        crossFadeState: !_isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      );

  /// TODO: Change seems bad.
  AnimatedCrossFade _bodyWithArrow() => AnimatedCrossFade(
        duration: widget.animationDuration,
        crossFadeState: _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: _getFirstChild(),
        secondChild: _getSecondChild(),
      );

  Widget _getFirstChild() {
    // Widget _child = Text(
    //   widget.textWidget.data!,
    //   style: widget.textWidget.style ?? DefaultTextStyle.of(context).style,
    //   maxLines: _isExpanded ? null : widget.textWidget.maxLines,
    // );
    Widget _child = widget.textWidget.copyWith(maxLines: _isExpanded ? null : widget.textWidget.maxLines);
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

  Widget _getSecondChild() {
    Widget _child = Text(
      widget.textWidget.data!,
      style: widget.textWidget.style ?? DefaultTextStyle.of(context).style,
      maxLines: _isExpanded ? null : widget.textWidget.maxLines,
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

  ///

  void _onTap() async {
    if (widget.onPressed != null) await widget.onPressed!();
    _toggleExpand();
  }

  void _handleTap() => _toggleExpand();

  Function(bool) _onHover() {
    return (value) {
      if (value == true) {
        _toggleExpand();
      } else if (value == false) {
        if (_initiallyExpanded != true) _controller.reverse();
      }
    };
  }
}
