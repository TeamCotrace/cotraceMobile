
import 'package:cotrace/main.dart';
import 'package:cotrace/models/reported.dart';
import 'package:cotrace/services/report_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;



class SaveTime extends StatefulWidget {

  final String? pnumber;

  const SaveTime({Key? key, required this.pnumber }) : super(key: key);

  @override
  _SaveTimeState createState() => _SaveTimeState();
}

class _SaveTimeState extends State<SaveTime> {


  final currentlatController = TextEditingController();
  final currentlngController = TextEditingController();

  final locId = TextEditingController();
  final radius = TextEditingController();


  bool isloading = true;

  File? _image;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    _getFromCamera();
  }

  Position? _position;

  double _totalDistance = 0;



  get key => 1;


  Future<Position> _determinePosition() async {

    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // return Future.error('Location services are disabled.');

      if(permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          return Future.error('Location Permission are denied');
        }
      }

    }

    if(permission == LocationPermission.deniedForever){

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');

    }
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
      currentlatController.text = _position!.latitude.toString();
      currentlngController.text = _position!.longitude.toString();
      isloading = true;
    });
  }


  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      // maxWidth: 100,
      // maxHeight: 100,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }


  _getEmp(BuildContext context, Reported data) async {
    var _Services = RemoteService();
    var result = await _Services.send_report(data);
    var _list = json.decode(result.body);

    print(_list);

    if(_list.length >= 1){


      showDialog(context: this.context,
        builder: (context) {
          return AlertDialog(
            title: Text('Thank you'),
            content: Text('Report saved!'),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => MyApp()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

    }
  }

  Future addReport(BuildContext, File imageFile) async {

    var dt = DateTime.now();

    var cloudinary =  CloudinaryPublic('dknqhrx21', 'jha1kd1g', cache: false);

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(imageFile.path,
            resourceType: CloudinaryResourceType.Image),
      );

      if(response.secureUrl.length >= 1){

        var addrepo = Reported();

        addrepo.pnumber = this.widget.pnumber;
        addrepo.remarks = "Hot car!";
        addrepo.image = response.secureUrl;
        addrepo.lat = double.parse(currentlatController.text);
        addrepo.lng = double.parse(currentlngController.text);
        addrepo.userId = '634e86ad8b3a310a0652fcc6';

        _getEmp(context, addrepo);

      }

    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Report'),
        automaticallyImplyLeading: false,
      ),
      body: Visibility(
        visible: isloading,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                SizedBox(child:  _image != null
                    ? Image.file(
                  _image!,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                )
                    : Container(
                ),),
                Container(
                  color: Colors.black26,
                  child: Column(children: [
                     Row(children: [
                      Text("Current: " + currentlatController.text +',' + currentlngController.text,style: TextStyle(color: Colors.white),)
                    ],),

                  ],),
                )
              ],),

//TIme In function.....................
              ElevatedButton(onPressed: (){

                  addReport(context, _image!);

                  setState(() {
                    isloading = false;
                  });

                }

              , child: Text('Send Report')),
              SizedBox(height: 20,),

            ],

          ),
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
