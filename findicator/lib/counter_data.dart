import 'package:flutter/material.dart';

@immutable
class CounterData {
  final String? receiveMessage;
  final int? receiveCounter;
  final String? flutterName;
  final String? sendMessage;
  const CounterData(
      {required this.receiveMessage,
        required this.receiveCounter,
        required this.flutterName,
        required this.sendMessage});
}