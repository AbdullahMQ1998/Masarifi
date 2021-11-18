import 'package:flash_chat/notification/notificationAPI.dart';
import 'package:flutter/material.dart';


class NotificationCenter extends StatefulWidget {
  @override
  _NotificationCenterState createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  @override
  Widget build(BuildContext context) {
    TimeOfDay selectedTime = TimeOfDay.now();
    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay picked_s = await showTimePicker(
          context: context,
          initialTime: selectedTime, builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child,
        );});

      if (picked_s != null && picked_s != selectedTime )
        setState(() {
          selectedTime = picked_s;

        }



        );
    }
    return Scaffold(

      body: Column(

        children: [

          Center(
            child: Text(
              'Notifications',
              style: TextStyle(
                  color: Color(0xff01937C),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          FlatButton(onPressed: () {
            _selectTime(context);
          }, child: Text("Select Time"))

        ],
      ),

    );
  }
}
