import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/database_service.dart';



class AddContentPage extends StatefulWidget {
  @override
  _AddContentPageState createState() => _AddContentPageState();
}

class _AddContentPageState extends State<AddContentPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();
  final _contentControoler = TextEditingController();
  final locateController = TextEditingController();

  String? _name;
  String? _email;
  String? _uid;

  void fetchData() async {
    try {
      final currentUser = _auth.currentUser!;
      if (currentUser != null) {
        DocumentSnapshot userSnap = await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.uid)
            .get();
        setState(() {
          _uid = userSnap['uid'] ?? '';
          _name = userSnap['name'] ?? '';
          _email = userSnap['email'] ?? '';
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  void _addContent(String documentId) {
    final content = _contentControoler.text;
    final locate = locateController.text;

    

    if (content.isEmpty || locate.isEmpty) {
      return;
    }

    final contentData = {
      'contents': content,
      'locate': locate,
      'name': _name,
      'email': _email,
      'uid': _uid,
      'date': Timestamp.now(),
    };

    try {
      ContentService contentService = ContentService();
      contentService.saveContent(documentId, contentData).then((_) {
        _contentControoler.clear();
        locateController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Content added successfully')));
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error adding content')));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating content document')));
    }
  }

   @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Content')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _contentControoler,
                decoration: InputDecoration(labelText: 'Content'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter your content";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: locateController,
                decoration: InputDecoration(labelText: 'Locate'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter your content";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Provide a unique document ID here, such as a generated UID or any other ID
                  if (_formkey.currentState?.validate() ?? false) {
                    final documentId = _auth.currentUser!.uid;
                    _addContent(documentId);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Content'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
