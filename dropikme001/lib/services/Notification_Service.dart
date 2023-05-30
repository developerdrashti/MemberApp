import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';




Future<void> backgroundHandler(RemoteMessage message) async{
  print("Notification Recieved ${message.notification!.title}");
}
class NotificationService {
  static Future<void> intialize() async{
    NotificationSettings settings= await FirebaseMessaging.instance.requestPermission();
    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print("Notification Initialized");
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    }
  }
  static Future<void> getToken() async{
    String? token=await FirebaseMessaging.instance.getToken();
    if(token!= null){
      //SessionManagement sessionManagement=SessionManagement();
      // sessionManagement.setFCMToken("TOKEN", token);
      print("Token is stored and value is:$token");
      print(token);
      addStringToSF(token);
    }
  }

  static void shownotification(RemoteMessage event){
    AndroidNotificationDetails androidNotificationDetails= const AndroidNotificationDetails("DropikMe", "APPNOTIFICATION",
        priority: Priority.max,
        importance:  Importance.max);
    DarwinNotificationDetails iOSNotificationDetails= DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true
    );


    NotificationDetails notificationDetails=NotificationDetails(
        android: androidNotificationDetails,
        iOS: iOSNotificationDetails
    );
    notificationsPlugin.show(0, event.notification!.title, event.notification!.body, notificationDetails);
  }

  static void addStringToSF(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Token', token);
  }


}