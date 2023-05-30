import 'package:dropikme001/model/Leave_type.dart';
import 'package:dropikme001/screens/Planed_screen.dart';
import 'package:dropikme001/screens/Today_screen.dart';
import 'package:dropikme001/screens/update_planed_leave.dart';
import 'package:dropikme001/screens/update_today_screen.dart';
import 'package:dropikme001/utils/AppColors.dart';
import 'package:flutter/material.dart';

class LeavedetailupdateScreen extends StatefulWidget{
  var id;
 var reson;
 var enddate;var startdate;
 var shift;
 var leave;
   LeavedetailupdateScreen(this.id,this.reson,this.enddate,this.startdate,this.shift,this.leave);




  @override
  State<StatefulWidget> createState() => updateLeaveDetails();


}

class updateLeaveDetails extends State<LeavedetailupdateScreen> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: widget.startdate==widget.enddate?0:1,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Appcolors.primary,
            title: Text('Leave Detail',
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
                        child: Text("Today",),
                      ),
                      Tab( text: "Planed")
                    ],
                  ),
                ),
                Expanded(child: TabBarView(children: [
                  TodayupdateScreen(widget.id,widget.shift,widget.leave),
                  PlanedupdateScreen(widget.id,widget.shift,widget.leave)
                ],))
              ],
            ),
          )


      ),
    );
  }
}