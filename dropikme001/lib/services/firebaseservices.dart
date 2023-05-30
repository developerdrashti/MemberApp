
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/Navigation_screen.dart';
import '../screens/Password_confirm_screen.dart';


class firebaseservices {
  Future<void> getNumberandVerify(
      String phoneCon,
      BuildContext context,
      ) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: Duration(seconds: 60),
      phoneNumber: "+91${phoneCon}",
      verificationCompleted: (phoneAuthCredential) {
        print("Verification  Complted${phoneAuthCredential}");
      },
      verificationFailed: (error) {
        print("Print Verification Failed notes:->$error");
      },
      codeSent: (verificationId, forceResendingToken) {
        print("codeSentID----${verificationId}");
        print("codeSentTOKEN-----${forceResendingToken}");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasswordConfirm(
                VerificationToken: verificationId,
                phoneNumber: phoneCon,
              ),
            ));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print("VerificationIIDD >>>${verificationId}");
      },
    );
  }

  Future<void> otpVerifyFn(
      String token,
      String Otp,
      BuildContext context,
      ) async {
    try {
      PhoneAuthCredential phoneAuthCredential =
      PhoneAuthProvider.credential(verificationId: token, smsCode: Otp);

      await FirebaseAuth.instance
          .signInWithCredential(phoneAuthCredential)
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => NavigationScreen()),
                (route) => false);
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Worng OTP please try now', toastLength: Toast.LENGTH_SHORT);

      print(">>>Try OTPs<<<");
    }
  }

  Future<void> getResendOTPfn(
      String phoneCon,
      BuildContext context,
      ) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: Duration(seconds: 60),
      phoneNumber: "+91${phoneCon}",
      verificationCompleted: (phoneAuthCredential) {
        print("Verification  Complted${phoneAuthCredential}");
      },
      verificationFailed: (error) {
        print("Print Verification Failed notes:->$error");
      },
      codeSent: (verificationId, forceResendingToken) {
        print("codeSentID----${verificationId}");
        print("codeSentTOKEN-----${forceResendingToken}");
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print("VerificationIIDD >>>${verificationId}");
      },
    );
  }
}
