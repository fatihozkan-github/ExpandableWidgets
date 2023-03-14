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

  /// • Expandable text widget for general use.
  ///
  /// • `textWidget`, `helper`, `initiallyExpanded`, `padding`, `backgroundColor`, `helperTextList` & `animationDuration` arguments must not be null.
  const ExpandableText({
    Key? key,
    required this.textWidget,
    this.onPressed,
    this.padding = const EdgeInsets.all(4.0),
    this.backgroundColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 500),
    this.backgroundImage,
    this.initiallyExpanded = false,
    this.onHover,
    this.arrowWidget = const Icon(Icons.keyboard_arrow_down_rounded,
        color: Colors.black, size: 25.0),
    this.arrowLocation = ArrowLocation.right,
    this.finalArrowLocation = ArrowLocation.right,
    this.helperTextList = const ['...Show More', '...Show Less'],
    this.helperTextStyle,
    this.borderRadius,
    this.helper = Helper.arrow,
    this.boxShadow,
  })  : assert(
          helperTextList.length == 2,
          'helperTextList must have exactly 2 elements.',
        ),
        super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin {
  bool initiallyExpanded = false;
  bool shouldShowHelper = true;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    initiallyExpanded = widget.initiallyExpanded;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(
        () {
          shouldShowHelper = widget.textWidget.hasOverflow(
            context.size?.width ?? 0.0,
          );
        },
      );
    });
  }

  void toggleExpand() {
    if (initiallyExpanded == true) initiallyExpanded = false;
    setState(() => isExpanded = !isExpanded);
  }

  void onTap() async {
    if (widget.onPressed != null) await widget.onPressed!();
    toggleExpand();
  }

  void onHover(bool isHovered) {
    if (isHovered) toggleExpand();
  }

  @override
  Widget build(BuildContext context) {
    if (initiallyExpanded == true) toggleExpand();
    return buildBody();
  }

  Container buildBody() {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        image: widget.backgroundImage,
        boxShadow: widget.boxShadow,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(5.0),
      ),
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onHover: widget.onHover != null ? onHover : null,
        onTap: widget.helper == Helper.text ? null : onTap,
        child: Padding(
          padding: widget.padding,
          child: widget.helper == Helper.arrow
              ? buildBodyWithArrow()
              : widget.helper == Helper.text
                  ? buildBodyWithText()
                  : buildDefaultBody(),
        ),
      ),
    );
  }

  AnimatedCrossFade buildBodyWithText() {
    const defaultHelperStyle = TextStyle(
      color: Colors.blue,
      backgroundColor: Colors.white,
      fontWeight: FontWeight.bold,
    );
    return AnimatedCrossFade(
      duration: widget.animationDuration,
      crossFadeState:
          !isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          widget.textWidget.copyWith(
            maxLines: isExpanded ? null : widget.textWidget.maxLines,
          ),
          if (shouldShowHelper)
            Positioned(
              child: GestureDetector(
                child: Text(
                  isExpanded ? '' : widget.helperTextList.first,
                  style: widget.helperTextStyle?.copyWith(
                        backgroundColor: widget.backgroundColor,
                      ) ??
                      defaultHelperStyle,
                ),
                onTap: onTap,
              ),
            ),
        ],
      ),
      secondChild: widget.textWidget.toRichText(
        TextSpan(
          text: widget.helperTextList.last,
          style: widget.helperTextStyle?.copyWith(
                backgroundColor: widget.backgroundColor,
              ) ??
              defaultHelperStyle,
          recognizer: TapGestureRecognizer()..onTap = onTap,
          mouseCursor: SystemMouseCursors.click,
        ),
      ),
    );
  }

  AnimatedCrossFade buildDefaultBody() {
    return AnimatedCrossFade(
      firstChild: widget.textWidget.copyWith(softWrap: true),
      secondChild: widget.textWidget.copyWith(maxLines: 999999),
      duration: widget.animationDuration,
      crossFadeState:
          !isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  AnimatedCrossFade buildBodyWithArrow() {
    return AnimatedCrossFade(
      duration: widget.animationDuration,
      crossFadeState:
          !isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: buildChildWithArrow(widget.arrowLocation!, null),
      secondChild: buildChildWithArrow(widget.finalArrowLocation!, 9999999),
    );
  }

  Flex buildChildWithArrow(
    ArrowLocation locationParameter,
    int? maxLineOption,
  ) {
    Widget child = widget.textWidget.copyWith(
      maxLines: isExpanded ? maxLineOption : widget.textWidget.maxLines,
    );

    Axis direction = Axis.horizontal;
    TextDirection textDirection = TextDirection.ltr;
    VerticalDirection verticalDirection = VerticalDirection.up;

    final arrowWidget = Transform(
      transform: isExpanded ? Matrix4.rotationZ(pi) : Matrix4.identity(),
      alignment: Alignment.center,
      child: widget.arrowWidget,
    );

    switch (locationParameter) {
      case ArrowLocation.left:
        child = Expanded(child: child);
        textDirection = TextDirection.rtl;
        break;
      case ArrowLocation.right:
        child = Expanded(child: child);
        break;
      case ArrowLocation.top:
        direction = Axis.vertical;
        break;
      case ArrowLocation.bottom:
        direction = Axis.vertical;
        verticalDirection = VerticalDirection.down;
        break;
      default:
        break;
    }
    return Flex(
      mainAxisSize: MainAxisSize.min,
      direction: direction,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: [child, arrowWidget],
    );
  }
}
