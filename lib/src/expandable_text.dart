import 'dart:async';
import 'package:expandable_widgets/src/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  /// TODO - finalArrowLocation.left is broken.
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
    this.initiallyExpanded,
    this.hoverOn,
    this.arrowWidget,
    this.showArrowIcon,
    this.textDirection,
    this.arrowLocation,
    this.finalArrowLocation,
    this.showHelperText,
    this.helperText,
  }) : assert(
          !(showArrowIcon == true && showHelperText == true),
          'showArrowIcon and showHelperText properties cannot be true at the same time.',
        );

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
  final Color? backgroundColor;

  /// • Elevation of the expandable.
  final double? elevation;

  /// • Shape of the expandable.
  ///
  /// • Notice that [shape] is a [ShapeBorder], not [BoxShape].
  final ShapeBorder? shape;

  /// • Duration for expand animation.
  final Duration? animationDuration;

  /// • Duration between [onPressed] & expand animation.
  final Duration? beforeAnimationDuration;

  /// • Background image of the expandable.
  final DecorationImage? backgroundImage;

  /// • Icon that changes its direction with respect to expand animation.
  final bool? showArrowIcon;

  /// • Whether this expandable widget will be expanded or collapsed at first.
  final bool? initiallyExpanded;

  /// • Whether expand animation will be triggered when hovered over this widget or not.
  ///
  /// • Added for web.
  final bool? hoverOn;

  /// • [TextDirection] of the expandable.
  ///
  /// • Default value is [TextDirection.ltr].
  ///
  /// • Notice that this property does not belong to [textWidget] but [ExpandableText].
  ///
  /// • See [ExpandableTextWidget] & [TextDirection] for more info.
  final TextDirection? textDirection;

  /// • Custom arrow widget.
  final Widget? arrowWidget;

  /// • Place of the arrow widget when this expandable is collapsed.
  final ArrowLocation? arrowLocation;

  /// • Place of the arrow widget when this expandable is expanded.
  final ArrowLocation? finalArrowLocation;

  /// •
  final bool? showHelperText;

  /// •
  final String? helperText;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late Animation<double> _sizeAnimation;
  bool _isExpanded = false;
  bool? initiallyExpanded = false;

  static final Animatable<double> _sizeTween = Tween<double>(
    begin: 00,
    end: 1.0,
  );

  late TapGestureRecognizer tapGestureRecognizer;

  Text finalText = Text('');

  _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (initiallyExpanded == true) initiallyExpanded = false;
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

  @override
  initState() {
    super.initState();
    _sizeController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? Duration(milliseconds: 200),
    );

    final CurvedAnimation curve =
        CurvedAnimation(parent: _sizeController, curve: Curves.fastOutSlowIn);

    _sizeAnimation = _sizeTween.animate(curve);
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
      textDirection: widget.textDirection ?? TextDirection.ltr,
      child: Material(
        color: widget.backgroundColor ?? Colors.white,
        elevation: widget.elevation ?? 0,
        shape: widget.shape ?? defaultShapeBorder,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onHover: widget.hoverOn ?? false ? _onHover() : null,
          onTap: widget.showHelperText ?? false ? null : _onTap,
          child: Container(
            decoration: BoxDecoration(image: widget.backgroundImage ?? null),
            padding: widget.padding ?? EdgeInsets.all(20.0),
            child: widget.showArrowIcon ?? false
                ? _textBodyWithArrow()
                : widget.showHelperText ?? false
                    ? _textBodyWithHelper()
                    : _defaultTextBody(),
          ),
        ),
      ),
    );
  }

  _textBodyWithHelper() {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        _isExpanded
            ? Text.rich(
                TextSpan(
                  text: widget.textWidget!.data,
                  style: widget.textWidget!.style ??
                      DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: ' Show Less',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      recognizer: tapGestureRecognizer,
                    ),
                  ],
                ),
              )
            : Text(
                widget.textWidget!.data!,
                style: widget.textWidget!.style ??
                    DefaultTextStyle.of(context).style,
                maxLines: _isExpanded ? null : widget.textWidget!.maxLines,
              ),
        Positioned(
          child: GestureDetector(
            child: Text(
              _isExpanded ? '' : '...Show More',
              style: TextStyle(
                color: Colors.blue,
                backgroundColor: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => _toggleExpand(),
          ),
        ),
      ],
    );
  }

  _textBodyWithArrow() => AnimatedCrossFade(
        duration: widget.animationDuration!,
        crossFadeState:
            _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: (widget.finalArrowLocation == ArrowLocation.left ||
                widget.finalArrowLocation == ArrowLocation.right)
            ? Row(
                textDirection: widget.arrowLocation == ArrowLocation.right
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                children: [
                  Expanded(child: finalText),
                  Padding(
                    padding: widget.arrowLocation == ArrowLocation.left
                        ? EdgeInsets.only(right: widget.padding!.right)
                        : EdgeInsets.only(left: widget.padding!.left),
                    child: widget.arrowWidget ?? defaultIcon,
                  ),
                ],
              )
            : Column(
                children: [
                  if (widget.finalArrowLocation == ArrowLocation.bottom)
                    finalText,
                  Padding(
                    padding: widget.finalArrowLocation == ArrowLocation.top
                        ? EdgeInsets.only(bottom: widget.padding!.top)
                        : EdgeInsets.only(top: widget.padding!.bottom),
                    child: widget.arrowWidget ?? defaultIcon,
                  ),
                  if (widget.finalArrowLocation == ArrowLocation.top) finalText,
                ],
              ),
        secondChild: (widget.arrowLocation == ArrowLocation.left ||
                widget.arrowLocation == ArrowLocation.right)
            ? Row(
                textDirection: widget.arrowLocation == ArrowLocation.right
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                children: [
                  Expanded(child: widget.textWidget!),
                  Padding(
                    padding: widget.arrowLocation == ArrowLocation.left
                        ? EdgeInsets.only(right: widget.padding!.right)
                        : EdgeInsets.only(left: widget.padding!.left),
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: widget.arrowWidget ?? defaultIcon,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  if (widget.arrowLocation == ArrowLocation.bottom)
                    widget.textWidget!,
                  Padding(
                    padding: widget.arrowLocation == ArrowLocation.top
                        ? EdgeInsets.only(bottom: widget.padding!.top)
                        : EdgeInsets.only(top: widget.padding!.bottom),
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: widget.arrowWidget ?? defaultIcon,
                    ),
                  ),
                  if (widget.arrowLocation == ArrowLocation.top)
                    widget.textWidget!,
                ],
              ),
      );

  _defaultTextBody() => AnimatedCrossFade(
        duration: widget.animationDuration!,
        crossFadeState:
            _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: finalText,
        secondChild: widget.textWidget!,
      );

  _onHover() => (value) => value ? _toggleExpand() : _isExpanded = true;

  _onTap() {
    widget.onPressed ?? () {};
    Timer(widget.beforeAnimationDuration ?? Duration(milliseconds: 20),
        () => _toggleExpand());
  }

  _handleTap() => _toggleExpand();
}
