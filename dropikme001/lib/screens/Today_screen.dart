import 'dart:async';

import 'package:dotted_line/dotted_line.dart';
import 'package:dropikme001/model/AddMemberLeave.dart';
import 'package:dropikme001/model/Failed.dart';
import 'package:dropikme001/model/GetLeaveType.dart';
import 'package:dropikme001/model/GetShiftType.dart';
import 'package:dropikme001/model/Leave_type.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/mapingmember.dart';
import 'package:dropikme001/screens/Leave_screen.dart';
import 'package:dropikme001/screens/Navigation_screen.dart';
import 'package:dropikme001/screens/Profile_detail_screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/AppImages.dart';
import 'package:dropikme001/utils/Apptextstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../utils/AppColors.dart';

class TodayScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>Today();

}
class Today extends State<TodayScreen>{
  String shiftid="";
  String vehicalid="";
  List<MemberLeave> list_leave = [];
  bool isLoading=false;
  bool lable=false;

  List<LeaveTypeElement> Leaveitems = [];
  LeaveTypeElement? Selectedleave;
  List<DropdownMenuItem<LeaveTypeElement>>? _dropdownLeave;
  List<ShiftTypeElement> Shiftitems = [];
  ShiftTypeElement? Selectedshift;
  int? shift=1;
  String leavename="";
  List<DropdownMenuItem<ShiftTypeElement>>? _dropdownShift;
  TextEditingController reason=TextEditingController();
  String date=DateFormat('dd-MM-yyyy').format(DateTime.now());
  @override
  void initState(){
    super.initState();
    getleave();
    getshift();
    setdata();
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
                    controller: reason,
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
                          shift!=1?
                          Addmemberleavewithshift(Selectedleave!.id,Selectedshift!.id,reason.text,date,date):Addmemberleavewithoutshift(Selectedleave!.id,Selectedshift!.id,reason.text,date,date);

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

  void Addmemberleavewithshift(String leavetype,String shifttype,String reson,String startdate,String enddate)async {
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login addleave=await sessionManagement.getmodel("Member");
    String token= addleave.result.member.response.token;
    String memberid=addleave.result.member.response.memberId; // Replace this with your DateTime object
  //  DateTime dateTime = DateTime.parse("03-05-2023 00:00:00.000"); // Replace this with your DateTime object
   // String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTime);
   // print(formattedDateTime);
    print(token);
    DateTime dateTime1 = DateFormat('dd-MM-yyyy').parse(startdate); // Replace this with your DateTime object
    String STARTDATE = DateFormat('yyyy-MM-dd').format(dateTime1);
    DateTime dateTime = DateFormat('dd-MM-yyyy').parse(enddate); // Replace this with your DateTime object
    String ENDDATE = DateFormat('yyyy-MM-dd').format(dateTime);
    AddMemberLeave login= await api.AddMemberleave(token,memberid,Selectedshift!.id,Selectedleave!.id,vehicalid,reason.text,STARTDATE,ENDDATE,"","","","",memberid,memberid);
    if(login.message=="Ok"){
      Fluttertoast.showToast(msg: "Leave Add successfully",toastLength: Toast.LENGTH_LONG);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LeaveScreen())).whenComplete(() => ApiCall());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex:1)), (route) => false);

    }else{
      Fluttertoast.showToast(msg: "Leave not Add",toastLength: Toast.LENGTH_LONG);
    }

  }
  void Addmemberleavewithoutshift(String leavetype,String shifttype,String reson,String startrdate,String enddate)async {

    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login addleave=await sessionManagement.getmodel("Member");
    String token= addleave.result.member.response.token;
    String memberid=addleave.result.member.response.memberId;
    DateTime dateTime1 = DateFormat('dd-MM-yyyy').parse(startrdate); // Replace this with your DateTime object
    String STARTDATE = DateFormat('yyyy-MM-dd').format(dateTime1);
    DateTime dateTime = DateFormat('dd-MM-yyyy').parse(enddate); // Replace this with your DateTime object
    String ENDDATE = DateFormat('yyyy-MM-dd').format(dateTime);
    AddMemberLeave login= await api.AddMemberleave(token,memberid,Selectedshift!.id,Selectedleave!.id,vehicalid,reason.text,STARTDATE,ENDDATE,"","","","",memberid,memberid);
    if(login.message=="Ok"){
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveScreen())).whenComplete(() => ApiCall());
      Fluttertoast.showToast(msg: "Leave Add successfully",toastLength: Toast.LENGTH_LONG);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex:1)), (route) => false);
    }else{
      Fluttertoast.showToast(msg: "Leave not Add",toastLength: Toast.LENGTH_LONG);
    }

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
      leavename=leave.result.member.businessNameAdd;
      print(leavename);
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


  void setdata()async {
    print("jfglrjfwkjdlxm,mx c,mdhiehfdnckxmzc,xz x.,jdleskjdmc ");
    SessionManagement session=await SessionManagement();
    Mappingmember map=await session.getmodelMap("Map");
    print(map);
    setState(() {
      shiftid=map.result.memberDefaultMapping[0].shiftTypeId;
      vehicalid=map.result.memberDefaultMapping[0].memberVehicleRegId;
    });
    print(shiftid);
    print("hsgfsdhiufds");
    print(vehicalid);

  }


}





// void CheckLogin(String username,String deviceid,String Devicedetail,bool isfrommobile) async{
//   HttpService api=  HttpService();
//   SessionManagement sessionManagement=SessionManagement();
//   Login data=await sessionManagement.getmodel('Member');
//   String token=data.result.member.response.token;
//   String memberid=data.result.member.response.memberId;
//   dynamic login= await api.AddMemberleavedata(token,memberid,Selectedshift!.id,Selectedleave!.id,vehicalid,reason.text,date,date,"","","","",memberid,memberid);
//   print(login["isSuccess"]);
//   if(login["isSuccess"]==true){
//     AddMemberLeave logindata=AddMemberLeave.fromJson(login);
//     Fluttertoast.showToast(msg: logindata.message,toastLength: Toast.LENGTH_LONG);
//     setState(() {
//       isLoading=false;
//     });
//
//   }else{
//     Failed fail=Failed.fromJson(login);
//     Fluttertoast.showToast(msg: fail.message,toastLength: Toast.LENGTH_SHORT);
//     print(fail.message);
//     setState(() {
//       isLoading=false;
//     });
//   }
// }
