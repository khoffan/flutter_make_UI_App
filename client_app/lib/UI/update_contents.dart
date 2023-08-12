
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateContentPage extends StatefulWidget {
  final String contentDocId;
  final String contentUserDocId;
  final String initialTitle;
  final String initialText;

  UpdateContentPage({
    required this.contentDocId,
    required this.contentUserDocId,
    required this.initialTitle,
    required this.initialText,
  });

  @override
  _UpdateContentPageState createState() => _UpdateContentPageState();
}

class _UpdateContentPageState extends State<UpdateContentPage> {
  final _formkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle;
    _textController.text = widget.initialText;
  }

  void _updateContent() {
    final title = _titleController.text;
    final text = _textController.text;

    if (title.isEmpty || text.isEmpty) {
      return;
    }

    FirebaseFirestore.instance
        .collection('contents')
        .doc(widget.contentDocId)
        .collection('contentUser')
        .doc(widget.contentUserDocId)
        .update({
      'title': title,
      'text': text,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Content updated successfully')));
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error updating content')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Content')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'content'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter your content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(labelText: 'locate'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter your content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState?.validate() ?? false) {
                    _updateContent();
                  }
                },
                child: Text('Update Content'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
