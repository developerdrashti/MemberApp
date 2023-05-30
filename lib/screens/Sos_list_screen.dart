
import 'dart:async';

import 'package:dropikme001/model/Failed.dart';
import 'package:dropikme001/model/Leave_type.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/NotificationCount.dart';
import 'package:dropikme001/model/Soslist.dart';
import 'package:dropikme001/model/clearallsos.dart';
import 'package:dropikme001/model/driverleave.dart';
import 'package:dropikme001/screens/Leave_details_screen.dart';
import 'package:dropikme001/screens/Navigation_screen.dart';
import 'package:dropikme001/screens/Notification_screen.dart';
import 'package:dropikme001/screens/Sos_Screen.dart';
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

class SOS_List_Screen extends StatefulWidget{


  State<SOS_List_Screen> createState() => SOSLIST();
}
class SOSLIST extends State<SOS_List_Screen>{
  String count="";

List<MemberSosRequestList> list_sos=[];


  @override
  void initState() {
    super.initState();

    getsoslist();
    _refreshList();
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
                      child: list_sos.isEmpty?Center(child: Text("No Data found"),):
                      ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: list_sos.isEmpty?5:list_sos.length,

                          itemBuilder: (context,position){
                            String timeString = '13:30'; // Example time string

                            DateTime parsedTime = DateFormat('HH:mm').parse(timeString);

                            TimeOfDay time = TimeOfDay.fromDateTime(list_sos[position].createdAt);
                            DateTime now = list_sos[position].createdAt;
                            DateTime timeAsDateTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);

                            String formattedTime = DateFormat('h:mm a').format(timeAsDateTime);
                         //   String startdate=list_sos.isEmpty?"11 jan 2023":DateFormat('dd-MM-yyyy').format(list_sos[position].result.memberSosRequestList.length.toString());
                           // String Enddate=list_sos.isEmpty?"11 jan 2023":DateFormat('dd-MM-yyyy').format(list_sos[position].endDate);
                            //String dateend=list_sos.isEmpty?"11 jan 2023":DateFormat('dd-MM-yyyy').format(list_sos[position].endDate);



                            return GestureDetector(

                              onLongPress: (){
                                print('fhgfdsljoisadjfsigjfdslkjv');
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Wrap(
                                      children: [
                                        ListTile(
                                          onTap:(){
                                            Claearallsos();
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
                                                   Expanded(child:  Text(list_sos.isEmpty?"":DateFormat('dd-MM-yyyy').format(list_sos[position].createdAt),style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600),),),
                                        // Text(DateFormat('hh:mm').parse(list_sos[position].createdAt.hour.toString()+ ":" + list_sos[position].createdAt.minute.toString()) as String),
                                          // DateFormat("hh:mm").parse(
                                          //     _selectedTime!.hour.toString() +
                                          //         ":" + _selectedTime!.minute.toString());
                                          //         Tex

                                                  Text(formattedTime,style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600),)
                                                    // startdate==Enddate?Text(""):Text(" TO ${Enddate}",style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600),)
                                                    // date==true?Text(""):Text("data"),
                                                    //Text("$Enddate",style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600),)


                                                  ],
                                                ),
                                                
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

          // Visibility(
          //     visible: isLoading,
          //     child:  Container(
          //       color: Colors.black.withOpacity(0.5),
          //       height: MediaQuery.of(context).size.height,
          //       width: MediaQuery.of(context).size.width,
          //       child: Center(
          //         child: LoadingLayout(),
          //       ),
          //     )),
          Align(

              alignment: Alignment.bottomRight,
              child:  Padding(
                padding: EdgeInsets.all(10),
                child:  FloatingActionButton(

                    backgroundColor: Appcolors.primary,
                    child: Icon(Icons.add),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Sosscreen()));
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
     // isLoading=true;
      getsoslist();
    });
  }





  void getsoslist()async {
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login sosrequest=await sessionManagement.getmodel("Member");
    String token= sosrequest.result.member.response.token;
    String memberid=sosrequest.result.member.response.memberId;
    print(memberid);
    SosList login= await api.getsoslist(token,memberid);
    if(login.message=="Ok"){
      setState(() {
        list_sos=login.result.memberSosRequestList;
      });
      print("FULL NOTIFICATION LIST SHOW");
      print(list_sos);
    }else{
      Fluttertoast.showToast(msg: "Wait Request not Add",toastLength: Toast.LENGTH_LONG);
    }

  }

  void Claearallsos()async {
    print("add member leave");
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login addleave=await sessionManagement.getmodel("Member");
    String token= addleave.result.member.response.token;
    String memberid=addleave.result.member.response.memberId;
    print(token);
    print(memberid);
    ClearAllsosRequest login= await api.Clearallsosdata(
        token,
        memberid);
    if(login.message=="Ok"){
      Fluttertoast.showToast(msg: "data clear successfully",toastLength: Toast.LENGTH_LONG);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LeaveScreen())).whenComplete(() => ApiCall());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex: 4,)), (route) => false);

    }else{
      Fluttertoast.showToast(msg: "Leave not Add",toastLength: Toast.LENGTH_LONG);
    }

  }


}





