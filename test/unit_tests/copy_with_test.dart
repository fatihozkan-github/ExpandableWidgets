import 'package:expandable_widgets/src/extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('copyWith cases', () {
    test('copyWith extension works', () {
      Text _originalText = const Text('testData', style: TextStyle(color: Colors.black));
      Text _copiedText = _originalText.copyWith(softWrap: false, maxLines: 123);
      expect('testData', _copiedText.data);
      expect(false, _copiedText.softWrap);
      expect(123, _copiedText.maxLines);
      expect(_originalText.style, _copiedText.style);
      expect(_originalText.strutStyle, _copiedText.strutStyle);
      expect(_originalText.textAlign, _copiedText.textAlign);
      expect(_originalText.textWidthBasis, _copiedText.textWidthBasis);
    });

    test('copyWith extension works - v2', () {
      Text _originalText = const Text(
        'test data',
        style: TextStyle(color: Colors.white),
        softWrap: true,
        maxLines: 23,
        textWidthBasis: TextWidthBasis.parent,
        textAlign: TextAlign.end,
      );

      Text _copiedText = _originalText.copyWith(softWrap: false, maxLines: 123, style: null);
      expect(_originalText.data, _copiedText.data);
      expect(false, _copiedText.softWrap);
      expect(123, _copiedText.maxLines);
      expect(_originalText.style, _copiedText.style);
      expect(_originalText.strutStyle, _copiedText.strutStyle);
      expect(_originalText.textAlign, _copiedText.textAlign);
      expect(_originalText.textWidthBasis, _copiedText.textWidthBasis);
    });
  });
}
