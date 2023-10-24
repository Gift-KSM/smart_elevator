import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smartlift/constants.dart';
import 'package:smartlift/models/status_item.dart';
import 'package:smartlift/screens/camera_screen.dart';
import 'package:smartlift/screens/car_screen.dart';
import "package:smartlift/global.dart";

// ignore: must_be_immutable
class DoorScreen extends StatefulWidget {
  final StatusItem? status;
  final int? iLevel;

  const DoorScreen({
    Key? key,
    this.status,
    this.iLevel,
  }) : super(key: key);

  @override
  State<DoorScreen> createState() => _DoorScreenState();
}

class _DoorScreenState extends State<DoorScreen> {
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
      iLevel = widget.iLevel!;
    });

timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
  StatusItem? status1 =
      await StatusItem.getStatus(status!.iLiftID.toString());
  if (mounted) {  // Check if the widget is still mounted
    setState(() {
      status = status1;
    });
  }
});

  }

  @override
  build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double width_1 = screenWidth * 0.3;
    double height_2 = screenHeight * 0.1;

    double Icon_W = screenWidth * 0.35;
    double Icon_H = screenHeight * 0.15;

    double appBarHeight =
        MediaQuery.of(context).size.width > 600 ? 100.0 : 80.0;
    const appbar_Color = Color.fromARGB(0, 23, 33, 1);

    final Textbar = Text(
      'CALL ELEVATOR' ,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.05,
          color: Colors.white),
    );
    final Appbar = AppBar(
      leading: IconButton(
    icon: Icon(Icons.arrow_back),
  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => camera_1(),));
                    }
  ),
        centerTitle: true,
        backgroundColor: appbar_Color,
        title: Textbar,
        toolbarHeight: appBarHeight);

    final UP = GestureDetector(
      child: Column(
        children: <Widget>[
          Image.asset(
            checkLevel(status!.szUpStatus!, iLevel!)
                ? 'assets/Up_Icon(Wait).png'
                : 'assets/Up_Image1.png',
            width: Icon_W,
            height: Icon_H,
          ),
        ],
      ),
      onTap: () async {
        StatusItem? status1 = await StatusItem.addCall(
            status!.iLiftID!.toString(),
            //temporary change
            "U",
            iLevel.toString(),
            "zxcvd");
        //pop this screen
        // Navigator.pop(context);
        //push door screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoorScreen(
                      status: status1!,
                      iLevel: iLevel,
                    )));
      },
    );

    final Down = GestureDetector(
      child: Column(
        children: <Widget>[
          Image.asset(
            checkLevel(status!.szDownStatus!, iLevel!)
                ? 'assets/Down_Icon(Wait).png'
                : 'assets/Down_Image1.png',
            width: Icon_W,
            height: Icon_H,
          ),
        ],
      ),
      onTap: () async {
        //call down
        StatusItem? status1 = await StatusItem.addCall(
            status!.iLiftID!.toString(),
            //temporary change
            "D",
            iLevel.toString(),
            "zxcvd");
        //pop this screen
        // Navigator.pop(context);
        //push door screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoorScreen(
                      status: status1!,
                      iLevel: iLevel,
                    )));
      },
    );
    final UpdownIcon = IconButton(
        icon: checkUpDownArrow(status!.szLiftState!), onPressed: () {},iconSize:45,
  color: Colors.black,);
  final Floor_Text = () {
  try {
    return Text(
      status!.ltLevelName![checkCurrentFloor(status!.szLiftState!) - 1],
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w700
      )
    );
  } catch (e) {
    print(e);
    return Text('Error');  // แสดงข้อความ Error หรือข้อความอื่นที่คุณต้องการแสดงเมื่อเกิดข้อผิดพลาด
  }
}();
    final Floor_Text1 = 
    
    Text(status!.ltLevelName![checkCurrentFloor(status!.szLiftState!) -1 ],style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700));

    final DoorIcon =
        IconButton(icon: checkDoorIcon(status!.szLiftState!), onPressed: () {},iconSize:50,
  color: Colors.black,);
    final Door_Text = Text(checkDoorText(status!.szLiftState!),style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700));

    final SpeedIcon =
        IconButton(icon: const Icon(Icons.bolt), onPressed: () {},iconSize:50,
  color: Colors.black,);
    final Speed_Text = Text(checkSpeed(status!.szLiftState!),style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700));

    final ErrorIcon =
        IconButton(icon: const Icon(Icons.report_problem), onPressed: () {},iconSize:40,
  color: Colors.black,);
    final Error_Text = Text(checkError(status!.szLiftState!),style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700),);

    final Container_UP_Down = Container(
      height: width_1,
      width: height_2,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
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
       color: Colors.greenAccent,
     
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
        color: Colors.greenAccent,
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
        color: Colors.greenAccent,
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

    return Scaffold(
      backgroundColor: Color.fromARGB(0, 23, 33, 1),
      appBar: Appbar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
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
          SizedBox(height: 40,),
          Container(
            
            child: Center(
                child: Text(
                status!.szLiftName! + "  FLOOR " + status!.ltLevelName![iLevel! - 1 ],
                // status!.ltLevelName![iLevel! - 1],
              style: TextStyle(color: Colors.amber, fontSize: 30,fontWeight: FontWeight.w700)
            )),
          ),
           SizedBox(height: 40,),
           if (iLevel != status!.iMaxLevel) 
            Expanded(
                flex: 2,
                child: Center(
                  child: UP,
                )),
          // if (iLevel != 1)
            if (iLevel != 1) const SizedBox(height: 15,),
            if (iLevel != 1)
              Expanded(
                flex: 2,
                child: Center(
                  child: Down,
                ),
              ),
                 Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: 161,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(5.0),
                      textStyle: const TextStyle(fontSize: 20),),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => camera_1(),));
                    },
                    child: const Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('S', textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text('C', textAlign: TextAlign.center),
                        ),
                        Expanded(
                            child: const Image(
                          image: AssetImage("assets/button.png"),
                        )),
                        Expanded(
                          child: Text('N', textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ), const SizedBox(height: 65,)
              ],
            ),
          ),
        )
        ],
      ),
    );
  }
}
