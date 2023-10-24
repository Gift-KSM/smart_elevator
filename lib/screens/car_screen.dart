import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:smartlift/models/status_item.dart';
import 'package:smartlift/screens/camera_screen.dart';
import 'car2_screen.dart';
import 'door_screen.dart';
import 'package:smartlift/constants.dart';
import "package:smartlift/global.dart";

class CarScreen extends StatefulWidget {
  final StatusItem? status;
  final int? iLevel;
  const CarScreen({Key? key, this.status  ,this.iLevel,}) : super(key: key);
  
  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  StatusItem? status;
  int? iLevel;
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
      // iLevel = widget.iLevel!;
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
        icon: checkUpDownArrow(status!.szLiftState!), onPressed: () {},color: const Color.fromARGB(255, 0, 0, 0),iconSize: 30,);
    final Floor_Text = Text(status!.ltLevelName![checkCurrentFloor(status!.szLiftState!) - 1],style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 20,fontWeight: FontWeight.w700),);

    final DoorIcon =
        IconButton(icon: checkDoorIcon(status!.szLiftState!), onPressed: () {},color: const Color.fromARGB(255, 0, 0, 0),);
    final Door_Text = Text(checkDoorText(status!.szLiftState!),style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 20,fontWeight: FontWeight.w700));

    final SpeedIcon =
        IconButton(icon: const Icon(Icons.bolt), onPressed: () {},color: const Color.fromARGB(255, 0, 0, 0),);
    final Speed_Text = Text(checkSpeed(status!.szLiftState!),style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 20,fontWeight: FontWeight.w700));

    final ErrorIcon =
        IconButton(icon: const Icon(Icons.report_problem), onPressed: () {},color: const Color.fromARGB(255, 0, 0, 0),);
    final Error_Text = Text(checkError(status!.szLiftState!),style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 20,fontWeight: FontWeight.w700));

    final Container_UP_Down = Container(
      height: Icon_H,
      width: Icon_w,
      decoration: BoxDecoration(
       
        borderRadius:
            BorderRadius.circular(10.0),
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
       
        borderRadius:
            BorderRadius.circular(10.0),
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
        
        borderRadius:
            BorderRadius.circular(10.0),
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
        borderRadius:
            BorderRadius.circular(10.0),
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
     leading: IconButton(
    icon: Icon(Icons.arrow_back),
  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => camera_1(),));
                    }
  ),
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
                      child: Center(child: Column(
                        children: <Widget>[
                        const SizedBox(width: 200),
                        if (status!.iMaxLevel! > 12)
                          IconButton(
                            onPressed: () {
                              // Navigator.pop(context);
                              //     //push door screen
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Car2Screen(
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
                      )),
                    ),
                
                  SizedBox(
                  height: distances,
                ),
                Row(
                  mainAxisAlignment: main_1,
                  children: <Widget>[
                    if (status!.iMaxLevel! >= 1)
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await StatusItem.addCall(
                              status!.iLiftID!.toString(), "C", "1", "zxcvd");
                        },
                        child: Container(
                          width: width_1,
                          height: height_2,
                          decoration: BoxDecoration(
                              color: color_2,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: checkLevel(status!.szCarStatus!, 1)
                                    ? Colors.blue
                                    : color_1,
                                width: 2,
                              )),
                          child: Align(
                            alignment: Align_1,
                            child: Text(status!.ltLevelName![0],
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w400,
                                  color: checkLevel(status!.szCarStatus!, 1)
                                      ? Colors.blue
                                      : Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: w1),
                    if (status!.iMaxLevel! >= 2)
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await StatusItem.addCall(
                              status!.iLiftID!.toString(), "C", "2", "zxcvd");
                        },
                        child: Container(
                          width: width_1,
                          height: height_2,
                          decoration: BoxDecoration(
                              color: color_2,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: checkLevel(status!.szCarStatus!, 2)
                                    ? Colors.blue
                                    : color_1,
                                width: 2,
                              )),
                          child: Align(
                            alignment: Align_1,
                            child: Text(status!.ltLevelName![1],
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w400,
                                  color: checkLevel(status!.szCarStatus!, 2)
                                      ? Colors.blue
                                      : Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: w1),
                    if (status!.iMaxLevel! >= 3)
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await StatusItem.addCall(
                              status!.iLiftID!.toString(), "C", "3", "zxcvd");
                        },
                        child: Container(
                          width: width_1,
                          height: height_2,
                          decoration: BoxDecoration(
                              color: color_2,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: checkLevel(status!.szCarStatus!, 3)
                                    ? Colors.blue
                                    : color_1,
                                width: 2,
                              )),
                          child: Align(
                            alignment: Align_1,
                            child: Text(status!.ltLevelName![2],
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w400,
                                  color: checkLevel(status!.szCarStatus!, 3)
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
                if (status!.iMaxLevel! >= 4)
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
                          decoration: BoxDecoration(
                              color: color_2,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: checkLevel(status!.szCarStatus!, 4)
                                    ? Colors.blue
                                    : color_1,
                                width: 2,
                              )),
                          child: Align(
                            alignment: Align_1,
                            child: Text(status!.ltLevelName![3],
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w400,
                                  color: checkLevel(status!.szCarStatus!, 4)
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
if (status!.iMaxLevel! >= 5)
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
                              decoration: BoxDecoration(
                                  color: color_2,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: checkLevel(status!.szCarStatus!, 5)
                                        ? Colors.blue
                                        : color_1,
                                    width: 2,
                                  )),
                              child: Align(
                                alignment: Align_1,
                                child: Text(status!.ltLevelName![4],
                                    style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w400,
                                      color: checkLevel(status!.szCarStatus!, 5)
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
                   if (status!.iMaxLevel! >= 6)
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
                              decoration: BoxDecoration(
                                  color: color_2,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: checkLevel(status!.szCarStatus!, 6)
                                        ? Colors.blue
                                        : color_1,
                                    width: 2,
                                  )),
                              child: Align(
                                alignment: Align_1,
                                child: Text(status!.ltLevelName![5],
                                    style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w400,
                                      color: checkLevel(status!.szCarStatus!, 6)
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
                if (status!.iMaxLevel! >= 7)
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
                              decoration: BoxDecoration(
                                  color: color_2,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: checkLevel(status!.szCarStatus!, 7)
                                        ? Colors.blue
                                        : color_1,
                                    width: 2,
                                  )),
                              child: Align(
                                alignment: Align_1,
                                child: Text(status!.ltLevelName![6],
                                    style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w400,
                                      color: checkLevel(status!.szCarStatus!, 7)
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
                        if (status!.iMaxLevel! >= 8)
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
                                  decoration: BoxDecoration(
                                      color: color_2,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            checkLevel(status!.szCarStatus!, 8)
                                                ? Colors.blue
                                                : color_1,
                                        width: 2,
                                      )),
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text(status!.ltLevelName![7],
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w400,
                                          color: checkLevel(
                                                  status!.szCarStatus!, 8)
                                              ? Colors.blue
                                              : Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                        SizedBox(width: w1),
                        if (status!.iMaxLevel! >= 9)
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
                                  decoration: BoxDecoration(
                                      color: color_2,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            checkLevel(status!.szCarStatus!, 9)
                                                ? Colors.blue
                                                : color_1,
                                        width: 2,
                                      )),
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text(status!.ltLevelName![8],
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w400,
                                          color: checkLevel(
                                                  status!.szCarStatus!, 9)
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
                 if (status!.iMaxLevel! >= 10)
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
                              decoration: BoxDecoration(
                                  color: color_2,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: checkLevel(status!.szCarStatus!, 10)
                                        ? Colors.blue
                                        : color_1,
                                    width: 2,
                                  )),
                              child: Align(
                                alignment: Align_1,
                                child: Text(status!.ltLevelName![9],
                                    style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          checkLevel(status!.szCarStatus!, 10)
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
                        if (status!.iMaxLevel! >= 11)
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
                                decoration: BoxDecoration(
                                    color: color_2,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color:
                                          checkLevel(status!.szCarStatus!, 11)
                                              ? Colors.blue
                                              : color_1,
                                      width: 2,
                                    )),
                                child: Align(
                                  alignment: Align_1,
                                  child: Text(status!.ltLevelName![10],
                                      style: TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            checkLevel(status!.szCarStatus!, 11)
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
                      if (status!.iMaxLevel! >= 12)
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
                                  decoration: BoxDecoration(
                                      color: color_2,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            checkLevel(status!.szCarStatus!, 12)
                                                ? Colors.blue
                                                : color_1,
                                        width: 2,
                                      )),
                                  child: Align(
                                    alignment: Align_1,
                                    child: Text(status!.ltLevelName![11],
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w400,
                                          color: checkLevel(
                                                  status!.szCarStatus!, 12)
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
          ),
        ),
      ),
    );
  }
}
