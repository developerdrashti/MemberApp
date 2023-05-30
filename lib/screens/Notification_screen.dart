import 'package:dropikme001/screens/New_Notification.dart';
import 'package:dropikme001/screens/Old_Notification.dart';
import 'package:dropikme001/screens/Planed_screen.dart';
import 'package:dropikme001/screens/Today_screen.dart';
import 'package:dropikme001/utils/AppColors.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Notification();


}

class Notification extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Appcolors.primary,
            title: Text('Notification',
              style: TextStyle(fontWeight: FontWeight.w400,
                  fontFamily: "OpenSans",fontSize: 20),),
          ),


          body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Appcolors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: TabBar(
                    labelColor: Appcolors.primary,
                    unselectedLabelColor: Appcolors.black,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2,color: Appcolors.primary),// Creates border
                        color: Colors.white), //


                    tabs: [

                      Tab(
                        child: Text("New",),
                      ),
                      Tab( text: "Old")
                    ],
                  ),
                ),
                Expanded(child: TabBarView(children: [
                  NewNotificationScreen(),
                  OldNotificationScreen()
                ],))
              ],
            ),
          )
      ),
    );
  }
}