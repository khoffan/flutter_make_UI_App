import 'package:flutter/material.dart';

import '../models/info.dart';

class InfoProvider extends ChangeNotifier {

  //ตัวอย่างข้อมูล
  List<Infomations> infomations = [];

  //get data
  List<Infomations> getInfomations(){
    return infomations;
  }

  //add data
  void addInfomation(Infomations data){
    infomations.insert(0, data);

    notifyListeners();
  }
}