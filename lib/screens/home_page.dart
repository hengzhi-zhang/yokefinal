import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final selectedTimeSlots = {};

  @override
  void initState() {
    super.initState();
    for (var day in daysOfWeek) {
      selectedTimeSlots[day] = TimeSlot();
    }
  }

  Future<void> _selectTime(BuildContext context, TimeSlot timeSlot, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        if (isStartTime) {
          timeSlot.startTime = picked;
        } else {
          timeSlot.endTime = picked;
        }
      });
  }

  void _findPartner() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('/Users/hengzhi/Downloads/IMG_4800.JPG'), // or NetworkImage(url)
              ),
              SizedBox(height: 20),
              Text(
                'Partner found: Hengzhi Zhang',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _findPartner,
              child: Text('Find a Partner', style: TextStyle(color: Colors.black)), // Setting the text color to black
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // This is the button color
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: daysOfWeek.length,
                itemBuilder: (context, index) {
                  String day = daysOfWeek[index];
                  return ListTile(
                    title: Text(day),
                    subtitle: Row(
                      children: [
                        ElevatedButton(
  onPressed: () => _selectTime(context, selectedTimeSlots[day], true),
  child: Text(selectedTimeSlots[day].startTime?.format(context) ?? "Start Time", style: TextStyle(color: Colors.black)),
  style: ElevatedButton.styleFrom(primary: Colors.white),
),
                        SizedBox(width: 10),
                        ElevatedButton(
  onPressed: () => _selectTime(context, selectedTimeSlots[day], false),
  child: Text(selectedTimeSlots[day].endTime?.format(context) ?? "End Time", style: TextStyle(color: Colors.black)),
  style: ElevatedButton.styleFrom(primary: Colors.white),
),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logic to save the data goes here.
          print(selectedTimeSlots);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

class TimeSlot {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  TimeSlot({this.startTime, this.endTime});
}

void main() => runApp(MaterialApp(home: HomePage()));





