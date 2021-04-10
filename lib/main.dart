import 'package:flutter/material.dart';
import 'dart:async';

void main()=> runApp(StopwatchApp());

class StopwatchApp extends StatefulWidget {
  @override
  _StopwatchAppState createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool IsActive = false;
  Timer timer;

  void HandleTick(){
    if (IsActive == true){
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if (timer == null){
      timer = Timer.periodic(duration, (Timer t) {
        HandleTick();
      });
    }
    int seconds = secondsPassed%60;
    int minutes = secondsPassed~/60;
    int hours = secondsPassed~/(60*60);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue, //changes background for the entire application
        appBar: AppBar(
          backgroundColor: Colors.indigo[800],
          title: Center(child: Text("Stopwatch"),
          ),
        ),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LabelText( // Set hours on the screen
                    label: "Hours", value: hours.toString().padLeft(2, "0"),
                  ),
                  LabelText(
                    label: "Minutes", value: minutes.toString().padLeft(2, "0"),
                  ),
                  LabelText(
                    label: "Seconds", value: seconds.toString().padLeft(2, "0"),
                  ),
                ],
              ),
              SizedBox(height: 60), //Empty space on the screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Container( // Create a stop start button
                    width: 80,
                    height: 47,
                    margin: EdgeInsets.only(top: 30),
                    child: RaisedButton(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: Text(IsActive ? "Stop" : "Start"),
                      onPressed: (){
                        setState(() {
                          IsActive = !IsActive; // On press change active variable from false to true and vice versa
                        });
                      },
                    ),
                  ),
                  Container( // Create a reset button
                    width: 80,
                    height: 47,
                    margin: EdgeInsets.only(top: 30, left: 10),
                    child: RaisedButton(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: Text("Reset"),
                      onPressed: (){
                        setState(() {
                          IsActive = false;
                          secondsPassed = 0;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});
  final String label;
  final String value;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: Colors.amber,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          Text(
            "$value",
            style: TextStyle(
              color: Colors.black,
              fontSize: 45,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "$label",
              style: TextStyle(
                color: Colors.black,
              ),
          ),
        ],
      ),
    );
  }
}



