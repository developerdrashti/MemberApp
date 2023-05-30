import 'dart:async';

import 'package:dropikme001/screens/Navigation_screen.dart';
import 'package:dropikme001/screens/listscreen.dart';
import 'package:dropikme001/services/firebaseservices.dart';

import 'package:dropikme001/utils/AppColors.dart';
import 'package:dropikme001/utils/AppImages.dart';
import 'package:dropikme001/utils/AppString.dart';
import 'package:dropikme001/utils/Apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:telephony/telephony.dart';


class PasswordConfirm extends StatefulWidget {
  String? phoneNumber;
  String? VerificationToken;
  PasswordConfirm({Key? key, this.phoneNumber, this.VerificationToken})
      : super(key: key);

  State<PasswordConfirm> createState() => OTPConfirm();
}

class OTPConfirm extends State<PasswordConfirm> {
  TextEditingController pinPutController = TextEditingController();
  Telephony telephony = Telephony.instance;
  Timer? _timer;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: Apptextstyle.lable,
    decoration: BoxDecoration(
        color: Appcolors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange)),
  );
  TextEditingController Veriyfyotp = TextEditingController();
  String? smscode;
  int secondss = 120;
  bool isshow = false;
  bool enableBtn = false;
  void callFUncation() {
    if (isshow == true) {
      firebaseservices().getResendOTPfn(widget.phoneNumber.toString(), context);
    } else {
      print("Value null wait ");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autofillsms();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (enableBtn == false) {
        setState(() {
          secondss--;
          if (secondss == 0) {
            setState(() {
              enableBtn = true;

              callFUncation();
            });
          }
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
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
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Text(Appstring.otp,
                                    textAlign: TextAlign.center,
                                    style: Apptextstyle.login
                                        .copyWith(fontSize: 32)),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          Appstring.enter,
                                          style: Apptextstyle.lable,
                                        ),
                                      ),
                                    ),
                                    Pinput(
                                      length: 6,
                                      defaultPinTheme: defaultPinTheme,
                                      controller: pinPutController,
                                      pinAnimationType: PinAnimationType.fade,
                                    ),
                                  ],
                                ),
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
                      firebaseservices()
                          .otpVerifyFn(widget.VerificationToken.toString(),
                          pinPutController.text.toString(), context)
                          .whenComplete(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationScreen()));
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
                        Text(
                          Appstring.verify,
                          style: Apptextstyle.lable.copyWith(
                              color: Appcolors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ),
            ),

          Align(
            alignment: Alignment.center,
            child:   Container(
              margin: EdgeInsets.only(top: 400),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont Receive the OTP?',
                      style: TextStyle(
                        color: Appcolors.black,
                      )),
                  enableBtn == false
                      ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                        Border.all(width: 2, color: Appcolors.black)),
                    child: Text(
                      '${secondss}',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                      : InkWell(
                    onTap: () {
                      setState(() {
                        _timer?.isActive;
                        secondss = 120;
                        enableBtn = false;
                        isshow = true;
                      });
                    },
                    child: Text(
                      'Resend The OTP',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          )
            // Visibility(
            //     visible: isLoading,
            //     child:  Container(
            //       color: Colors.black.withOpacity(0.5),
            //       height: MediaQuery.of(context).size.height,
            //       width: MediaQuery.of(context).size.width,
            //       child: Center(
            //         child: LoadingLayout(),
            //       ),
            //     ))
          ],
        ),
      ),
    );
  }

  void autofillsms() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.address);
        print(message.body);
        print(message.date);
        setState(() {});

        String sms = message.body.toString();
        print("SMS IS(-$sms-)");

        String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');
        print("otpcode IS(-$otpcode-)");

        String result = otpcode.substring(0, otpcode.length - 2);
        int modifiedNumber = int.parse(result);

        pinPutController.text = modifiedNumber.toString();

        setState(() {});
      },
      listenInBackground: false,
    );
  }
}
