import 'dart:convert';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/mapingmember.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManagement {

  SessionManagement(){
    initialization();
  }
  static String isLogin= "Login";
  static late SharedPreferences pref;


  static Future initialization() async {
    pref = await SharedPreferences.getInstance();

  }

  static bool? checkLogin() {
    if(pref.getBool(isLogin)==null){
      return false;
    }
    return pref.getBool(isLogin);
  }
  void CreateSession(Login login,) async{
    SaveModel('Member',login);


  }
  void SaveModel(String key, Login login) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(key,json.encode(login));

  }
  Future<Login> getmodel(String? string) async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return Login.fromJson(json.decode(preferences.getString('Member').toString()));
  }
  Future<Future<bool>> setlogin(String login) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.setString("Login", login);
  }
  void DestroyLogindata() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('Member');
  }
  void CreateSessionMap( Mappingmember mapping,) async{
    SaveModelMap('MAP',mapping);


  }

  void SaveModelMap(String key, Mappingmember mapping)async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(key,json.encode(mapping));
  }
  Future<Mappingmember> getmodelMap(String? string) async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return Mappingmember.fromJson(json.decode(preferences.getString('MAP').toString()));
  }
  void DestroyMap() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('Member');
  }



























}