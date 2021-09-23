import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphData extends StatefulWidget {
  GraphData() : super();
  @override
  _GraphDataState createState() => _GraphDataState();
}

class _GraphDataState extends State<GraphData> {
  late List<TemperatureData> _chartData = [];
  late TooltipBehavior _tooltipBehavior;

  Future<String> getCurrentUID() async {
    final String id = (await FirebaseAuth.instance.currentUser)!.uid.toString();
    return id;
  }

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    getCurrentUID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUserstempStreamSnapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        Widget widget;
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        List<TemperatureData> chartData = <TemperatureData>[];
        Map<String, dynamic> data = snapshot.data! as Map<String, dynamic>;
        for (int index = 0; index < data.length; index++) {
          TemperatureData temp = TemperatureData.fromJson(data);
          chartData.add(temp);
        }
        widget = Container(
          child: Wrap(
            children: [
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
                  style: ElevatedButton.styleFrom(primary: Colors.red[600]),
                ),
              )
            ],
          ),
        );
        return widget;
      },
    );
  }

  Stream<QuerySnapshot> getUserstempStreamSnapshots() async* {
    final String uid = await getCurrentUID();
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('temp')
        .snapshots();
  }

  List<TemperatureData> getChartData() {
    return _chartData;
  }
}

class TemperatureData {
  late final double? temps;
  late final double? temperature;
  TemperatureData({this.temps, this.temperature});
  factory TemperatureData.fromJson(Map<String, dynamic> json) {
    return TemperatureData(
        temps: json['date'], temperature: json['temperature']);
  }
}
