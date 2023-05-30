import 'dart:async';

import 'package:dropikme001/model/Failed.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/mapingmember.dart';
import 'package:dropikme001/screens/Navigation_screen.dart';
import 'package:dropikme001/screens/Password_confirm_screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/firebaseservices.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/AppColors.dart';
import 'package:dropikme001/utils/AppString.dart';
import 'package:dropikme001/utils/Apptextstyle.dart';
import 'package:dropikme001/utils/LoadingLayout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/AppImages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, title}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  TextEditingController mobilenumber = TextEditingController();
  bool contacterror =false;
  String devicetoken="";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getdevicetoken();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior:
                  const MaterialScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(alignment: Alignment.topCenter, children: [
                  Image.asset(AppImages.background),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 170),
                          padding: EdgeInsets.only(
                              top: 100,
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom > 0
                                      ? 180
                                      : 120),
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Center(
                                    child: Text(Appstring.login,
                                        style: Apptextstyle.login
                                            .copyWith(fontSize: 40)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(Appstring.mobilenumber,
                                      style: Apptextstyle.lable),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: TextField(

                                    controller: mobilenumber,
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


                                      hintText: "Enter Your Mobile Number",


                                      errorText: contacterror?"":null,
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w500,
                                      ),

                                      contentPadding:
                                      const EdgeInsets.all(20),
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                               // Text(devicetoken)
                              ],
                            ),
                          )),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    margin: const EdgeInsets.only(top: 90),
                    child: Image.asset(AppImages.bus),
                  )
                ]),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: () {
                      if(mobilenumber.text.trim().isNotEmpty){
                        setState(() {
                          isLoading=true;
                        });
                        CheckLogin(mobilenumber.text,devicetoken,"djvhfugfudgfuifuidjnjnjnjnjnjnjn",true);

                      }else{
                        print("ENter valid mobile number");
                        setState(() {
                          mobilenumber.text.trim().isEmpty?contacterror=true:contacterror=false;
                        });
                      }



                     // Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordConfirm()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.primary,
                        elevation: 25,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Appstring.Blogin,
                            style: Apptextstyle.lable.copyWith(
                                color: Appcolors.white,
                                fontWeight: FontWeight.w600)),
                      ],
                    )),
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
                ))
          ],
        ),
      ),
    );
  }



  void CheckLogin(String username,String deviceid,String Devicedetail,bool isfrommobile) async{
    HttpService api=  HttpService();
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    dynamic login= await api.checkLogin(username,deviceid,Devicedetail,isfrommobile);
    print(login["isSuccess"]);
    if(login["isSuccess"]==true){
      SessionManagement sessionManagement=SessionManagement();
     await sharedPreferences.setBool("Login", true);
     bool setlogin=await sharedPreferences.setBool("Login", true);
     Login logindata=Login.fromJson(login);
      sessionManagement.CreateSession(logindata);
      firebaseservices().getNumberandVerify(username, context);
      Fluttertoast.showToast(msg: logindata.message,toastLength: Toast.LENGTH_LONG);
      setState(() {
        isLoading=false;
      });
      if(setlogin==true){
        Timer( Duration(seconds: 2),
                ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PasswordConfirm()))
        );
      }else{
        Timer( Duration(seconds: 2),
                ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavigationScreen()))
        );
      }

    }else{
      Failed fail=Failed.fromJson(login);
      Fluttertoast.showToast(msg: fail.message,toastLength: Toast.LENGTH_SHORT);
      print(fail.message);
      setState(() {
        isLoading=false;
      });
       }
  }

  void getdevicetoken()async {
    print("get success device token for use in mobile app");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token=await prefs.getString('Token');
    print("device id value is $devicetoken");
    setState(() {
      devicetoken=token!;
    });
  }



}
