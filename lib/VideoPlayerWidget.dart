import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDemo extends StatefulWidget {
  VideoDemo() : super();
  final String title = 'Video Demo';
  @override
  _VideoDemoState createState() => _VideoDemoState();
}

class _VideoDemoState extends State<VideoDemo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  getCurrentUserId() async {
    final User? user = await FirebaseAuth.instance.currentUser;
    ;
    final uid = user!.uid;
    return uid;
  }

  late String uid;

  Future getCurrentUserUrl() async {
    final User? user = await FirebaseAuth.instance.currentUser;
    try {
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      String url = ds['url'];
      return url;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  void initState() {
    if (getCurrentUserUrl() != null) {
      _controller =
          VideoPlayerController.network('${getCurrentUserUrl().toString()}');
    }
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1);
    uid = getCurrentUserId();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(getCurrentUserUrl());
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child:
            Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
