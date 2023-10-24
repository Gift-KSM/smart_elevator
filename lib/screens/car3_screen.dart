import 'dart:async';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:smartlift/models/status_item.dart';

import 'car2_screen.dart';
import 'car4_screen.dart';
import 'door_screen.dart';
import "package:smartlift/constants.dart";
import "package:smartlift/global.dart";

// ignore: must_be_immutable
class Car3Screen extends StatefulWidget {
  final StatusItem? status;
  const Car3Screen({Key? key, this.status}) : super(key: key);

  @override
  State<Car3Screen> createState() => _Car3ScreenState();
}

class _Car3ScreenState extends State<Car3Screen> {
  StatusItem? status;
  Timer? timer;

  @override
  void deactivate() {
    timer!.cancel();
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      status = widget.status!;
    });
    timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      StatusItem? status1 =
          await StatusItem.getStatus(status!.iLiftID.toString());
      setState(() {
        status = status1;
      });
    });
  }

  @override
  build(BuildContext context) {

  final ST_1 = TextStyle(fontSize: 34, fontWeight: FontWeight.w400, 
  color: checkLevel(status!.szCarStatus!, 1)
                            ? Colors.blue
                            : Colors.white,);
  final ST_2 = TextStyle(fontSize: 34,fontWeight: FontWeight.w400,color: Color.fromARGB(255, 255, 255, 255));

  final color_1 = Color.fromRGBO(26, 61, 97, 0.624);
  final Bg_color = Color.fromRGBO(0, 23, 33, 1);
  final Text_color = Colors.white;

  final main_1 = MainAxisAlignment.spaceEvenly;
  final Align_1 = Alignment.center;

  final Box_1 = BoxDecoration(
      color: color_1,
      borderRadius: BorderRadius.circular(6),
       border: Border.all(
                    color: checkLevel(status!.szCarStatus!, 1)
                            ? Colors.blue
                            : color_1,
                    width: 2,
                  ));
  
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  double width_1 = screenWidth * 0.12;
  double height_2 = screenHeight * 0.12;

  double w1 = screenWidth * 0.016;
  double h2 = screenHeight * 0.012;

  final UpdownIcon = IconButton(
        icon: checkUpDownArrow(status!.szLiftState!), onPressed: () {});
    final Floor_Text = Text(status!.ltLevelName![checkCurrentFloor(status!.szLiftState!) - 1]);

    final DoorIcon =
        IconButton(icon: checkDoorIcon(status!.szLiftState!), onPressed: () {});
    final Door_Text = Text(checkDoorText(status!.szLiftState!));

    final SpeedIcon =
        IconButton(icon: const Icon(Icons.bolt), onPressed: () {});
    final Speed_Text = Text(checkSpeed(status!.szLiftState!));

    final ErrorIcon =
        IconButton(icon: const Icon(Icons.report_problem), onPressed: () {});
    final Error_Text = Text(checkError(status!.szLiftState!));

    final Container_UP_Down = Container(
      height: width_1,
      width: height_2,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: UpdownIcon,
          ),
          Expanded(
            child: Floor_Text,
          ),
        ],
      ),
    );
    final Container_Door = Container(
      height: width_1,
      width: height_2,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: DoorIcon,
          ),
          Expanded(
            child: Door_Text,
          ),
        ],
      ),
    );
    final Container_Speed = Container(
      height: width_1,
      width: height_2,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: SpeedIcon,
          ),
          Expanded(
            child: Speed_Text,
          ),
        ],
      ),
    );
    final Container_Error = Container(
      height: width_1,
      width: height_2,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
           child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ErrorIcon,
          ),
          Expanded(
            child: Error_Text,
          ),
        ],
      ),
    );

    return GestureDetector(       onHorizontalDragUpdate: (details) {
        if (details.delta.direction <= 0) {
          Navigator.pop(context);
          //push door screen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Car2Screen(
                        status: status,
                      )));
        }
        if (details.delta.direction > 0 && status!.iMaxLevel! > 36) {
          Navigator.pop(context);
          //push door screen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Car4Screen(
                        status: status,
                      )));
        }
      },
      child: Scaffold(
        backgroundColor: Bg_color,
        appBar: AppBar(
          title: const Text("SELECTION"),
          centerTitle: true,
          backgroundColor: Bg_color,
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
          Expanded(
            flex: 1,
              child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
                  Container_UP_Down,
                  const Spacer(),
                  Container_Door,
                  const Spacer(),
                  Container_Speed,
                  const Spacer(),
                  Container_Error,
                  const Spacer(),
                ]),
                
          )),
                Expanded(
                  child:
                    Text(
                      status!.szLiftName!,
                      style: ST_2,
                    )
                  
                ),

                SizedBox(height: h2),
                Row(
                  mainAxisAlignment: main_1,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await StatusItem.addCall(
                              status!.iLiftID!.toString(), "C", "1", "zxcvd");
                        },
                        child: Container(
                          width: width_1,
                          height: height_2,
                          decoration: Box_1,
                          child: Align(
                            alignment: Align_1,
                            child: Text("1", style: 
                            ST_1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: w1),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await StatusItem.addCall(
                              status!.iLiftID!.toString(), "C", "1", "zxcvd");
                        },
                        child: Container(
                          width: width_1,
                          height: height_2,
                          decoration: Box_1,
                          child: Align(
                            alignment: Align_1,
                            child: Text("2", style: ST_1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: w1),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await StatusItem.addCall(
                              status!.iLiftID!.toString(), "C", "3", "zxcvd");
                        },
                        child: Container(
                          width: width_1,
                          height: height_2,
                          decoration: Box_1,
                          child: Align(
                            alignment: Align_1,
                            child: Text("3", style: ST_1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: h2),
                Row(
                  mainAxisAlignment: main_1,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await StatusItem.addCall(
                              status!.iLiftID!.toString(), "C", "4", "zxcvd");
                        },
                        child: Container(
                          width: width_1,
                          height: height_2,
                          decoration: Box_1,
                          child: Align(
                            alignment: Align_1,
                            child: Text("4", style: ST_1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w1,
                    ),
                    if (status!.iMaxLevel! > 4)
                      if (status!.iMaxLevel! > 4)
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await StatusItem.addCall(
                                  status!.iLiftID!.toString(),
                                  "C",
                                  "5",
                                  "zxcvd");
                            },
                            child: Container(
                              width: width_1,
                              height: height_2,
                              decoration: Box_1,
                              child: Align(
                                alignment: Align_1,
                                child: Text("5", style: ST_1),
                              ),
                            ),
                          ),
                        ),
                    SizedBox(
                      width: w1,
                    ),
                    if (status!.iMaxLevel! > 5)
                      if (status!.iMaxLevel! > 5)
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await StatusItem.addCall(
                                  status!.iLiftID!.toString(),
                                  "C",
                                  "6",
                                  "zxcvd");
                            },
                            child: Container(
                              width: width_1,
                              height: height_2,
                              decoration: Box_1,
                              child: Align(
                                alignment: Align_1,
                                child: Text("6", style: ST_1),
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
                SizedBox(height: h2),
                if (status!.iMaxLevel! > 6)
                  if (status!.iMaxLevel! > 6)
                    Row(
                      mainAxisAlignment: main_1,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await StatusItem.addCall(
                                  status!.iLiftID!.toString(),
                                  "C",
                                  "7",
                                  "zxcvd");
                            },
                            child: Container(
                              width: width_1,
                              height: height_2,
                              decoration: Box_1,
                              child: Align(
                                alignment: Align_1,
                                child: Text("7", style: ST_1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: w1,
                        ),
                        if (status!.iMaxLevel! > 7)
                          if (status!.iMaxLevel! > 7)
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await StatusItem.addCall(
                                      status!.iLiftID!.toString(),
                                      "C",
                                      "8",
                                      "zxcvd");
                                },
                                child: Container(
                                  width: width_1,
                                  height: height_2,
                                  decoration: Box_1,
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text("8", style: ST_1),
                                  ),
                                ),
                              ),
                            ),
                        SizedBox(width: w1),
                        if (status!.iMaxLevel! > 8)
                          if (status!.iMaxLevel! > 8)
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await StatusItem.addCall(
                                      status!.iLiftID!.toString(),
                                      "C",
                                      "9",
                                      "zxcvd");
                                },
                                child: Container(
                                  width: width_1,
                                  height: height_2,
                              decoration: Box_1,
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text("9", style: ST_1),
                                  ),
                                ),
                              ),
                            )
                      ],
                    ),
                SizedBox(height: h2),
                if (status!.iMaxLevel! > 9)
                  if (status!.iMaxLevel! > 9)
                    Row(
                      mainAxisAlignment: main_1,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await StatusItem.addCall(
                                  status!.iLiftID!.toString(),
                                  "C",
                                  "10",
                                  "zxcvd");
                            },
                            child: Container(
                              width: width_1,
                              height: height_2,
                              decoration: Box_1,
                              child: Align(
                                alignment: Align_1,
                                child: Text("10", style: ST_1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: w1,
                        ),
                        if (status!.iMaxLevel! > 10)
                          const SizedBox(height: 20.0),
                        if (status!.iMaxLevel! > 10)
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await StatusItem.addCall(
                                    status!.iLiftID!.toString(),
                                    "C",
                                    "11",
                                    "zxcvd");
                              },
                              child: Container(
                                width: width_1,
                                height: height_2,
                                decoration: Box_1,
                                child: Align(
                                  alignment:Align_1,
                                  child: Text("11", style: ST_1),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          width: w1,
                        ),
                        if (status!.iMaxLevel! > 11)
                          if (status!.iMaxLevel! > 11)
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await StatusItem.addCall(
                                      status!.iLiftID!.toString(),
                                      "C",
                                      "12",
                                      "zxcvd");
                                },
                                child: Container(
                                  width: width_1,
                                  height: height_2,
                                  decoration: Box_1,
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text("12", style: ST_1),
                                  ),
                                ),
                              ),
                            )
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
