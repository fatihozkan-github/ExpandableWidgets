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
      data ?? '',
      style: style ?? this.style ?? const TextStyle(color: Colors.black),
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

  RichText toRichText(InlineSpan textSpanList) {
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      softWrap: softWrap ?? true,
      overflow: overflow ?? TextOverflow.ellipsis,
      textScaleFactor: textScaleFactor ?? 1.0,
      maxLines: 999999,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis ?? TextWidthBasis.parent,
      textHeightBehavior: textHeightBehavior,
      text: TextSpan(text: data, style: style ?? const TextStyle(color: Colors.black), children: [textSpanList]),
    );
  }
}
