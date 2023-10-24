import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smartlift/constants.dart';
import 'package:smartlift/screens/camera_screen.dart';
import 'package:smartlift/screens/car_screen.dart';
import 'package:smartlift/global.dart' as globals;
import 'package:smartlift/models/status_item.dart';
import 'package:smartlift/services/config_system.dart';
import 'door_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var buttonText = 'Level:';
  String szLevel = "";
  // String ip = '';

  @override
  build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image.asset(
          "assets/Bg.png",
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
    ));
  }
}
