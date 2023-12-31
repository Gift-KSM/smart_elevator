import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ConfigSystem {
  static Future<String> getServer() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/server.txt');
      String text = await file.readAsString();
      return text;
    } catch (e) {
      //print("New File");
      setServer('52.221.67.113');
      return '52.221.67.113';
    }
  }

  static void setServer(String serverIP) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/server.txt');
    final text = serverIP;
    await file.writeAsString(text);
    //print('saved');
  }
}
