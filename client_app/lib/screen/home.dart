import 'package:client_app/models/info.dart';
import 'package:client_app/providers/info_provider.dart';
import 'package:client_app/screen/information.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Infomation'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RequestScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Consumer<InfoProvider>(builder: (context, provider, child) {
          var infomationsList = provider.infomations ?? [];
          var count = infomationsList.length;
          List<Infomations> infomationList = provider.getInfomations();
          if (count <= 0) {
            return Center(
              child: Text("No information"),
            );
          } else {
            return Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              child: ListView.builder(
                itemCount: count,
                itemBuilder: (context, int index) {
                  Infomations data = infomationList[index];
                
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    child: ListTile(

                      leading: CircleAvatar(
                        radius: 50,
                        child: FittedBox(
                          child: Text(data.amount.toString()),
                        ),
                      ),
                      title: Text(
                        data.name ?? '',
                        style: TextStyle(fontSize: 22),
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.description ?? '',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            Text(
                              DateFormat("dd-MM-yyyy").format(
                                data.date ?? DateTime.now(),
                              ),
                            )
                          ]),
                    ),
                  );
                },
              ),
            );
          }
        }));
  }
}
