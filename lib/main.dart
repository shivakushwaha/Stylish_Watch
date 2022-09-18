// import 'dart:async';
// import 'dart:html';
import 'dart:async';

import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stylish Watch',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  String timetodisplay = "0:0";
  int time_for_display = 0;
  final dur = const Duration(seconds: 1);
  bool cancletimer = false;

  bool Started = true;
  bool Stoped = true;
  @override
  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  void Secondtomin(int time) {
    if (time >= 3600) {
      String hours = (time ~/ 3600).toString();
      String minuts = ((time % 3600) ~/ 60).toString();
      String seconds = (time % 60).toString();
      timetodisplay = (hours + ":" + minuts + ":" + seconds).toString();
    } else {
      String minuts = (time ~/ 60).toString();
      String seconds = (time % 60).toString();
      timetodisplay = (minuts + ":" + seconds).toString();
    }
  }

  bool flag = false;

  void Start() {
    setState(() {
      Started = false;
      Stoped = false;
      cancletimer = false;
    });

    time_for_display = ((hour * 3600) + (min * 60) + sec);
    Timer.periodic(dur, (Timer t) {
      setState(() {
        if (flag == true) {
          flag = false;
        } else if (time_for_display == 0 || cancletimer == true) {
          t.cancel();
        } else {
          time_for_display = time_for_display - 1;
          Secondtomin(time_for_display);
          // timetodisplay = time_for_display.toString();
        }
      });
    });
  }

  String resum = "";
  void ResetTimer() {
    // timetodisplay =
    setState(() {
      Stop();
      timetodisplay = "0:0";
      hour = 0;
      min = 0;
      sec = 0;
    });
  }

  void Stop() {
    setState(() {
      Started = true;
      Stoped = true;
      resum = timetodisplay;
      flag = true;
      cancletimer = true;
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "HH",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    NumberPicker(
                      minValue: 0,
                      maxValue: 23,
                      value: hour,
                      itemWidth: 60,
                      onChanged: (val) {
                        setState(() {
                          hour = val;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "MM",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        value: min,
                        itemWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            min = val;
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "SS",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        value: sec,
                        itemWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                          });
                        })
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              timetodisplay,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green),
                  ),
                  onPressed: Started ? Start : null,
                  child: const Text(
                    "Start",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    // padding: EdgeInsets.all(20.0),
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green),
                  ),
                  onPressed: Stoped ? null : Stop,
                  child: const Text(
                    " Stop ",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green),
                  ),
                  onPressed: ResetTimer,
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool sstop = true;
  bool sstart = true;
  bool sreset = true;
  String timertext = "00:00:00";
  var swatch = Stopwatch();

  void startStopwath() {
    setState(() {
      sstop = false;
      sstart = false;
      sreset = false;
    });
    Timer.periodic(
      dur,
      (timer) {
        setState(() {
          timertext =
              "${swatch.elapsed.inHours.toString().padLeft(2, "0")}:${(swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0")}:${swatch.elapsed.inSeconds % 60}";
        });
      },
    );
    swatch.start();
  }

  void stopStapwath() {
    setState(() {
      sstart = true;
      sstop = true;
    });
    swatch.stop();
  }

  void resetStapwath() {
    setState(() {
      sstart = true;
      sstop = true;
    });
    swatch.reset();
    swatch.stop();
  }

  Widget Stapwatch() {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                timertext,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // maximumSize: Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: sstop ? null : stopStapwath,
                        child: const Text(
                          "Stop",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          maximumSize: Size(100, 60),
                          primary: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: sreset ? null : resetStapwath,
                        child: const Text(
                          "Reset",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shadowColor: Colors.greenAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      minimumSize: Size(200, 50), //////// HERE
                    ),
                    onPressed: sstart ? startStopwath : null,
                    child: const Text(
                      "Start",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Watch",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: TabBar(
          tabs: const [
            // Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              "Timer",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            Text(
              "Stapwatch",
              style: TextStyle(
                fontSize: 18.0,
              ),
            )
          ],
          labelPadding: const EdgeInsets.only(bottom: 20.0),
          labelStyle: const TextStyle(
            fontSize: 18.0,
          ),
          unselectedLabelColor: Colors.white54,
          controller: tb,
        ),
      ),
      body: TabBarView(
        controller: tb,
        children: [timer(), Stapwatch()],
      ),
    );
  }
}
