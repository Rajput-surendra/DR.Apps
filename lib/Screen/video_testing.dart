import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
class VideoThumbnailScreen extends StatefulWidget {
  @override
  _VideoThumbnailScreenState createState() => _VideoThumbnailScreenState();
}

class _VideoThumbnailScreenState extends State<VideoThumbnailScreen> {
   late VideoPlayerController _videoPlayerController;
  bool _showThumbnail = true;

  @override
  void initState() {
    super.initState();
    // Replace 'video_url_here' with the actual URL of your video
    _videoPlayerController = VideoPlayerController.network('https://developmentalphawizz.com/dr_booking/uploads/media/2023/WhatsApp_Video_2023-06-14_at_12_44_09_PM.mp4')
      ..initialize().then((_) {
        // Set the video to loop to keep showing the thumbnail
        _videoPlayerController.setLooping(true);
        setState(() {
          _showThumbnail = true;
        });
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Thumbnail Example'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _showThumbnail
                ? Image.network(
              'https://developmentalphawizz.com/dr_booking/uploads/media/2023/Is-Sensodyne-world’s-no-1-sensitivity-toothpaste-2_(1).jpg',
              // Replace 'thumbnail_url_here' with the actual URL of the thumbnail image
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )
                : VideoPlayer(_videoPlayerController),
            _showThumbnail
                ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _showThumbnail = false;
                  _videoPlayerController.play();
                });
              },
              child: Icon(Icons.play_arrow),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
