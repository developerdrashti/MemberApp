import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(TimeConversionApp());
}

class TimeConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // TimeOfDay time = TimeOfDay(hour: 13, minute: 30); // Example TimeOfDay object

    DateTime now = DateTime.now();
    DateTime timeAsDateTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);

    String formattedTime = DateFormat('h:mm a').format(timeAsDateTime);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Time Conversion Example'),
        ),
        body: Center(
          child: Text(
            'Formatted Time: $formattedTime',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
