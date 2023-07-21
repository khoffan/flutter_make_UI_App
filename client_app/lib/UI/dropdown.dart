import 'package:flutter/material.dart';

class DropdoenWidget extends StatefulWidget {
  const DropdoenWidget({super.key});

  @override
  State<DropdoenWidget> createState() => _DropdoenWidgetState();
}

class _DropdoenWidgetState extends State<DropdoenWidget> {
  String? dropDownValue = "central";
  List<String> _data = [
    "central",
    "Lotus",
    "Big-c",
    "Sritrng",
    "7-11",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: dropDownValue,
        icon: Icon(Icons.expand_more),
        underline: Container(
          height: 2,
          color: Color.fromARGB(255, 18, 237, 241),
        ),
        isDense: false,
        onChanged: (String? newValue) {
          if (newValue != null && newValue.isNotEmpty) {
            setState(() {
              dropDownValue = newValue;
              int index = _data.indexOf(newValue);
              print(index);
            });
          } else {
            print('please valid vale');
          }
        },
        items: _data.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  dropDownValue = item;
                });
              },
              onExit: (_) {},
              child: Text(item,style: TextStyle(color: Colors.blue),),
            ),
          );
        }).toList(),
      ),
    );
  }
}
