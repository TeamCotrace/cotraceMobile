import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';

import 'List.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plate Recognition',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _ocrCamera = FlutterMobileVision.CAMERA_BACK;
  String _text = "TEXT";
  bool isstart = false;
  Size? _previewOcr;

  Future<Null> _read() async {
    List<OcrText> texts = [];
    Size _scanpreviewOcr = _previewOcr ?? FlutterMobileVision.PREVIEW;

    try {
      texts = await FlutterMobileVision.read(
        //camera: _ocrCamera,
        waitTap: true,
        autoFocus: true,
        fps: 2,
        multiple: true,
        preview: _scanpreviewOcr,
        scanArea: Size(_scanpreviewOcr.width + 30 , _scanpreviewOcr.height - 100),

      );
      // for(OcrText txt in texts){
      //   print("values is ${txt.value}");
      // }
      Navigator.of(context).push(MaterialPageRoute(builder:
          (context)=>Listdata(texts2: texts,)));
      // setState(() {
      //   _text = texts[0].value;
      // });
    } catch(e) {
      texts.add( OcrText('Failed to recognize text'));
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Scan Plate'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text(_text,style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.bold),
          // ),
          Center(
            child: ElevatedButton(

              onPressed: _read,
              child: Text('Scan...',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal:30, vertical: 20),
                  textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
