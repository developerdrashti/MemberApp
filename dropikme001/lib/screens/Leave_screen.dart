
import 'dart:async';

import 'package:dropikme001/model/CancelMemberLeave.dart';
import 'package:dropikme001/model/ClearAllLeave.dart';
import 'package:dropikme001/model/Failed.dart';
import 'package:dropikme001/model/Leave_type.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/NotificationCount.dart';
import 'package:dropikme001/model/driverleave.dart';
import 'package:dropikme001/screens/Leave_details_screen.dart';
import 'package:dropikme001/screens/Navigation_screen.dart';
import 'package:dropikme001/screens/Notification_screen.dart';
import 'package:dropikme001/screens/Update_leave_screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/Apptextstyle.dart';
import 'package:dropikme001/utils/LoadingLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../utils/AppColors.dart';

class LeaveScreen extends StatefulWidget{


  State<LeaveScreen> createState() => Leave();
}
class Leave extends State<LeaveScreen>{
  List<MemberLeave> list_leave = [];
  bool isLoading=false;
  bool lable=false;
  bool dateshow=false;
  String leaveid="";
  String count="";



  @override
  void initState() {
    super.initState();
    isLoading=true;
    setdata();
    getleavelist();
    _refreshList();
    //getnotification();
  }
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
      Container(
        child:    Column(
          children: [
            Expanded(
                child:  RefreshIndicator(
                  onRefresh: _refreshList,
                  child: list_leave.isEmpty?Center(child: Text("No Data found"),):
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: list_leave.isEmpty?5:list_leave.length,
                      itemBuilder: (context,position){
                        String startdate=list_leave.isEmpty?"11 jan 2023":DateFormat('dd-MM-yyyy').format(list_leave[position].startDate);
                        String Enddate=list_leave.isEmpty?"11 jan 2023":DateFormat('dd-MM-yyyy').format(list_leave[position].endDate);
                      String dateend=list_leave.isEmpty?"11 jan 2023":DateFormat('dd-MM-yyyy').format(list_leave[position].endDate);



                        return GestureDetector(
                          onTap: (){
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>LeavedetailupdateScreen(list_leave[position].id,list_leave[position].reason,Enddate,startdate)));
                          },
                          onLongPress: (){

                            print('fhgfdsljoisadjfsigjfdslkjv');
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                      onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LeavedetailupdateScreen(list_leave[position].id,list_leave[position].reason,Enddate,startdate,list_leave[position].shiftTypeName,list_leave[position].leaveTypeName)));

                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    ),
                                    ListTile(
                                      onTap:(){
                                        deleteleave(list_leave[position].id);
                                      },
                                      leading: Icon(Icons.delete_outline),
                                      title: Text('Cancel'),
                                    ),
                                    ListTile(
                                      onTap:(){
                                        Claearallleave();
                                      },
                                      leading: Icon(Icons.clear),
                                      title: Text('Clear All'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Card(
                                  margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Expanded(child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_today),
                                                SizedBox(width: 5,),
                                                // listinox.isEmpty?"2022": DateFormat("dd/MM/yyyy").format(listinox[position].mDate as DateTime),

                                                Text("$startdate",style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600),),
                                                startdate==Enddate?Text(""):Text(" TO ${Enddate}",style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600),)




                                                // date==true?Text(""):Text("data"),
                                                //Text("$Enddate",style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600),)


                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Apptextstyle.dividercoman,
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(list_leave.isEmpty?"attend family function":list_leave[position].reason,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "OpenSans",
                                                  fontWeight: FontWeight.w400,
                                                  color: Appcolors.black.withOpacity(0.5)
                                              ),),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Apptextstyle.dividercoman,
                                            SizedBox(
                                              height: 10,
                                            ),

                                            Row(
                                              children: [
                                                Card(
                                                    elevation: 5,
                                                    color: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(5))
                                                    ),
                                                    child:  Container(
                                                        height: 30,
                                                        width: 100,
                                                        child: Center(
                                                          child: Text(list_leave.isEmpty?"":list_leave[position].shiftTypeName,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: "OpenSans",
                                                                fontWeight: FontWeight.w600,
                                                                color: Appcolors.primary
                                                            ),),
                                                        )
                                                    )
                                                ),
                                                Card(
                                                    elevation: 5,
                                                    color: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(5))
                                                    ),
                                                    child:  Container(
                                                        height: 30,
                                                        width: 100,
                                                        child: Center(
                                                          child: Text(list_leave.isEmpty?"":list_leave[position].leaveTypeName,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: "OpenSans",
                                                                fontWeight: FontWeight.w600,
                                                                color: Appcolors.primary
                                                            ),),
                                                        )
                                                    )
                                                ),
                                              ],
                                            )
                                          ],
                                        ),),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )),
          ],
        ),
      ),

          Visibility(
              visible: isLoading,
              child:  Container(
                color: Colors.black.withOpacity(0.5),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: LoadingLayout(),
                ),
              )),
          Align(

              alignment: Alignment.bottomRight,
              child:  Padding(
                padding: EdgeInsets.all(10),
                child:  FloatingActionButton(

                    backgroundColor: Appcolors.primary,
                    child: Icon(Icons.add),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LeavedetailScreen()));
                      print("next screen open");

                    }),
              )
          ),
        ],

      ),
    );
  }

  
  

  Future<void> _refreshList() async {
    setState(() {
      isLoading=true;
      getleavelist();
    });
  }

  void setdata()async {
    setState(() {
      leaveid=list_leave.length.toString();
    });

  }

  // void getnotification() async {
  //   HttpService api=  HttpService();
  //   SessionManagement sessionManagement=await SessionManagement();
  //   Login sosrequest=await sessionManagement.getmodel("Member");
  //   String token= sosrequest.result.member.response.token;
  //   String memberid=sosrequest.result.member.response.memberId;
  //   print(memberid);
  //   NotificationCount login= await api.getNotificationcount(token,memberid,"MEB",);
  //   if(login.message=="Ok"){
  //     setState(() {
  //       count=login.result[0].notificationCount.toString();
  //     });
  //     print("FULL NOTIFICATION LIST SHOW");
  //   }else{
  //     Fluttertoast.showToast(msg: "Wait Request not Add",toastLength: Toast.LENGTH_LONG);
  //   }
  // }

  void getleavelist() async {
    HttpService httpService = HttpService();
    SessionManagement sessionManagment = SessionManagement();
    Login login=await sessionManagment.getmodel("Member");
    String token=login.result.member.response.token;
    String memberid=login.result.member.response.memberId;
    dynamic country = await httpService.getMemberleavelist(token,memberid);
    print("hfglighsdljgkdLSNvkjds.ngkjfd");
    print(country);
    if(country['isSuccess']){
      MemberLeaveList teacher = MemberLeaveList.fromJson(country);
      setState((){
        list_leave=teacher.result.memberLeave!;
        isLoading=false;
      });
    } else{
      setState((){
        isLoading=false;

      });
    }


  }

  void Claearallleave()async {
    print("add member leave");
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login addleave=await sessionManagement.getmodel("Member");
    String token= addleave.result.member.response.token;
    String memberid=addleave.result.member.response.memberId;
    ClearAllmemberleave login= await api.Clearallleavedata(
        token,
        memberid);
    if(login.message=="Ok"){
      Fluttertoast.showToast(msg: "data clear successfully",toastLength: Toast.LENGTH_LONG);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex: 1,)), (route) => false);

    }else{
      Fluttertoast.showToast(msg: "Leave not Add",toastLength: Toast.LENGTH_LONG);
    }

  }
  void deleteleave(String leaveid) async {
    HttpService api = HttpService();
    SessionManagement sessionManagement = await SessionManagement();
    Login updateprofile = await sessionManagement.getmodel("Member");
    String token = updateprofile.result.member.response.token;
    Cencelleave update = await api.cancelmemberleavedata(token,leaveid);
    print(update.message);
    if (update.message == "Ok") {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex: 1,)), (route) => false);
      setState(() {
      });
      Fluttertoast.showToast(
          msg: update.message, toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(msg: "not updated leave", toastLength: Toast.LENGTH_LONG);
    }
  }


}





