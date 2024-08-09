import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayerCard extends StatefulWidget {
  const YoutubeVideoPlayerCard(
      {super.key,
      this.url,
      this.borderRadius,
      this.showControls,
      this.onCompleted,
      this.aspectRatio,
      this.backGroundColor,
      this.autoPlayVideo,
      this.index,
      this.disableDragSeek});

  final int? index;
  final String? url;
  final double? borderRadius;
  final bool? showControls;
  final bool? backGroundColor;

  final bool? autoPlayVideo;
  final bool? disableDragSeek;
  final double? aspectRatio;
  final GestureTapCallback? onCompleted;

  @override
  State<YoutubeVideoPlayerCard> createState() => _YoutubeVideoPlayerCardState();
}

class _YoutubeVideoPlayerCardState extends State<YoutubeVideoPlayerCard>
    with AutomaticKeepAliveClientMixin {
  late int? index = widget.index;
  late double? borderRadius = widget.borderRadius;
  late bool showControls = widget.showControls ?? false;

  late bool autoPlayVideo = widget.autoPlayVideo ?? false;
  late bool disableDragSeek = widget.disableDragSeek ?? false;
  late GestureTapCallback? onCompleted = widget.onCompleted;

  YoutubePlayerController? controller;
  late String? url = widget.url;
  bool _isPlayerReady = false;

  initPlayer() {
    try {
      controller = YoutubePlayerController(
        initialVideoId: '${YoutubePlayer.convertUrlToId('$url')}',
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: autoPlayVideo,
          disableDragSeek: disableDragSeek,
          loop: false,
          hideControls: !showControls,
          showLiveFullscreenButton: false,
          // showFullscreenButton: false,
          // showPlaybackSpeedButton: false,
          isLive: false,
          forceHD: false,
          useHybridComposition: false,
          enableCaption: false,
        ),
      )..addListener(listener);
      // controller?.pause();
    } catch (e, s) {
      print("${e.toString()}${s.toString()}");
    }
    debugPrint('Loading ytVideoPlayer...');
  }

  void listener() {
    if (_isPlayerReady && mounted && controller?.value.isFullScreen == false) {
      setState(() {
        // _playerState = controller?.value.playerState;
        // _videoMetaData = controller?.metadata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  void deactivate() {
    controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VisibilityDetector(
      key: Key('youtubeVideoPlayer_${index ?? 0}'),
      onVisibilityChanged: (visibility) async {
        var visiblePercentage = visibility.visibleFraction * 100;
        if (visiblePercentage >= 0.80 && mounted) {
          isVisible = true;
          if (autoPlayVideo == true) {
            controller?.play();
          }
        } else {
          isVisible = false;
          controller?.pause();
        }
        if (context.mounted) {
          setState(() {});
        }
      },
      child: controller != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: showControls == false
                    ? () async {
                        PlayerState? playerState =
                            controller?.value.playerState;
                        if (playerState == PlayerState.playing) {
                          controller?.pause();
                        } else {
                          controller?.play();
                        }
                        setState(() {});
                      }
                    : null,
                child: YoutubePlayer(
                  controller: controller!,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    _isPlayerReady = true;
                  },
                  onEnded: (metaData) {
                    controller?.seekTo(const Duration(milliseconds: 0));
                    controller?.pause();
                    onCompleted?.call();
                  },
                  // topActions: <Widget>[
                  //   const SizedBox(width: 8.0),
                  //   Expanded(
                  //     child: Text(
                  //       controller?.metadata.title ?? '',
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 18.0,
                  //       ),
                  //       overflow: TextOverflow.ellipsis,
                  //       maxLines: 1,
                  //     ),
                  //   ),
                  //   IconButton(
                  //     icon: const Icon(
                  //       Icons.settings,
                  //       color: Colors.white,
                  //       size: 25.0,
                  //     ),
                  //     onPressed: () {
                  //       log('Settings Tapped!');
                  //     },
                  //   ),
                  // ],
                  // aspectRatio: widget.aspectRatio ?? 16 / 9,
                ),
              ),
            )
          : AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const CupertinoActivityIndicator(
                    radius: 18, color: Colors.white),
              ),
            ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// class VideoPositionIndicator extends StatefulWidget {
//   const VideoPositionIndicator({
//     super.key,
//     required this.controller,
//     this.onCompleted,
//   });
//
//   final YoutubePlayerController? controller;
//   final GestureTapCallback? onCompleted;
//
//   @override
//   State<VideoPositionIndicator> createState() => _VideoPositionIndicatorState();
// }
//
// class _VideoPositionIndicatorState extends State<VideoPositionIndicator> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<PlayerState>(
//       stream: widget.controller?.,
//       initialData: const YoutubeVideoState(),
//       builder: (context, snapshot) {
//         Duration? position = snapshot.data?.position;
//         final currentPosition = position?.inSeconds ?? 0;
//
//         return StreamBuilder(
//           stream: widget.controller?.value. .duration.asStream(),
//           builder: (context, snapshot ) {
//             if (snapshot.hasData) {
//               int? totalDuration = snapshot.data?.toInt();
//               Duration duration = Duration(seconds: (totalDuration ?? 0).toInt());
//               bool isCompleted = ((currentPosition == totalDuration) && currentPosition > 0);
//
//               if (isCompleted) {
//                 WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                   widget.onCompleted?.call();
//                   widget.controller?.nextVideo();
//                 });
//               }
//               return Container(
//                 decoration: BoxDecoration(color: isCompleted ? Colors.green : null),
//                 child: Column(
//                   children: [
//                     LinearProgressIndicator(
//                       value: totalDuration == 0 ? 0 : currentPosition / (totalDuration ?? 0),
//                       minHeight: 1,
//                       color: isCompleted ? Colors.white : Colors.green,
//                     ),
//                     // Padding(
//                     //   padding: const EdgeInsets.only(bottom: 4, top: 4, left: 4, right: 4),
//                     //   child: Row(
//                     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //     children: [
//                     //       Text(
//                     //         '$currentPosition sec',
//                     //         style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
//                     //       ),
//                     //       if (isCompleted) const Text('Completed'),
//                     //       Text(
//                     //         '$totalDuration sec',
//                     //         style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               );
//             } else {
//               return const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Loading... ',
//                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
//                   ),
//                   CupertinoActivityIndicator(),
//                 ],
//               );
//             }
//           },
//         );
//       },
//):
//
//
