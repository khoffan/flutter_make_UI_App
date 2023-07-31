import 'package:client_app/providers/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/info.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RequestScreen'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    controller: nameController,
                    validator: (str) {
                      if (str == null || str.isEmpty) {
                        return "Plese your add data";
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: 'Descriptions',
                    ),
                    controller: descriptionController,
                    validator: (str) {
                      if (str == null || str.isEmpty) {
                        return "Plese your add data";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: 'amount',
                    ),
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    validator: (str) {
                      if (str == null || str.isEmpty) {
                        return "Please provide your data";
                      }
                      if (double.parse(str) <= 0) {
                        return 'please provide number more 0';
                      }
                      return null;
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          var name = nameController.text;
                          var des = descriptionController.text;
                          var money = amountController.text;

                          Infomations info = Infomations(
                            name: name,
                            description: des,
                            amount: double.parse(money),
                            date: DateTime.now(),
                          );

                          var provider = Provider.of<InfoProvider>(context, listen: false);
                          if (provider != '') {
                            provider.addInfomation(info);
                            Navigator.of(context).pop();
                          }
                          else{
                            print("nuul value in provider");
                          }
                        }
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
                      )),
                ],
              )),
        ));
  }
}
