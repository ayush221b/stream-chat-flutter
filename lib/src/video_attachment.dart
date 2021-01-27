import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/src/full_screen_video.dart';
import 'package:stream_chat_flutter/src/utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:video_player/video_player.dart';

import 'attachment_error.dart';
import 'attachment_title.dart';

class VideoAttachment extends StatefulWidget {
  final Attachment attachment;
  final MessageTheme messageTheme;
  final Size size;

  VideoAttachment({
    Key key,
    @required this.attachment,
    @required this.messageTheme,
    this.size,
  }) : super(key: key);

  @override
  _VideoAttachmentState createState() => _VideoAttachmentState();
}

class _VideoAttachmentState extends State<VideoAttachment> {
  FlickManager _flickManager;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenVideo(
              attachment: widget.attachment,
            ),
          ),
        );
      },
      child: Container(
        height: widget.size?.height,
        width: widget.size?.width,
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: FittedBox(
                fit: BoxFit.cover,
                child: Stack(
                  children: <Widget>[
                    FlickVideoPlayer(
                      flickManager: _flickManager,
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Material(
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(Icons.play_arrow),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.attachment.title != null)
              Material(
                color: widget.messageTheme.messageBackgroundColor,
                child: AttachmentTitle(
                  messageTheme: widget.messageTheme,
                  attachment: widget.attachment,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _flickManager = FlickManager(
        autoPlay: false,
        videoPlayerController:
            VideoPlayerController.network(widget.attachment.assetUrl));
  }

  @override
  void dispose() {
    _flickManager?.dispose();
    super.dispose();
  }
}
