import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Notifications.dart';
import 'Parametres.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'Videosurveillance.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  late List<TemperatureData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historique',
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
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            // height: 400,
            //child:

            SfCartesianChart(
              tooltipBehavior: _tooltipBehavior,
              series: <ChartSeries>[
                LineSeries<TemperatureData, double>(
                  dataSource: _chartData,
                  xValueMapper: (TemperatureData temperature, _) =>
                      temperature.temps,
                  yValueMapper: (TemperatureData temperature, _) =>
                      temperature.temperature,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Température moyenne: 30',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Température maximale: 35',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Température minimale: 28',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.fromLTRB(120, 0, 0, 0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Actualiser',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<TemperatureData> getChartData() {
    final List<TemperatureData> chartData = [
      TemperatureData(8, 30.8),
      TemperatureData(12, 35),
      TemperatureData(16, 33),
      TemperatureData(20, 28),
    ];
    return chartData;
  }
}

class TemperatureData {
  late final double temps;
  late final double temperature;
  TemperatureData(this.temps, this.temperature);
}
