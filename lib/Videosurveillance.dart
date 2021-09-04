import 'package:flutter/material.dart';
import 'Notifications.dart';
import 'Parametres.dart';
import 'Graph.dart';
import 'VideoPlayerWidget.dart';

class VideoSurveillance extends StatefulWidget {
  @override
  _VideoSurveillanceState createState() => _VideoSurveillanceState();
}

class _VideoSurveillanceState extends State<VideoSurveillance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Videosurveillance',
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Vidéosurveillance'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new VideoSurveillance()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Historique'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Graph()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Notifications'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Notifications()));
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Paramètres'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Parametres()));
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: VideoDemo(),
    );
  }
}
