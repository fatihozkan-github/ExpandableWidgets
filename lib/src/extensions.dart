import 'package:flutter/material.dart';

extension TextExtensions on Text {
  Text copyWith({
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return Text(
      this.data ?? '',
      style: style ?? this.style ?? TextStyle(color: Colors.black),
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
    );
  }

  bool hasOverflow(double width) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: data, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: width);
    return textPainter.didExceedMaxLines;
  }

  RichText toRichText(InlineSpan textspanList) {
    return RichText(
      textAlign: this.textAlign ?? TextAlign.start,
      textDirection: this.textDirection,
      softWrap: this.softWrap ?? true,
      overflow: this.overflow ?? TextOverflow.ellipsis,
      textScaleFactor: this.textScaleFactor ?? 1.0,
      maxLines: 999999,
      locale: this.locale,
      strutStyle: this.strutStyle,
      textWidthBasis: this.textWidthBasis ?? TextWidthBasis.parent,
      textHeightBehavior: this.textHeightBehavior,
      text: TextSpan(text: data, style: style ?? TextStyle(color: Colors.black), children: [textspanList]),
    );
  }
}
