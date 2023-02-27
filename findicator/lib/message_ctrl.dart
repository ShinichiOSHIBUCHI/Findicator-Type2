import 'dart:convert';
import 'dart:ui';
import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:findicator/test_contents.dart';

import 'package:flutter/material.dart';
import 'package:findicator/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findicator/counter_repository.dart';

import 'package:audiofileplayer/audiofileplayer.dart';

final CounterRepository counterRepository = CounterRepository();
dynamic _ref;
PageController controller = PageController(viewportFraction: 0.8);
int scene = 0;

class MessageCtrl extends ConsumerWidget {
  const MessageCtrl({Key? key}) : super(key: key);

  void sendMessage() {
    final counterNotifier = _ref.read(counterProvider.notifier);
    if (isLoading == false) {
      counterRepository.setMessageHandler(counterNotifier);
      counterRepository.sendMsgToNative(counterNotifier, sendMessageData);
      isLoading = true;
    }
  }

  void animateToPage() {
    controller.animateToPage(scene, duration:const Duration(milliseconds: 500), curve: Curves.linear);
    if (scene == 1) {
      redAlert = true;
      Audio.load('assets/se/warning2.mp3')
        ..play()
        ..dispose();
    } else if(scene == 5) {
      allGreen = true;
    } else {
      redAlert = false;
      allGreen = false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;
    final data = ref.watch(counterProvider);
    String receiveData = data.receiveMessage.toString();

    dynamic jsonData;
    if (receiveData != "") {
      jsonData = json.decode(receiveData);
      scene = int.parse(jsonData["recommend"][0]["data"]);
    } else {
      scene = 0;
    }

    return CubePageView.builder(
      controller: controller,
      itemCount: pages.length,
      itemBuilder: (context, index, notifier) {
        final transform = Matrix4.identity();
        final t = (index - notifier).abs();
        final scale = lerpDouble(1.5, 0, t);
        transform.scale(scale, scale);
        return CubeWidget(
            index: index,
            pageNotifier: notifier,
            child: Stack(
              children: [
                pages[index]
              ],
            ),
        );
      },
    );
  }
 }
