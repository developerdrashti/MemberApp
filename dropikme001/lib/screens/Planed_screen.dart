import 'package:dotted_line/dotted_line.dart';
import 'package:dropikme001/model/AddMemberLeave.dart';
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

import '../model/GetLeaveType.dart';
import '../utils/AppColors.dart';

class PlanedScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>Planed();

}
class Planed extends State<PlanedScreen>{
  String shiftid="";
  String vehicalid="";
  List<MemberLeave> list_leave = [];
  bool isLoading=false;
  List<LeaveTypeElement> Leaveitems = [];
  LeaveTypeElement? Selectedleave;
  List<DropdownMenuItem<LeaveTypeElement>>? _dropdownLeave;
  List<ShiftTypeElement> Shiftitems = [];
  ShiftTypeElement? Selectedshift;
  List<DropdownMenuItem<ShiftTypeElement>>? _dropdownShift;
  TextEditingController reason=TextEditingController();
  TextEditingController startdate=TextEditingController();
  TextEditingController enddate=TextEditingController();
  int shift=1;
  bool Sdate =false;
  bool Edate =false;
  bool reson =false;
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
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(

                  margin: EdgeInsets.only(bottom: 70),
                  padding: EdgeInsets.all(20),
                  child:   Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    // decoration: const BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.only(
                    //         topRight: Radius.circular(30),
                    //         topLeft: Radius.circular(30))),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Leave Type',style: TextStyle(fontWeight: FontWeight.w600,
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
                            Text('Start Date',style: TextStyle(fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                                fontSize: 18,
                                color: Appcolors.black),),
                            SizedBox(height: 10,),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: TextField(
                                onTap: (){
                                  Startdate();
                                },

                                controller: startdate,
                                style:TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w500,
                                ),
                                autofocus: false,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                      12.0,
                                    ),
                                  ),
                                  enabledBorder:
                                  OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            12.0)),
                                    borderSide: BorderSide(

                                    ),

                                  ),


                                  hintText: "Select Start date",
                                  errorText: Sdate?"":null,
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w500,
                                  ),

                                  contentPadding:
                                  const EdgeInsets.all(20),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text('End Date',style: TextStyle(fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                                fontSize: 18,
                                color: Appcolors.black),),
                            SizedBox(height: 10,),

                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: TextField(
                                onTap: (){
                                  Enddate();
                                },

                                controller: enddate,
                                style:TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w500,
                                ),
                                autofocus: false,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                      12.0,
                                    ),
                                  ),
                                  enabledBorder:
                                  OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            12.0)),
                                    borderSide: BorderSide(

                                    ),

                                  ),


                                  hintText: "Select End date",
                                  errorText: Edate?"":null,
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w500,
                                  ),

                                  contentPadding:
                                  const EdgeInsets.all(20),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            shift==true?Text('Shift Type',
                              style: TextStyle(fontWeight: FontWeight.w600,
                                  fontFamily: "OpenSans",
                                  fontSize: 18,
                                  color: Appcolors.black),):Text('',
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
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: TextField(
                                controller: reason,
                                style:TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w500,
                                ),
                                autofocus: false,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                      12.0,
                                    ),
                                  ),
                                  enabledBorder:
                                  OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            12.0)),
                                    borderSide: BorderSide(

                                    ),

                                  ),

                                  hintText: "Enter Your Reson",
                                  errorText: reson?"":null,
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  contentPadding:
                                  const EdgeInsets.all(20),
                                ),
                              ),
                            ),



                          ],
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
          Column(
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
                        //Navigator.push(context,MaterialPageRoute(builder: (context)=>EditStudentsDetails()));
                        print('singin');
                       // shift==true?Addmemberleavewithshift(Selectedleave!.id,Selectedshift!.id,reason.text,startdate.text,enddate.text):Addmemberleavewithoutshift(Selectedleave!.id,Selectedshift!.id,reason.text,startdate.text,enddate.text);

                        if(startdate.text.isNotEmpty && enddate.text.isNotEmpty ){
                         shift==true?Addmemberleavewithshift(Selectedleave!.id,Selectedshift!.id,reason.text,startdate.text,enddate.text):Addmemberleavewithoutshift(Selectedleave!.id,Selectedshift!.id,reason.text,startdate.text,enddate.text);
                       }else{
                         setState(() {
                           startdate.text.trim().isEmpty?Sdate=true:Sdate=false;
                           enddate.text.trim().isEmpty?Edate=true:Edate=false;
                          // reason.text.trim().isEmpty?reson=true:reson=false;
                         });
                      }
                      },
                      child: Text('Submit',style: TextStyle(
                          fontFamily:'OpenSans',fontSize: 18,fontWeight: FontWeight.w600
                      ),),
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }

  void Startdate() async {

    DateTime? pickedDate = await showDatePicker(
        context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101)
    );

    if(pickedDate != null ){
      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      print(formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement
      setState(() {
        startdate.text = formattedDate; //set output date to TextField value.
      });
    }else{
      print("Date is not selected");
    }

  }
  void Enddate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101)
    );

    if(pickedDate != null ){
      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      print(formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        enddate.text = formattedDate; //set output date to TextField value.
      });
    }else{
      print("Date is not selected");
    }

  }

  void Addmemberleavewithshift(String leavetype,String shifttype,String reson,String startdate,String enddate)async {
    print("add member leave");
    print("add with shift");
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login addleave=await sessionManagement.getmodel("Member");
    String token= addleave.result.member.response.token;
    String memberid=addleave.result.member.response.memberId; // Replace this with your DateTime object
    DateTime dateTime = DateTime.parse("03-05-2023 00:00:00.000"); // Replace this with your DateTime object
    String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTime);
    print("sdata print");
    print(formattedDateTime);
    print(token);
    AddMemberLeave login= await api.AddMemberleave(token,memberid,Selectedshift!.id,Selectedleave!.id,vehicalid,reason.text,formattedDateTime,formattedDateTime,"","","","",memberid,memberid);
    if(login.message=="Ok"){

      Fluttertoast.showToast(msg: "Leave Add successfully",toastLength: Toast.LENGTH_LONG);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LeaveScreen())).whenComplete(() => ApiCall());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex:1)), (route) => false);

    }else{
      Fluttertoast.showToast(msg: "Leave not Add",toastLength: Toast.LENGTH_LONG);
    }

  }
  void Addmemberleavewithoutshift(String leavetype,String shifttype,String reson,String startrdate,String enddate)async {
    print("add member leave");
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login addleave=await sessionManagement.getmodel("Member");
    String token= addleave.result.member.response.token;
    String memberid=addleave.result.member.response.memberId;
    print(token);
    DateTime dateTime1 = DateFormat('dd-MM-yyyy').parse(startrdate); // Replace this with your DateTime object
    String STARTDATE = DateFormat('yyyy-MM-dd').format(dateTime1);
    print("sdata print");
    print(STARTDATE);
    DateTime dateTime = DateFormat('dd-MM-yyyy').parse(enddate); // Replace this with your DateTime object
    String ENDDATE = DateFormat('yyyy-MM-dd').format(dateTime);
    print("sdata printABCDEFGTHG<SD<C:<:<C:LX<");
    print(STARTDATE);
    AddMemberLeave login= await api.AddMemberleave(token,memberid,Selectedshift!.id,Selectedleave!.id,vehicalid,reason.text,STARTDATE,ENDDATE,"","","","",memberid,memberid);
    if(login.message=="Ok"){
      print("update data successfully");
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
    print(vehicalid);
    DateTime dateTime = DateTime.now(); // Replace this with your DateTime object
    String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
    print("sdata print");
    print(formattedDateTime);

  }

}









