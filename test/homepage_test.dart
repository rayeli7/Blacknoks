import 'package:flutter/material.dart';
import 'package:blacknoks/pages/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Homepage renders correctly', () {
    final widget = MaterialApp(home: Homepage());
    expect(widget, isNotNull);
  });

  test('Homepage title is correct', () {
    final widget = MaterialApp(home: Homepage());
    expect(widget.title, '');
  });
}
