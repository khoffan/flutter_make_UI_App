import 'package:flutter/material.dart';

import '../models/info.dart';

class InfoProvider extends ChangeNotifier {

  //ตัวอย่างข้อมูล
  List<Infomations> infomations = [
    Infomations(name: 'mai', description: 'ผู้ปกครอง', date: DateTime.now(), amount: 500),
    Infomations(name: 'doe', description: 'บ้าน', date: DateTime.now(), amount:400),
  ];

  //get data
  List<Infomations> getInfomations(){
    return infomations;
  }

  //add data
  void addInfomation(Infomations data){
    infomations.add(data);
  }
}