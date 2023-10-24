import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smartlift/constants.dart';
import 'package:smartlift/main.dart';
import 'package:smartlift/screens/car_screen.dart';
import 'package:smartlift/global.dart' as globals;
import 'package:smartlift/models/status_item.dart';
import 'package:smartlift/screens/main_screen.dart';
import 'package:smartlift/services/config_system.dart';
import 'door_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class camera_1 extends StatefulWidget {
  const camera_1({Key? key}) : super(key: key);
  @override
  State<camera_1> createState() => _cameraState();
}

class _cameraState extends State<camera_1> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Barcode result;
  QRViewController? controller;

  StatusItem? status;
  int? iLevel;
  Timer? timer;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      
      String? barcodeScanRes = result.code;
      if (barcodeScanRes!.length >= 0 &&
          barcodeScanRes.substring(5, 6) == "C") {
        StatusItem? status1 = await StatusItem.getStatus(
            int.parse(barcodeScanRes.substring(1, 5)).toString());
        setState(() {
          status = status1;
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CarScreen(status: status)));
      } else if (barcodeScanRes.substring(5, 6) == "U") {
        StatusItem? status1 = await StatusItem.getStatus(
            int.parse(barcodeScanRes.substring(1, 5)).toString());

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoorScreen(
                      status: status1,
                      iLevel: int.parse(barcodeScanRes.substring(6, 8)),
                    )));
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double width_1 = screenWidth * 0.75;
    double height_2 = screenHeight * 0.58;

    double Logo_W = screenWidth * 0.4;
    double Logo_H = screenHeight * 0.4;

    double Cancel_w = screenWidth * 0.12;
    double Cancel_H = screenHeight * 0.12;

    const Cross1 = CrossAxisAlignment.center;
    const main_1 = MainAxisAlignment.center;
    final deco1 = BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15));
    final clip = ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
    );
    final cameraBox = Container(
        height: height_2,
        width: width_1,
        padding: EdgeInsets.all(3),
        decoration: deco1,
        child: clip);
    final Logo = Image.asset(
      'assets/Logo_A.png',
      width: Logo_W,
      height: Logo_H,
    );
    final Cancle = Image.asset(
      'assets/Cancle.png',
      width: Cancel_H,
      height: Cancel_w,
    );
    final Text1 = Text(
      'SCAN QR CODE',
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.05,
          color: Colors.white),
    );
    final Ges = GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              MainScreen(), 
        ));
      },
      child: Row(
        crossAxisAlignment: Cross1,
        mainAxisAlignment: main_1,
        children: [
          Cancle,
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(0, 23, 33, 1),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: main_1,
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            Expanded(
                child: Center(
              child: Logo,
            )),
            Expanded(
                child: Center(
              child: Text1,
            )),
            Expanded(
                flex: 7,
                child: Center(
                  child: cameraBox,
                )),
            Expanded(
                flex: 1,
                child: Center(
                  child: Ges,
                )),
            const SizedBox(
              height: 15,
            ),
          ]),
    );
  }
}