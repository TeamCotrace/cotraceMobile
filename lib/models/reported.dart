

import 'package:flutter/material.dart';

class Reported {
  int? id;
  String? pnumber;
  double? lat;
  double? lng;
  String? image;
  String? remarks;
  String? userId;


  Reported (
      {
        this.id,
        this.pnumber,
        this.lat,
        this.lng,
        this.image,
        this.remarks,
        this.userId

      });


  Map<String, dynamic> toJson() {
    return {
      'id':id.toString(),
      'pnumber': pnumber,
      'lat': lat.toString(),
      'lng': lng.toString(),
      'image': image,
      'remarks': remarks,
      'userId': userId
    };

  }


  toMap(){
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['pnumber'] = pnumber;
    map['lat'] = lat.toString();
    map['lng'] = lng.toString();
    map['image'] = image;
    map['remarks'] = remarks;


    return map;
  }

}