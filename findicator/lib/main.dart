import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:findicator/counter_notifier.dart';
import 'package:findicator/counter_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findicator/message_ctrl.dart';
import 'package:findicator/camera_wipe.dart';

import 'package:audiofileplayer/audiofileplayer.dart';

final counterProvider =
  StateNotifierProvider<CounterNotifier, CounterData>((ref) {
    return CounterNotifier();
  });
List<CameraDescription> cameras = [];
String sendMessageData =  '';
bool isLoading = false;
bool redAlert = false;
bool allGreen = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Findicator type2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var contentNo = 0;
  var messageCtrl = const MessageCtrl();
  var cameraWipe = const CameraWipe();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 2;
    //final width = MediaQuery.of(context).size.width * 0.8;
    final width = height;
    CameraDescription camera = cameras.first;
    CameraController cameraController = CameraController(camera, ResolutionPreset.high);
    Future<void> initializeControllerFuture = cameraController.initialize();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              children:[
                SizedBox(
                    height: height,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: FutureBuilder<void>(
                        future: initializeControllerFuture,
                        builder: (context, snapshot){
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Stack(
                              children: [
                                SizedBox(
                                  height: height,
                                  width: width,
                                  child: CameraPreview(cameraController),
                                ),
                                Opacity(
                                  opacity: redAlert? 0.5 : 0.0,
                                  child: Container(
                                    color: Colors.red,
                                    child: null,
                                  ),
                                ),
                                Opacity(
                                  opacity: allGreen? 0.5 : 0.0,
                                  child: Container(
                                    color: Colors.green,
                                    child: null,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width: width * 0.3,
                                    height: height * 0.3,
                                    child: cameraWipe,
                                  ),
                                ),
                                Positioned(
                                  left: 5,
                                  bottom: 5,
                                  child: Container(
                                    decoration: const BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.black45,
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                      ),
                                    ]),
                                    child: const Text("対象を撮影してください"),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                      )
                    )
                ),
                SizedBox(
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: messageCtrl,
                  ),
                ),
              ]
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            // 写真を撮る
            final image = await cameraController.takePicture();
            Uint8List imagebytes = await image.readAsBytes(); //convert to bytes
            var base64Data = base64.encode(imagebytes); //convert bytes to base64 string
            sendMessageData = base64Data;
            isLoading = false;
            Audio.load('assets/se/shot2.mp3')..play()..dispose();
            setState(() {
              cameraWipe.imagePath = image.path;
            });
            messageCtrl.sendMessage();
            messageCtrl.animateToPage();
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
