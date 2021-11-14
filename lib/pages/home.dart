import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:zker_app/pages/setting.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double val = 0;
  int counter = 100;
  @override
  Widget build(BuildContext context) {
    double sizeScreenh = MediaQuery.of(context).size.height;
    double sizeScreenw = MediaQuery.of(context).size.width;
    getData();
    getDataRange();
    return Scaffold(
      appBar: AppBar(
        title: const Text("RAYAN"),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.grey[800],

        ///---------------
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Setting())),
                icon: const Icon(Icons.settings)),
          ),
        ],

        ///---------------
      ),
      backgroundColor: Colors.grey[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SfRadialGauge(
              axes: [
                /////////
                RadialAxis(
                  minimum: 0,
                  maximum: counter.toDouble(),
                  interval: rangeOfCounter(),
                  startAngle: 125,
                  endAngle: 55,
                  showAxisLine: false,
                  showTicks: false,
                  labelOffset: -20,
                  axisLabelStyle: const GaugeTextStyle(color: Colors.white),

                  /////     pointers        ///////
                  pointers: <GaugePointer>[
                    RangePointer(
                      width: 20,
                      value: val,
                      cornerStyle: CornerStyle.endCurve,
                    ),
                    /////////
                  ],
                )
                //////////////////
              ],
            ),
            ////////   Buttom      //////////
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: sizeScreenh * 0.1),
                  child: AnimatedButton(
                    pressEvent: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('val');
                    },
                    width: 60,
                    height: 60,
                    isFixedHeight: false,
                    text: "Clear",
                    buttonTextStyle:const TextStyle(fontSize: 10),
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: sizeScreenw*0.21),
                  child: AnimatedButton(
                    pressEvent: () {
                      if (val >= counter) {
                        return;
                      }
                      setState(() {
                        val += 1;
                      });
                      setDataRane();
                    },
                    width: 170,
                    height: 170,
                    isFixedHeight: false,
                    text: "ADD",
                  ),
                ),
                //---------------------------------
              ],
            )
          ],
        ),
      ),
    );
  }

  //------------------------------
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt("counter") ?? 100;
    });
  }

  //------------------------------
  double rangeOfCounter() {
    switch (counter) {
      case 100:
        return 5;

      case 200:
        return 10;

      case 500:
        return 25;

      case 1000:
        return 50;

      default:
        return 100;
    }
  }

  ///------------ Range val
  setDataRane() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("val", val);
  }

  getDataRange() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      val = prefs.getDouble('val') ?? 0;
    });
  }
}
