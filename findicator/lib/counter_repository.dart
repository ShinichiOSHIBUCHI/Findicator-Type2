import 'package:flutter/services.dart';

class CounterRepository {
  static const _channel = BasicMessageChannel<dynamic>(
      'samples.flutter.dev/counter', StandardMessageCodec());

  void setMessageHandler(notifier) {
    _channel.setMessageHandler((message) async {
      var name = message['name'] as String;
      var counter = message['counter'] as int;
      notifier.setNativeData(name, counter);
      print('[Msg From Native] = Name:$name, Message:$counter');
      return 'Hey, $name! Your counter is : $counter';
    });
  }
//Kotlinへの送信処理
  void sendMsgToNative(notifier, messageData) async {
    final reply = await _channel.send(<String, dynamic>{
      'name': 'Flutter',
      'message': '$messageData',
    });
    notifier.setFlutterData('Flutter', messageData);
    print(reply);
  }
}