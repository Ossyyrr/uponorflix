import 'package:flutter/material.dart';
import 'package:uponorflix/domain/model/movie.dart';
import 'package:uponorflix/presentation/video/widget/movie_details.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final Movie movie;
  const VideoScreen({super.key, required this.movie});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.movie.trailerUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: false,
            width: double.infinity,
            aspectRatio: MediaQuery.of(context).size.aspectRatio,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MovieDetails(widget: widget),
          ),
        ],
      ),
    );
  }
}
