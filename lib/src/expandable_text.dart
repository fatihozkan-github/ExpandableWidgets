import 'package:expandable_widgets/src/enums.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'extensions.dart';
import 'dart:math';

class ExpandableText extends StatefulWidget {
  final Key? key;

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

  /// • Whether this expandable widget will be expanded or collapsed at first.
  final bool initiallyExpanded;

  /// • Custom arrow widget.
  final Widget? arrowWidget;

  /// • Place of the arrow widget when this expandable is collapsed.
  final ArrowLocation? arrowLocation;

  /// • Place of the arrow widget when this expandable is expanded.
  final ArrowLocation? finalArrowLocation;

  /// • Helper texts for [Helper.text].
  ///
  /// • Note that this list contains 2 values, collapsed & expanded helper text, respectively.
  final List<String> helperTextList;

  /// • Style for helper texts. Same style applies both of the texts.
  final TextStyle? helperTextStyle;

  /// • [BorderRadius] of [ExpandableText].
  ///
  /// • shape property removed from the version 1.0.2 (no need) and [borderRadius] added.
  final BorderRadius? borderRadius;

  final void Function(bool)? onHover;

  /// • Helps to choose a Helper for [ExpandableText]
  final Helper helper;

  final List<BoxShadow>? boxShadow;

  ExpandableText({
    this.key,
    required this.textWidget,
    this.onPressed,
    this.padding = const EdgeInsets.all(4.0),
    this.backgroundColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 500),
    this.backgroundImage,
    this.initiallyExpanded = false,
    this.onHover,
    this.arrowWidget = const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black, size: 25.0),
    this.arrowLocation = ArrowLocation.right,
    this.finalArrowLocation = ArrowLocation.right,
    this.helperTextList = const ['...Show More', '...Show Less'],
    this.helperTextStyle,
    this.borderRadius,
    this.helper = Helper.arrow,
    this.boxShadow,
  })  : assert(helperTextList.length == 2, 'helperTextList must have exactly 2 elements.'),
        super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> with TickerProviderStateMixin {
  bool _initiallyExpanded = false;
  bool _shouldShowHelper = true;
  bool _isExpanded = false;

  void _toggleExpand() {
    if (_initiallyExpanded == true) _initiallyExpanded = false;
    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  void initState() {
    super.initState();
    _initiallyExpanded = widget.initiallyExpanded;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() => _shouldShowHelper = widget.textWidget.hasOverflow(context.size?.width ?? 0.0));
    });
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
          boxShadow: widget.boxShadow ?? [BoxShadow(color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)],
        ),
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onHover: widget.onHover != null ? _onHover() : null,
          onTap: widget.helper == Helper.text ? null : _onTap,
          child: Padding(
            padding: widget.padding,
            child: widget.helper == Helper.arrow
                ? _bodyWithArrow()
                : widget.helper == Helper.text
                    ? _bodyWithText()
                    : _defaultBody(),
          ),
        ),
      );

  AnimatedCrossFade _bodyWithText() {
    TextStyle _defaultHelperStyle =
        TextStyle(color: Colors.blue, backgroundColor: Colors.white, fontWeight: FontWeight.bold);
    return AnimatedCrossFade(
      duration: widget.animationDuration,
      crossFadeState: !_isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          widget.textWidget.copyWith(maxLines: _isExpanded ? null : widget.textWidget.maxLines),
          if (_shouldShowHelper)
            Positioned(
              child: GestureDetector(
                child: Text(_isExpanded ? '' : widget.helperTextList.first,
                    style: widget.helperTextStyle?.copyWith(backgroundColor: widget.backgroundColor) ??
                        _defaultHelperStyle),
                onTap: () => _onTap(),
              ),
            ),
        ],
      ),
      secondChild: widget.textWidget.toRichText(
        TextSpan(
          text: widget.helperTextList.last,
          style: widget.helperTextStyle?.copyWith(backgroundColor: widget.backgroundColor) ?? _defaultHelperStyle,
          recognizer: TapGestureRecognizer()..onTap = _onTap,
          mouseCursor: SystemMouseCursors.click,
        ),
      ),
    );
  }

  AnimatedCrossFade _defaultBody() => AnimatedCrossFade(
        firstChild: widget.textWidget.copyWith(softWrap: true),
        secondChild: widget.textWidget.copyWith(maxLines: 999999),
        duration: widget.animationDuration,
        crossFadeState: !_isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      );

  AnimatedCrossFade _bodyWithArrow() => AnimatedCrossFade(
        duration: widget.animationDuration,
        crossFadeState: !_isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: _getChildWithArrow(widget.arrowLocation!, null),
        secondChild: _getChildWithArrow(widget.finalArrowLocation!, 9999999),
      );

  Flex _getChildWithArrow(ArrowLocation locationParameter, int? maxLineOption) {
    Widget _child = widget.textWidget.copyWith(maxLines: _isExpanded ? maxLineOption : widget.textWidget.maxLines);
    Axis _direction = Axis.horizontal;
    TextDirection _textDirection = TextDirection.ltr;
    VerticalDirection _verticalDirection = VerticalDirection.up;
    Widget _arrowWidget = Transform(
      transform: _isExpanded ? Matrix4.rotationZ(pi) : Matrix4.identity(),
      alignment: Alignment.center,
      child: widget.arrowWidget,
    );
    switch (locationParameter) {
      case ArrowLocation.left:
        _child = Expanded(child: _child);
        _textDirection = TextDirection.rtl;
        break;
      case ArrowLocation.right:
        _child = Expanded(child: _child);
        break;
      case ArrowLocation.top:
        _direction = Axis.vertical;
        break;
      case ArrowLocation.bottom:
        _direction = Axis.vertical;
        _verticalDirection = VerticalDirection.down;
        break;
      default:
        break;
    }
    return Flex(
      mainAxisSize: MainAxisSize.min,
      direction: _direction,
      textDirection: _textDirection,
      verticalDirection: _verticalDirection,
      children: [_child, _arrowWidget],
    );
  }

  void _onTap() async {
    //  && !_controller.isAnimating
    if (widget.onPressed != null) await widget.onPressed!();
    _toggleExpand();
  }

  Function(bool) _onHover() {
    return (value) {
      if (value == true) {
        _toggleExpand();
      } else if (value == false) {
        // if (_initiallyExpanded != true) _controller.reverse();
      }
    };
  }
}
