

class Hotcars {
  int? id;
  String? pnumber;
  String? typeV;

  Hotcars (
      {
        this.id,
        this.pnumber,
        this.typeV

      });


  Map<String, dynamic> toJson() {
    return {
      'id':id.toString(),
      'pnumber': pnumber,
      'typeV': typeV,

    };

  }


  toMap(){
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['pnumber'] = pnumber;
    map['typeV'] = typeV;


    return map;
  }

}