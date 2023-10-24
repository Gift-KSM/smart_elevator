import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:smartlift/models/status_item.dart';
import 'car3_screen.dart';
import 'car_screen.dart';
import 'door_screen.dart';
import "package:smartlift/constants.dart";
import "package:smartlift/global.dart";

class Car2Screen extends StatefulWidget {
  final StatusItem? status;
  const Car2Screen({Key? key, this.status}) : super(key: key);

  @override
  State<Car2Screen> createState() => _Car2ScreenState();
}

class _Car2ScreenState extends State<Car2Screen> {
  StatusItem? status;
  Timer? timer;
  int? iLevel;

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
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      StatusItem? status1 =
          await StatusItem.getStatus(status!.iLiftID.toString());
      setState(() {
        status = status1;
      });
    });
  }

  @override
  build(BuildContext context) {
    final ST_2 = TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        color: Color.fromARGB(255, 255, 255, 255));

    final color_1 = Colors.greenAccent;
    final color_2 = Color.fromRGBO(0, 23, 33, 1);
    final Bg_color = Color.fromRGBO(0, 23, 33, 1);
    final Text_color = Colors.white;

    final main_1 = MainAxisAlignment.spaceEvenly;
    final Align_1 = Alignment.center;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double width_1 = screenWidth * 0.01;
    double height_2 = screenHeight * 0.12;

    double Icon_w = screenWidth * 0.20;
    double Icon_H = screenHeight * 0.12;

    double w1 = screenWidth * 0.016;
    double h2 = screenHeight * 0.012;
    double distances = screenHeight * 0.05;

    final UpdownIcon = IconButton(
      icon: checkUpDownArrow(status!.szLiftState!),
      onPressed: () {},
      color: const Color.fromARGB(255, 0, 0, 0),
      iconSize: 30,
    );
    final Floor_Text = Text(
      status!.ltLevelName![checkCurrentFloor(status!.szLiftState!) - 1],
      style: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 20,
          fontWeight: FontWeight.w700),
    );

    final DoorIcon = IconButton(
      icon: checkDoorIcon(status!.szLiftState!),
      onPressed: () {},
      color: const Color.fromARGB(255, 0, 0, 0),
    );
    final Door_Text = Text(checkDoorText(status!.szLiftState!),
        style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.w700));

    final SpeedIcon = IconButton(
      icon: const Icon(Icons.bolt),
      onPressed: () {},
      color: const Color.fromARGB(255, 0, 0, 0),
    );
    final Speed_Text = Text(checkSpeed(status!.szLiftState!),
        style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.w700));

    final ErrorIcon = IconButton(
      icon: const Icon(Icons.report_problem),
      onPressed: () {},
      color: const Color.fromARGB(255, 0, 0, 0),
    );
    final Error_Text = Text(checkError(status!.szLiftState!),
        style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.w700));

    final Container_UP_Down = Container(
      height: Icon_H,
      width: Icon_w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.greenAccent,
        // border: Border.all(
        //                     color:
        //                        Colors.greenAccent,

        //                     width: 2,
        //                   )
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
      height: Icon_H,
      width: Icon_w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.greenAccent,
        // border: Border.all(
        //                     color:
        //                         Colors.greenAccent,

        //                     width: 2,
        //                   )
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
      height: Icon_H,
      width: Icon_w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.greenAccent,
        // border: Border.all(
        //                     color:
        //                         Colors.greenAccent,

        //                     width: 2,
        //                   )
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
      height: Icon_H,
      width: Icon_w,
      decoration: BoxDecoration(
        // color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.greenAccent,
        // border: Border.all(
        //                     color:
        //                         Colors.greenAccent,

        //                     width: 2,
        //                   )
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

    return GestureDetector(
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
                Container(
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
                SizedBox(
                  height: distances,
                ),
                Container(
                  child: Center(
                      child: Text(
                   status!.szLiftName! ,
                    // "  FLOOR " + status!.iLiftID!.toString(),
                    style: TextStyle(color: Colors.amber, fontSize: 30),
                  )),
                ),
                
                Container(
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CarScreen(
                                        status: status,
                                      )));
                        },
                        icon: const Icon(
                          Icons.keyboard_double_arrow_left_outlined,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      const SizedBox(width: 180),
                      if (status!.iMaxLevel! > 24)
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Car3Screen(
                                          status: status,
                                        )));
                          },
                          icon: const Icon(
                            Icons.keyboard_double_arrow_right_outlined,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                    ],
                  ),
                ),
               SizedBox(
                  height: distances,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: main_1,
                        children: <Widget>[
                          if (status!.iMaxLevel! >= 13)
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await StatusItem.addCall(
                                      status!.iLiftID!.toString(),
                                      "C",
                                      "13",
                                      "zxcvd");
                                },
                                child: Container(
                                  width: width_1,
                                  height: height_2,
                                  decoration: BoxDecoration(
                                      color: color_2,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            checkLevel(status!.szCarStatus!, 13)
                                                ? Colors.blue
                                                : color_1,
                                        width: 2,
                                      )),
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text(status!.ltLevelName![12],
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w400,
                                          color: checkLevel(
                                                  status!.szCarStatus!, 13)
                                              ? Colors.blue
                                              : Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(width: w1),
                          if (status!.iMaxLevel! >= 14)
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await StatusItem.addCall(
                                      status!.iLiftID!.toString(),
                                      "C",
                                      "14",
                                      "zxcvd");
                                },
                                child: Container(
                                  width: width_1,
                                  height: height_2,
                                  decoration: BoxDecoration(
                                      color: color_2,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            checkLevel(status!.szCarStatus!, 14)
                                                ? Colors.blue
                                                : color_1,
                                        width: 2,
                                      )),
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text(status!.ltLevelName![13],
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w400,
                                          color: checkLevel(
                                                  status!.szCarStatus!, 14)
                                              ? Colors.blue
                                              : Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(width: w1),
                          if (status!.iMaxLevel! >= 15)
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await StatusItem.addCall(
                                      status!.iLiftID!.toString(),
                                      "C",
                                      "15",
                                      "zxcvd");
                                },
                                child: Container(
                                  width: width_1,
                                  height: height_2,
                                  decoration: BoxDecoration(
                                      color: color_2,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            checkLevel(status!.szCarStatus!, 15)
                                                ? Colors.blue
                                                : color_1,
                                        width: 2,
                                      )),
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text(status!.ltLevelName![14],
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w400,
                                          color: checkLevel(
                                                  status!.szCarStatus!, 15)
                                              ? Colors.blue
                                              : Colors.white,
                                        )),
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
                          if (status!.iMaxLevel! >= 16)
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await StatusItem.addCall(
                                      status!.iLiftID!.toString(),
                                      "C",
                                      "16",
                                      "zxcvd");
                                },
                                child: Container(
                                  width: width_1,
                                  height: height_2,
                                  decoration: BoxDecoration(
                                      color: color_2,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            checkLevel(status!.szCarStatus!, 16)
                                                ? Colors.blue
                                                : color_1,
                                        width: 2,
                                      )),
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text(status!.ltLevelName![15],
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w400,
                                          color: checkLevel(
                                                  status!.szCarStatus!, 16)
                                              ? Colors.blue
                                              : Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            width: w1,
                          ),
                          if (status!.iMaxLevel! >= 17)
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await StatusItem.addCall(
                                      status!.iLiftID!.toString(),
                                      "C",
                                      "17",
                                      "zxcvd");
                                },
                                child: Container(
                                  width: width_1,
                                  height: height_2,
                                  decoration: BoxDecoration(
                                      color: color_2,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            checkLevel(status!.szCarStatus!, 17)
                                                ? Colors.blue
                                                : color_1,
                                        width: 2,
                                      )),
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text(status!.ltLevelName![16],
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w400,
                                          color: checkLevel(
                                                  status!.szCarStatus!, 17)
                                              ? Colors.blue
                                              : Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            width: w1,
                          ),
                          if (status!.iMaxLevel! >= 18)
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await StatusItem.addCall(
                                      status!.iLiftID!.toString(),
                                      "C",
                                      "18",
                                      "zxcvd");
                                },
                                child: Container(
                                  width: width_1,
                                  height: height_2,
                                  decoration: BoxDecoration(
                                      color: color_2,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            checkLevel(status!.szCarStatus!, 18)
                                                ? Colors.blue
                                                : color_1,
                                        width: 2,
                                      )),
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text(status!.ltLevelName![17],
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w400,
                                          color: checkLevel(
                                                  status!.szCarStatus!, 18)
                                              ? Colors.blue
                                              : Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: h2),
                      if (status!.iMaxLevel! >= 19)
                        Row(
                          mainAxisAlignment: main_1,
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await StatusItem.addCall(
                                      status!.iLiftID!.toString(),
                                      "C",
                                      "19",
                                      "zxcvd");
                                },
                                child: Container(
                                  width: width_1,
                                  height: height_2,
                                  decoration: BoxDecoration(
                                      color: color_2,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            checkLevel(status!.szCarStatus!, 19)
                                                ? Colors.blue
                                                : color_1,
                                        width: 2,
                                      )),
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text(status!.ltLevelName![18],
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w400,
                                          color: checkLevel(
                                                  status!.szCarStatus!, 19)
                                              ? Colors.blue
                                              : Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: w1,
                            ),
                            if (status!.iMaxLevel! >= 20)
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await StatusItem.addCall(
                                        status!.iLiftID!.toString(),
                                        "C",
                                        "20",
                                        "zxcvd");
                                  },
                                  child: Container(
                                    width: width_1,
                                    height: height_2,
                                    decoration: BoxDecoration(
                                        color: color_2,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: checkLevel(
                                                  status!.szCarStatus!, 20)
                                              ? Colors.blue
                                              : color_1,
                                          width: 2,
                                        )),
                                    child: Align(
                                      alignment: Align_1,
                                      child: Text(status!.ltLevelName![19],
                                          style: TextStyle(
                                            fontSize: 34,
                                            fontWeight: FontWeight.w400,
                                            color: checkLevel(
                                                    status!.szCarStatus!, 20)
                                                ? Colors.blue
                                                : Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(width: w1),
                            if (status!.iMaxLevel! >= 21)
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await StatusItem.addCall(
                                        status!.iLiftID!.toString(),
                                        "C",
                                        "21",
                                        "zxcvd");
                                  },
                                  child: Container(
                                    width: width_1,
                                    height: height_2,
                                    decoration: BoxDecoration(
                                        color: color_2,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: checkLevel(
                                                  status!.szCarStatus!, 21)
                                              ? Colors.blue
                                              : color_1,
                                          width: 2,
                                        )),
                                    child: Align(
                                      alignment: Align_1,
                                      child: Text(status!.ltLevelName![20],
                                          style: TextStyle(
                                            fontSize: 34,
                                            fontWeight: FontWeight.w400,
                                            color: checkLevel(
                                                    status!.szCarStatus!, 21)
                                                ? Colors.blue
                                                : Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      SizedBox(height: h2),
                      if (status!.iMaxLevel! >= 22)
                        Row(
                          mainAxisAlignment: main_1,
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await StatusItem.addCall(
                                      status!.iLiftID!.toString(),
                                      "C",
                                      "22",
                                      "zxcvd");
                                },
                                child: Container(
                                  width: width_1,
                                  height: height_2,
                                  decoration: BoxDecoration(
                                      color: color_2,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            checkLevel(status!.szCarStatus!, 22)
                                                ? Colors.blue
                                                : color_1,
                                        width: 2,
                                      )),
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text(status!.ltLevelName![21],
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w400,
                                          color: checkLevel(
                                                  status!.szCarStatus!, 22)
                                              ? Colors.blue
                                              : Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: w1,
                            ),
                            const SizedBox(height: 20.0),
                            if (status!.iMaxLevel! >= 23)
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await StatusItem.addCall(
                                        status!.iLiftID!.toString(),
                                        "C",
                                        "23",
                                        "zxcvd");
                                  },
                                  child: Container(
                                    width: width_1,
                                    height: height_2,
                                    decoration: BoxDecoration(
                                        color: color_2,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: checkLevel(
                                                  status!.szCarStatus!, 23)
                                              ? Colors.blue
                                              : color_1,
                                          width: 2,
                                        )),
                                    child: Align(
                                      alignment: Align_1,
                                      child: Text(status!.ltLevelName![22],
                                          style: TextStyle(
                                            fontSize: 34,
                                            fontWeight: FontWeight.w400,
                                            color: checkLevel(
                                                    status!.szCarStatus!, 23)
                                                ? Colors.blue
                                                : Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: w1,
                            ),
                            if (status!.iMaxLevel! >= 24)
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await StatusItem.addCall(
                                        status!.iLiftID!.toString(),
                                        "C",
                                        "24",
                                        "zxcvd");
                                  },
                                  child: Container(
                                    width: width_1,
                                    height: height_2,
                                    decoration: BoxDecoration(
                                        color: color_2,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: checkLevel(
                                                  status!.szCarStatus!, 24)
                                              ? Colors.blue
                                              : color_1,
                                          width: 2,
                                        )),
                                    child: Align(
                                      alignment: Align_1,
                                      child: Text(status!.ltLevelName![23],
                                          style: TextStyle(
                                            fontSize: 34,
                                            fontWeight: FontWeight.w400,
                                            color: checkLevel(
                                                    status!.szCarStatus!, 24)
                                                ? Colors.blue
                                                : Colors.white,
                                          )),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
         
        ),
      ),
    );
  }
}
