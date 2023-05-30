import 'dart:async';
import 'package:dropikme001/screens/Login_screen.dart';
import 'package:dropikme001/screens/Navigation_screen.dart';
import 'package:dropikme001/services/Notification_Service.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/AppImages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
FlutterLocalNotificationsPlugin notificationsPlugin= FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:Colors.green
  )
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await NotificationService.intialize();
  // SessionManagement();
  AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings iOSsettings =  const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestCriticalPermission: true,
    requestSoundPermission: true,
  );
  InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSsettings
  );
  bool? intialize = await notificationsPlugin.initialize(initializationSettings);
  print("notification:$intialize");
  NotificationService.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    NotificationService.shownotification(event);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(1);
  });
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
  );
  runApp(MyApp());

}
void getInitialMessage() async{
  RemoteMessage? message= await FirebaseMessaging.instance.getInitialMessage();
  if(message!= null){
    print(message.notification!.title);
  }

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    SessionManagement();
    Timer(
        Duration(seconds: 5),
            () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SessionManagement.checkLogin()==true ? NavigationScreen() : LoginScreen())));

    // Timer(
    //     const Duration(seconds: 5),
    //         () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  LoginScreen())));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(AppImages.logo),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Image.asset(AppImages.splashbottom),

            ],
          ),
        ],
      ) 
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
