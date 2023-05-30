import 'package:dotted_line/dotted_line.dart';
import 'package:dropikme001/model/AddMemberLeave.dart';
import 'package:dropikme001/model/GetLeaveType.dart';
import 'package:dropikme001/model/GetShiftType.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/NotificationUpdate.dart';
import 'package:dropikme001/model/Notificationlist.dart';
import 'package:dropikme001/screens/Profile_detail_screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/AppImages.dart';
import 'package:dropikme001/utils/Apptextstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/AppColors.dart';

class OldNotificationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>OldNotification();

}
class OldNotification extends State<OldNotificationScreen>{
  List<Notificatiodata> list_notification=[];
  String MemberName="";
  @override
  void initState(){
    super.initState();
    getnotification();
    Apiupdate();
    setdata();

  }
  Widget build(BuildContext context){
    return Scaffold(

      body: Stack(
        children: [
          Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                      child:
                      list_notification.isEmpty?Center(child: Text("No Data Found"),):ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount:list_notification.isEmpty?2:list_notification.length,
                          itemBuilder: (context, position) {
                            // StudentList student=  list_student.length.toString();
                            return GestureDetector(
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>studentsdetails(list_student[position].wpUsrId,widget.wpid)));
                              },
                              child: Container(
                                margin:
                                const EdgeInsets.only(left: 20, right: 20,top: 10),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    // height: 120,
                                    decoration: BoxDecoration(
                                        color: Appcolors.primary.withOpacity(0.05),
                                        borderRadius: const BorderRadius.all(Radius.circular(15))),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(

                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Container(
                                                    margin: EdgeInsets.all(10),

                                                    height: 50,
                                                    width: 50,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.all(Radius.circular(50))
                                                    ),
                                                    child: ClipRRect(


                                                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                                                        child: Image.asset(AppImages.bus,
                                                          fit: BoxFit.fitHeight,)
                                                    )
                                                )
                                            ),
                                            // Padding(padding: EdgeInsets.only(left: 10,top: 10),child:
                                            // Container(
                                            //   height: 10,
                                            //   width: 10,
                                            //   decoration: BoxDecoration(
                                            //       color: Colors.green,
                                            //       borderRadius: BorderRadius.all(Radius.circular(20))
                                            //   ),
                                            // ))
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(child:  list_notification[position].isRead==false?Text(
                                                  MemberName,
                                                  style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w400),
                                                ):Text(
                                                  MemberName,
                                                  style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600),
                                                ),),
                                                Text(
                                                  "5 min ago",
                                                  style: Apptextstyle.lable.copyWith(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Apptextstyle.dividercoman,
                                            SizedBox(height: 5,),
                                            Text(
                                              list_notification.isEmpty?"":list_notification[position].message,
                                              style: Apptextstyle.lable.copyWith(fontSize: 14),
                                            ),


                                          ],
                                        ),),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                ],
              )),


        ],
      )
    );
  }

  void getnotification()async {
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login sosrequest=await sessionManagement.getmodel("Member");
    String token= sosrequest.result.member.response.token;
    String memberid=sosrequest.result.member.response.memberId;
    print(memberid);
    NotificationList login= await api.getNotification(token,memberid,"MEB","OLD");
    print("eruatuewaoirafj:DSJFoia;jfgrolds");
    print(login.message);
    if(login.message=="Ok"){
      setState(() {
        list_notification=login.result;
      });
      print("FULL NOTIFICATION LIST SHOW");
      print(list_notification);
    }else{
      Fluttertoast.showToast(msg: "Wait Request not Add",toastLength: Toast.LENGTH_LONG);
    }

  }
  void Apiupdate()async {
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login sosrequest=await sessionManagement.getmodel("Member");
    String token= sosrequest.result.member.response.token;
    String memberid=sosrequest.result.member.response.memberId;
    print(memberid);
    NotificationUpdate login= await api.getNotificationupdate(token,memberid,"CLEAR",);
    if(login.message=="Ok"){
      setState(() {
      });
      print("FULL NOTIFICATION LIST SHOW");
      print(list_notification);
    }else{
      Fluttertoast.showToast(msg: "Wait Request not Add",toastLength: Toast.LENGTH_LONG);
    }

  }

  Future<void> setdata() async {
    SessionManagement sessionManagment = SessionManagement();
    Login student = await sessionManagment.getmodel('Member');

    setState(() {

      MemberName = student.result.member.response.memberName;

    });
  }


}