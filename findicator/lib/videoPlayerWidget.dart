import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget{
  String dataSource;
  VideoPlayerWidget({super.key, required this.dataSource});

  @override
  State<StatefulWidget> createState() => VideoPlayerWidgetState(dataSource: this.dataSource);
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  String dataSource;
  late VideoPlayerController _controller;
  VideoPlayerWidgetState({required this.dataSource});

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(dataSource);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: (){
                  _controller
                      .seekTo(Duration.zero)
                      .then((_) => _controller.play());
                }, icon: const Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: (){
                  _controller.play();
                }, icon: const Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: (){
                  _controller.pause();
                }, icon: const Icon(Icons.pause),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
          ),
        ),
      ],
    );
  }
  
}