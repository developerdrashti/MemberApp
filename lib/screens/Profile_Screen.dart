import 'package:dotted_line/dotted_line.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/NotificationCount.dart';
import 'package:dropikme001/model/Profile.dart';
import 'package:dropikme001/model/driverleave.dart';
import 'package:dropikme001/screens/Login_screen.dart';
import 'package:dropikme001/screens/Notification_screen.dart';
import 'package:dropikme001/screens/Profile_detail_screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/utils/AppImages.dart';
import 'package:dropikme001/utils/Apptextstyle.dart';
import 'package:dropikme001/utils/LoadingLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/sessionmangement.dart';
import '../utils/AppColors.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>Profile_screen();

}
class Profile_screen extends State<ProfileScreen>{
  String count="";
  String Name="jinalpatel";
  String contactno="111111111";
  String email="jinal@gmail.com";
  String address="sdnfkjfnbkn";
  String department="it";
  String image="http://54.252.243.135:8080/member/image/";
  String pic="";
  String shifttype="morning";
  String Date="22-05-1994";
  String bloodgroup="";
  List<MemberShiftName> shift=[];
  bool isLoading=false;

  List<MemberProfileDetail> detail=[];
  List<DriverLeave> driver=[];
  @override
  void initState(){
    super.initState();
    isLoading=true;
    Apicall();
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.primary,
        title: Text("Profile",style: TextStyle(
            fontFamily: "OpenSans",
            color: Colors.white,
            fontSize: 20
        ),),
        leading: GestureDetector(
          onTap: (){
           Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        actions: [
          // GestureDetector(
          //     onTap: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
          //       // showAlertDialog(context);
          //     },
          //     child: Padding(
          //       padding: EdgeInsets.all(20),
          //       child:  Stack(
          //         children: [
          //           Icon(Icons.notifications_none),
          //           Padding(padding: EdgeInsets.only(left: 15),
          //               child:   Container(
          //                   height: 15,
          //                   width: 15,
          //                   decoration: BoxDecoration(
          //                       color: Colors.green,
          //                       borderRadius: BorderRadius.all(Radius.circular(20))
          //                   ),
          //                   child: Center(
          //                     child: Text(count),
          //                   )
          //               ))
          //         ],
          //       ),
          //     ))
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  children: [
                    Stack(
                      children: [

                        Container(
                          margin: const EdgeInsets.only(left: 0,top: 20),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Appcolors.primary,
                                width: 3.0,
                                style: BorderStyle.solid),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 16.0,
                            child: ClipRRect(
                              child: Image.network(
                                '',
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfiledetailScreen(Name,email,address,bloodgroup,'$image$pic')));
                            print("Add details");
                          },
                          child:    Container(
                              margin: const EdgeInsets.only(left: 75, top: 80),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Icon(Icons.edit)
                          ),
                        ),],
                    ),
                    SizedBox(width: 20,),
                    Expanded(child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.network("https://tse4.mm.bing.net/th?id=OIP.KRpCbC-rzbn4n8ytseDqGwHaIq&pid=Api&P=0"),
                        Text(Name,style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600,fontSize: 30),),
                        Text(contactno,style: Apptextstyle.lable.copyWith(fontSize: 18),),

                      ],
                    ))
                  ],
                ),


                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.date_range),
                          SizedBox(width: 10,),
                          Text(
                              Date,style:Apptextstyle.lable),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Apptextstyle.dividerprofile,
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.mail_outline),
                          SizedBox(width: 10,),
                          Expanded(child:  Text(
                              email,style:Apptextstyle.lable),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Apptextstyle.dividerprofile,
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.add_location),
                          SizedBox(width: 10,),
                          Text(
                              address,style:Apptextstyle.lable),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Apptextstyle.dividerprofile,
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.business),
                          SizedBox(width: 10,),
                          Text(
                              department,style:Apptextstyle.lable),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Apptextstyle.dividerprofile,
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.water_drop),
                          SizedBox(width: 10,),
                          Text(bloodgroup,style:Apptextstyle.lable),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Apptextstyle.dividerprofile,
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.lock_clock),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Text("Morning",style:Apptextstyle.lable),
                              Text("Evening",style:Apptextstyle.lable),
                              //Text(shift[0].name.isEmpty?"":shift[0].name,style:Apptextstyle.lable),
                              // Text(shift[1].name.isEmpty?"":shift[1].name,style:Apptextstyle.lable),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Apptextstyle.dividerprofile,


                    ],
                  ),
                )
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
        ],
      )
    );
  }

  void Apicall() async{
    HttpService httpService=HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login profile= await sessionManagement.getmodel("Member");
    String token=profile.result.member.response.token;
    String memberid=profile.result.member.response.memberId;
    print(memberid);
    dynamic response=await httpService.getprofiledata(token, memberid);
    Profile profiledetail=response;
    detail =profiledetail.result.memberProfileDetails;
    if(profiledetail.message=="Ok"){
      setState(() {
        shift=detail[0].memberShiftName;
        Name=detail[0].name;
        contactno=detail[0].contactNo;
        email=detail[0].email;
        department=detail[0].memberDepartmentName;
        address=detail[0].address;
        bloodgroup=detail[0].bloodGroup;
        pic=detail[0].photo;
        isLoading=false;
      });
    }else{
      print("Data not found");
      setState(() {
        isLoading=false;
      });
    }

  }

  void Apicalldriver()async {
    print("get driver data");
    HttpService httpService=HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login profile= await sessionManagement.getmodel("Member");
    String token=profile.result.member.response.token;
    String memberid=profile.result.member.response.memberId;
    dynamic response=await httpService.getprofiledata(token,memberid);
    DriverLeaveList profiledetail=response;
    if(profiledetail.message=="Ok"){

      setState(() {
        driver =profiledetail.driverLeave;
      });
      print(driver.length);
      print(driver[0].reason);
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      print("Data not found");
    }
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
  //
  // }
}


