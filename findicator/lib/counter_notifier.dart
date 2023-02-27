import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findicator/counter_data.dart';

class CounterNotifier extends StateNotifier<CounterData> {
  CounterNotifier()
      : super(const CounterData(
      receiveMessage: '',
      receiveCounter: 0,
      flutterName: '',
      sendMessage: ''));

  // 受信データ
  void setNativeData(String receiveMessage, int receiveCounter) {
    state = CounterData(
        receiveMessage: receiveMessage,
        receiveCounter: receiveCounter,
        flutterName: state.flutterName,
        sendMessage: state.sendMessage);
  }

  // 送信データ
  void setFlutterData(String flutterName, String sendMessage) {
    state = CounterData(
        receiveMessage: state.receiveMessage,
        receiveCounter: state.receiveCounter,
        flutterName: flutterName,
        sendMessage: sendMessage);
  }
}