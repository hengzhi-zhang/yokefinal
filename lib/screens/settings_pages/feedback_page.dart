import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _feedbackController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveFeedback(),
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveFeedback() async {
    List<List<dynamic>> rows = [];  // Initialize it as an empty list
    rows.add([_feedbackController.text]);

    String csv = const ListToCsvConverter().convert(rows);

    final directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/feedback.csv');
    
    // Check if the file exists, if not, create it.
    if (!await file.exists()) {
      await file.create();
    }

    await file.writeAsString(csv, mode: FileMode.append, flush: true);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Feedback Saved!')));
    _feedbackController.clear();
  }
}

