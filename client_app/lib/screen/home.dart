import 'package:client_app/models/info.dart';
import 'package:client_app/providers/info_provider.dart';
import 'package:client_app/screen/information.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Information(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Consumer<InfoProvider>(builder: (context, provider, child) {
          List<Infomations> infomationList = provider.getInfomations();
          return ListView.builder(
            itemCount: provider.infomations.length,
            itemBuilder: (context, int index) {
              Infomations data = infomationList[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    child: FittedBox(
                      child: Text(data.amount.toString()),
                    ),
                  ),
                  title: Text(data.name, style: TextStyle(fontSize: 25),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.description,style: TextStyle(color: Colors.black,fontSize: 20),),
                      Text(data.date.toString())
                    ]
                  ),
                ),
              );
            },
          );
        }));
  }
}
