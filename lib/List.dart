import 'dart:convert';

import 'package:cotrace/models/hotcars.dart';
import 'package:cotrace/savehotcars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';
import 'package:cotrace/services/hotcars_services.dart';


class Listdata extends StatefulWidget {

  final List texts2;


  const Listdata({Key? key, required this.texts2}) : super(key: key);

  @override
  _ListdataState createState() => _ListdataState();
}

class _ListdataState extends State<Listdata> {


  bool isloading = true;

  _getEmp(BuildContext context, Hotcars data) async {
    var _Services = RemoteService();
    var result = await _Services.send_hotcars(data);
    var _list = json.decode(result.body);

    print(_list);

    if(_list.length >= 1){

      setState(() {
        isloading = true;
      });


      showDialog(context: this.context,
        barrierColor: Colors.red,
        builder: (context) {
          return AlertDialog(
            title: Text('ALERT',style: TextStyle(color: Colors.red),),
            content: Text('Hot Car Found!'),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => SaveTime(pnumber: _list[0]['pnumber'])));

               },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

    } else {

      setState(() {
        isloading = true;
      });

      showDialog(context: this.context,
        barrierColor: Colors.red,
        builder: (context) {
          return AlertDialog(
            title: Text('Result!'),
            content: Text('No Record found'),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );



    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text('Search Data'),
      ),

      body:   Visibility(
        visible: isloading,
        child: ListView.builder(
          itemCount: this.widget.texts2.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .5,
              child: Card(
                child: ListTile(
                  title: Text(this.widget.texts2[index].value),
                  onTap: () {
                    var data = Hotcars();
                    data.typeV = "";
                    data.pnumber = this.widget.texts2[index].value;
                    _getEmp(context, data);

                    setState(() {
                      isloading = false;
                    });
                  },
                ),
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );



  }
}


