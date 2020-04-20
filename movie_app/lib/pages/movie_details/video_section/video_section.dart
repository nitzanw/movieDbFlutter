import 'package:flutter/material.dart';
import 'package:movieapp/models/detailed_movie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoSection extends StatefulWidget {
  const VideoSection({Key key, this.videos}) : super(key: key);
  final Videos videos;

  static Widget create(BuildContext context, Videos videos) {
    return VideoSection(
      videos: videos,
    );
  }

  @override
  _VideoSectionState createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = widget.videos.results
        .map<YoutubePlayerController>(
          (video) => YoutubePlayerController(
            initialVideoId: video.key,
            flags: YoutubePlayerFlags(
              disableDragSeek: true,
              autoPlay: false,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: YoutubePlayer(
            width: 200,
            key: widget.key,
            controller: _controllers[index],
            actionsPadding: EdgeInsets.only(left: 16.0),
          ),
        );
      },
      itemCount: _controllers.length,
    );
  }
}
