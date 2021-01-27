import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideo extends StatefulWidget {
  final Attachment attachment;

  FullScreenVideo({
    Key key,
    @required this.attachment,
  }) : super(key: key);

  @override
  _FullScreenVideoState createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  FlickManager _flickManager;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Builder(
        key: _scaffoldKey,
        builder: (context) {
          return FlickVideoPlayer(
            flickManager: _flickManager,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _flickManager = FlickManager(
        videoPlayerController:
            VideoPlayerController.network(widget.attachment.assetUrl));
  }

  @override
  void dispose() {
    _flickManager?.dispose();
    super.dispose();
  }
}
