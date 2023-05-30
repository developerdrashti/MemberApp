

import 'package:dropikme001/model/CancelComplain.dart';
import 'package:dropikme001/model/ClearAllComplain.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/Member_Complain.dart';
import 'package:dropikme001/model/NotificationCount.dart';
import 'package:dropikme001/model/NotificationUpdate.dart';
import 'package:dropikme001/screens/Complain_detail_screen.dart';
import 'package:dropikme001/screens/Navigation_screen.dart';
import 'package:dropikme001/screens/update_complain_screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../utils/AppColors.dart';
import '../utils/Apptextstyle.dart';
import '../utils/LoadingLayout.dart';
import 'Notification_screen.dart';

class ComplainScreen extends StatefulWidget{
  State<ComplainScreen> createState() => Complain();
}
class Complain extends State<ComplainScreen>{
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String Compalin="Sir, I want to draw you kind attention towards the rude and irresponsible behaviour of both the drivers and the bus conductors with the commuters. They look towards the passengers with indifference and behave with them in a very unfriendly and absurd way. They lack etiquettes and use filthy language.";
 List<DriverComplaint> list_complain=[];
 String complainstatus="";
 bool isLoading= false;
 String count="";
  bool countshow=false;

  @override
  void initState() {
    super.initState();
    getNotification();
    notificationupdate();
    isLoading=true;
    getcomplainlist();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Stack(
        children: [
       Container(
         child:    Column(
           children: [
             Expanded(
                 child:  RefreshIndicator(
                   onRefresh: _refreshList,
          child: list_complain.isEmpty?Center(child: Text("No data found"),):ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: list_complain.isEmpty?5:list_complain.length,
              itemBuilder: (context,position){
                // String year=DateFormat.d(12).format(list_complain[position].complaintDate as DateTime);
                // String date= DateFormat("dd/MM/yyyy").format(list_complain[position].complaintDate as DateTime);
                return GestureDetector(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateComplainScreen(list_complain[position].id,list_complain[position].complaintMessage)));
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateComplainScreen(list_complain[position].id,list_complain[position].complaintMessage)));

                              },
                              leading: Icon(Icons.edit),
                              title: Text('Edit'),
                            ),
                            ListTile(
                              onTap:(){
                                deletecomplain(list_complain[position].id);
                              },
                              leading: Icon(Icons.delete_outline),
                              title: Text('Delete'),
                            ),
                            ListTile(
                              onTap:(){
                                Claearallcomplain();
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
                                        Expanded(child:  Text( list_complain.isEmpty?"10-03-2022": DateFormat("dd-MM-yyyy").format(list_complain[position].complaintDate)  ,style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "OpenSans",
                                            fontWeight: FontWeight.w600,
                                            color: Appcolors.black
                                        ),
                                        ),),
                                        Card(
                                            elevation: 5,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))
                                            ),
                                            child:  Container(

                                                height: 30,
                                                width: 80,
                                                child: Center(
                                                  child: Text(list_complain.isEmpty?"new":list_complain[position].complaintStatus==0?"new":"old",
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
                                    ),


                                    SizedBox(
                                      height: 10,

                                    ),
                                    Apptextstyle.dividercoman,
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(list_complain.isEmpty?"title":list_complain[position].complaintMessage.
                                    length>150?'${ list_complain[position].complaintMessage.substring(0,100)}...' :list_complain[position].complaintMessage,

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
              })),
      ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Complaindetailscreen()));

                    }),
              )
          )
        ],

      ),
    );
  }

  void getcomplainlist() async {
    HttpService httpService = HttpService();
    SessionManagement sessionManagment = SessionManagement();
    Login login=await sessionManagment.getmodel("Member");
    String token=login.result.member.response.token;
    String memberid=login.result.member.response.memberId;
    dynamic country = await httpService.getMembercomplainlist(token,memberid);
    if(country['isSuccess']){
      Membercomplain teacher = Membercomplain.fromJson(country);
      setState((){
        list_complain=teacher.result.driverComplaints!;
        isLoading=false;
      });
    } else{
      setState((){
        isLoading=false;

      });
    }


  }



  Future<void> _refreshList() async {
    // Perform any asynchronous operation here, such as fetching new data.
    // For example, you can make an API call to get updated data.

    // Simulate a delay using Future.delayed to show the refresh indicator
    isLoading=true;
    getcomplainlist();

    // Update the data source with new data or modify the existing data.
    // For example, you can fetch new items and add them to the existing list.

    // Call setState to rebuild the widget with the updated data.
    setState(() {
    });
  }

  void getNotification() async {
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login sosrequest=await sessionManagement.getmodel("Member");
    String token= sosrequest.result.member.response.token;
    String memberid=sosrequest.result.member.response.memberId;
    print(memberid);
    NotificationCount login= await api.getNotificationcount(token,memberid,"MEB",);
    if(login.message=="Ok"){
      setState(() {
        count=login.result[0].notificationCount.toString();
      });
      print("FULL NOTIFICATION LIST SHOW");
    }else{
      Fluttertoast.showToast(msg: "Wait Request not Add",toastLength: Toast.LENGTH_LONG);
    }

  }

  void notificationupdate()async {
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login sosrequest=await sessionManagement.getmodel("Member");
    String token= sosrequest.result.member.response.token;
    String memberid=sosrequest.result.member.response.memberId;
    print(memberid);
    NotificationUpdate login= await api.getNotificationupdate(token,memberid,"CLEAR",);
    if(login.message=="Ok"){
      setState(() {
        countshow=login.result.isRead;
      });
      print("FULL NOTIFICATION LIST SHOW");
    }else{
      Fluttertoast.showToast(msg: "Wait Request not Add",toastLength: Toast.LENGTH_LONG);
    }
  }

  void deletecomplain(String complainid) async {
    HttpService api = HttpService();
    SessionManagement sessionManagement = await SessionManagement();
    Login updateprofile = await sessionManagement.getmodel("Member");
    String token = updateprofile.result.member.response.token;
    Cencelcomplain update = await api.cancelmembercomplaindata(token,complainid);
    print(update.message);
    if (update.message == "Ok") {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex: 3,)), (route) => false);
      setState(() {
      });
      Fluttertoast.showToast(
          msg: update.message, toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(msg: "not updated leave", toastLength: Toast.LENGTH_LONG);
    }
  }
  void Claearallcomplain()async {
    print("add member leave");
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login addleave=await sessionManagement.getmodel("Member");
    String token= addleave.result.member.response.token;
    String memberid=addleave.result.member.response.memberId;
    print(token);
    print(memberid);
    Clearallcomplain login= await api.Clearallcomplaindata(
        token,
        memberid);
    if(login.message=="Ok"){
      Fluttertoast.showToast(msg: "data clear successfully",toastLength: Toast.LENGTH_LONG);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LeaveScreen())).whenComplete(() => ApiCall());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex: 3,)), (route) => false);

    }else{
      Fluttertoast.showToast(msg: "Leave not Add",toastLength: Toast.LENGTH_LONG);
    }

  }

}





