import 'package:dropikme001/model/Addsos.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/screens/Login_screen.dart';
import 'package:dropikme001/screens/Navigation_screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/AppColors.dart';
import 'package:dropikme001/utils/AppImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sosscreen extends StatefulWidget{
  State<Sosscreen> createState()=>SOSpage();
  
  }

class SOSpage extends State<Sosscreen>{
  bool payment=false;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       elevation: 0,
       backgroundColor: Appcolors.primary,
       title: Text("SOS",style: TextStyle(
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
         GestureDetector(
             onTap: (){
               // showAlertDialog(context);
             },
             child: Padding(
               padding: EdgeInsets.all(20),
               child: Icon(Icons.notifications_none),
             )
         )
       ],
     ),
     body: Stack(
       children: [
         Center(
           child: GestureDetector(
             onTap: (){
               showAlertDialog(context);

             },
             child: Image.asset(AppImages.sosmain),
           )
         )
       ],
     ),
   );
  }

  void apicall()async {
    print("add member sos");
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login sosrequest=await sessionManagement.getmodel("Member");
    String token= sosrequest.result.member.response.token;
    String memberid=sosrequest.result.member.response.memberId;
    AddSos login= await api.AddSosdata(token,memberid);
    if(login.message=="Ok"){
      print("update data successfully");
      sosrequest.result.member.paymentCheck==true?Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex: 4,)), (route) => false):Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex: 3,)), (route) => false);
      ;
      Fluttertoast.showToast(msg: "Add SOS successfully",toastLength: Toast.LENGTH_LONG);
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      Fluttertoast.showToast(msg: "Leave not Add",toastLength: Toast.LENGTH_LONG);
    }

  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        apicall();
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("SOS Conformation"),
      content: Text("Are You sure for sos"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
  