import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Information'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                autofocus: true,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descriptions',
                ),
                
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'amount',
                ),
                keyboardType: TextInputType.number,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "AddInformation",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                            
              ),
            ],
          )),
        ));
  }
}
