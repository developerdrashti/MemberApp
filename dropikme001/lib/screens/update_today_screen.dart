import 'dart:async';
import 'package:dropikme001/model/GetLeaveType.dart';
import 'package:dropikme001/model/GetShiftType.dart';
import 'package:dropikme001/model/Leave_type.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/SingleMemberleave.dart';
import 'package:dropikme001/model/UpdateLeaveMember.dart';
import 'package:dropikme001/model/mapingmember.dart';
import 'package:dropikme001/screens/Navigation_screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/Apptextstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../utils/AppColors.dart';

class TodayupdateScreen extends StatefulWidget{
  var id;
  var shift;
  var leave;
 TodayupdateScreen(this.id,this.shift,this.leave);


  @override
  State<StatefulWidget> createState() =>UpdateToday();

}
class UpdateToday extends State<TodayupdateScreen>{
 SingleMemberLeave? singlelist_leave ;
 String shiftid="";
 String shiftdata="";
 String leavedata="";
  bool isLoading=false;
  bool lable=false;
  List<LeaveTypeElement> Leaveitems = [];
  LeaveTypeElement? Selectedleave;
  List<DropdownMenuItem<LeaveTypeElement>>? _dropdownLeave;
  List<ShiftTypeElement> Shiftitems = [];
  ShiftTypeElement? Selectedshift;
  int? shift=1;
  List<DropdownMenuItem<ShiftTypeElement>>? _dropdownShift;
  TextEditingController reasontoday=TextEditingController();
  String date=DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  void initState(){
    super.initState();
    setdata();
    setdataleave();
    getleave();
    getshift();
  }
  Widget build(BuildContext context){
    return Scaffold(

      body: Stack(
        children: [
          Container(
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Leave Type',
                      style: TextStyle(fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans",
                          fontSize: 18,
                          color: Appcolors.black),),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,

                      height: 50,
                      padding: EdgeInsets.only(top: 10,left:20,right: 20,bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.08),
                        borderRadius:
                        BorderRadius.circular(
                            12.0),

                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(widget.leave),

                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down,
                            ),
                            value: Selectedleave,
                            items: _dropdownLeave,
                            onChanged: (value) {
                              setState(() {
                                Selectedleave= value as LeaveTypeElement? ;
                              });
                            }),
                      ),
                    ),
                    SizedBox(height: 10,),
                    shift!=1?Text('Shift Type',
                      style: TextStyle(fontWeight: FontWeight.w600,
                          fontFamily: "OpenSans",
                          fontSize: 18,
                          color: Appcolors.black),):Text(""),
                    SizedBox(height: 10,),
                    shift!=1?Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      padding: EdgeInsets.only(top: 10,left:20,right: 20,bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.08),
                        borderRadius:
                        BorderRadius.circular(
                            12.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(widget.shift),
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down,
                            ),
                            value: Selectedshift,
                           items: _dropdownShift,
                            onChanged: (value) {
                              setState(() {
                                Selectedshift = value as ShiftTypeElement?  ;
                              });
                            }),
                      ),
                    ):Text(""),
                    SizedBox(height: 10,),
                    Text('Reason',style: TextStyle(fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                        fontSize: 18,
                        color: Appcolors.black),),
                    SizedBox(height: 10,),

                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.black.withOpacity(0.05)
                      ),
                      child: TextField(
                        maxLines: 5,
                        controller: reasontoday,
                        decoration:  InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Enter Valid Reson',
                            hintStyle: Apptextstyle.lable.copyWith(fontSize: 14,color: Appcolors.black.withOpacity(0.5))

                        ),
                        autofocus: false,
                      ),
                    ),

                  ],
                ),
              )
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(

                    padding:  EdgeInsets.all(20),
                    color: Colors.white,
                    child: SizedBox(
                      height: 60,
                      width: 360,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shadowColor: MaterialStateProperty.all(Appcolors.primary),

                            backgroundColor: MaterialStateProperty.all(
                                Appcolors.primary),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                )
                            )
                        ),

                        onPressed: () {
                          updateleave(date,reasontoday.text);


                        },
                        child: Text('Submit',style: TextStyle(
                            fontFamily:'OpenSans',fontSize: 18,fontWeight: FontWeight.w600
                        ),),
                      ),
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  void getleave() async {
    HttpService httpService = HttpService();
    SessionManagement sessionManagement = SessionManagement();
    Login leave =
    await sessionManagement.getmodel("Member");
    String token = leave.result.member.response.token;
    LeaveType? country = await httpService.getLeavetype();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
      Leaveitems = country.leaveTypes;
      Selectedleave = Leaveitems.first;
      _dropdownLeave = buildDropDownleaveItems(Leaveitems);
      setState(() {
      });
    }));
  }
  List<DropdownMenuItem<LeaveTypeElement>> buildDropDownleaveItems(List listItems) {
    List<DropdownMenuItem<LeaveTypeElement>> items = [];
    for (LeaveTypeElement listItem in listItems) {
      items.add(
        DropdownMenuItem(
          value: listItem,
          child: Text(
              listItem.name,
              style: Apptextstyle.lable.copyWith(fontSize: 14)
          ),
        ),
      );
    }
    return items;
  }
  void getshift() async {
    HttpService httpService = HttpService();
    SessionManagement sessionManagement = SessionManagement();
    Login leave = await sessionManagement.getmodel("Member");
    String token = leave.result.member.response.token;
    ShiftType? country = await httpService.getShiftType(token);
    print(country.message);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
      Shiftitems = country.shiftTypes;
     Selectedshift = Shiftitems.first;
      _dropdownShift = buildDropDownshiftItems(Shiftitems);
      shift=country.shiftTypes.length ;
    }));
    print(Shiftitems);
  }
  List<DropdownMenuItem<ShiftTypeElement>> buildDropDownshiftItems(List listItems) {
    List<DropdownMenuItem<ShiftTypeElement>> items = [];
    for (ShiftTypeElement listItem in listItems) {
      items.add(
        DropdownMenuItem(
          value: listItem,
          child: Text(
              listItem.name,
              style: Apptextstyle.lable.copyWith(fontSize: 14)
          ),
        ),
      );
    }
    return items;



  }



  void updateleave(String date,String reason) async {
    print("UPDATED PROFILE");
    HttpService api = HttpService();
    SessionManagement sessionManagement = await SessionManagement();
    Login updateprofile = await sessionManagement.getmodel("Member");
    String token = updateprofile.result.member.response.token;
    String memberid = updateprofile.result.member.response.memberId;
    UpdateMemberleave update = await api.updateMemberleave(token, widget.id,date,date,reason,Selectedshift!.id,Selectedleave!.id);
    print(update.message);
    if (update.message == "Ok") {
      setState(() {

      });
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex: 1,)), (route) => false);
      Fluttertoast.showToast(
          msg: update.message, toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(msg: "notupdated", toastLength: Toast.LENGTH_LONG);
    }
  }
  void setdataleave() async {
    HttpService httpService = HttpService();
    SessionManagement sessionManagment = SessionManagement();
    Login login=await sessionManagment.getmodel("Member");
    String token=login.result.member.response.token;
    String memberid=login.result.member.response.memberId;
    dynamic country = await httpService.getMembersingleleavelist(token,widget.id);
    if(country['isSuccess']){
      print("ASDFGHJKLZXCVBNMQWERTYUIOP");
      Membersingleleave teacher = Membersingleleave.fromJson(country);
      setState((){
        singlelist_leave=teacher.result.singleMemberLeave;
        reasontoday.text=singlelist_leave!.reason;
        shiftdata=singlelist_leave!.shiftTypeId;
        leavedata=singlelist_leave!.leaveTypeId;
        isLoading=false;
        print(singlelist_leave!.reason);
        print(singlelist_leave!.shiftTypeId);
        print(singlelist_leave!.shiftTypeId);
      });
    } else{
      setState((){
        isLoading=false;

      });
    }


  }


 void setdata()async {
   print("jfglrjfwkjdlxm,mx c,mdhiehfdnckxmzc,xz x.,jdleskjdmc ");
   SessionManagement session=await SessionManagement();
   Mappingmember map=await session.getmodelMap("Map");
   print(map);
   setState(() {
     shiftid=map.result.memberDefaultMapping[0].shiftTypeId;
   //  vehicalid=map.result.memberDefaultMapping[0].memberVehicleRegId;
   });
   print(shiftid);
   print("hsgfsdhiufds");
  // print(vehicalid);

 }

}