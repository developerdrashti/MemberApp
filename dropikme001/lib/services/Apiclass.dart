import 'dart:convert';
import 'dart:core';
import 'package:dropikme001/model/AddDayOff.dart';
import 'package:dropikme001/model/AddDriverComplain.dart';
import 'package:dropikme001/model/AddMemberLeave.dart';
import 'package:dropikme001/model/Addsos.dart';
import 'package:dropikme001/model/CancelComplain.dart';
import 'package:dropikme001/model/CancelMemberLeave.dart';
import 'package:dropikme001/model/ClearAllComplain.dart';
import 'package:dropikme001/model/ClearAllLeave.dart';
import 'package:dropikme001/model/Failed.dart';
import 'package:dropikme001/model/GetLeaveType.dart';
import 'package:dropikme001/model/GetShiftType.dart';
import 'package:dropikme001/model/Leave_type.dart';
import 'package:dropikme001/model/MemberDetails.dart';
import 'package:dropikme001/model/MemberWaitRequest.dart';
import 'package:dropikme001/model/Member_Complain.dart';
import 'package:dropikme001/model/MessageList.dart';
import 'package:dropikme001/model/NotificationCount.dart';
import 'package:dropikme001/model/NotificationUpdate.dart';
import 'package:dropikme001/model/Notificationlist.dart';
import 'package:dropikme001/model/Profile.dart';
import 'package:dropikme001/model/Soslist.dart';
import 'package:dropikme001/model/UpdateComplain.dart';
import 'package:dropikme001/model/UpdateLeaveMember.dart';
import 'package:dropikme001/model/Updateprofile.dart';
import 'package:dropikme001/model/clearallsos.dart';
import 'package:dropikme001/screens/Login_screen.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';







//http://3.26.113.171:8080/
//http://54.252.243.135:8080/
class HttpService {
 // http://3.26.113.171:8080/api/mobile/memberLogin
 // String BASEURL1= "http://54.252.243.135:8080/api";
  String BASEURL= "http://3.26.113.171:8080/api";
  String login = "/mobile/memberLogin";
  String Memberleave="/mobile/getMemberLeave/";
  String singleMemberLeave= "/mobile/getOneMemberDetailedLeave/";
  String Drivercomplain="/mobile/getDriverComplaints/";
  String Addmemberleave="/mobile/addMemberLeave";
  String Leavetype="/master/getLeaveType";
  String shifttype="/dropDown/getShiftType";
  String Adddrivercomplain="/mobile/addDriverComplaints";
  String memberdetilas="/mobile/getMemberUserDetail/";
  String sos="/mobile/addSosReq/";
  String AddDayOff="/mobile/addMemberOffDay";
  String updatemember="/Mobile/updateMemberProfile/";
  String profile="/mobile/getMemberProfileDetails/";
  String AddWaitRequest="/mobile/addMemberWaitRequest";
  String notification="/Mobile/getAllNotificationList";
  String count="/Mobile/getNotificationCount";
  String updatenotification="Mobile/updateOneNotification";
  String message="/Mobile/getAllDriverMessage/";
  String mapping="/Mobile/addMemberDefaultMapping";
  String updateleave="/mobile/updateMemberLeave/";
  String updatecompalin="/Mobile/updateDriverComplaints/";
  String clearallcomplain="Mobile/clearAllNotificationForDriverComplaints";
  String soslist="/mobile/GetAllSosRequestOneMember";
  String clearallleave="/Mobile/clearAllMemberLeave";
  String cancelmemberleave="/Mobile/cancelMemberLeave/";
  String clearallsos="/mobile/ClearAllSosRequestOneMember";
  String cancelcomplain="/Mobile/getOneDriverComplaintDelete/";



  Future<dynamic> checkLogin(String username,String deviceid,String devicedetail,bool isfrommobile) async {
   try{
      http.Response response = await http.post(
       Uri.parse('$BASEURL$login'),
       headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
       },
       body: jsonEncode(<String, dynamic>{
         'username': username,
         'deviceId' : deviceid,
         'deviceDetails': devicedetail,
         'isFromMobile':isfrommobile.toString(),
       }),
     );
     var data =jsonDecode(response.body);
     if (data['isSuccess']) {
       return data;
     } else {
       throw data;

     }
   }catch(_){
     return{
       "isSuccess":false,
       "message":"not found data"
     };
   }


  }

  Future<LeaveType> getLeavetype() async{
    http.Response res = await get(Uri.parse('$BASEURL$Leavetype'),
        headers: <String ,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if(res.statusCode==200){
      print(res.statusCode);
      return LeaveType.fromJson(json.decode(res.body));
    }else{
      throw 'datanot retrive';
    }


  }
  Future<ShiftType> getShiftType(String token) async{
    http.Response res = await get(Uri.parse('$BASEURL$shifttype'),
        headers: <String ,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",

        });
    if(res.statusCode==200){
      return ShiftType.fromJson(json.decode(res.body));
    }else{
      throw 'datanot retrive';
    }


  }
  Future<AddMemberLeave> AddMemberleave(
      String token,
      String mid,
      String shiftid,
      String leaveid,
      String vehicleid,
      String reson,
      String startdate,
      String enddate,
      String code,
      String details,
      String description,
      String note,
      String createby,
      String updateby,
       ) async {
    try{
      print("ADD MEMBER LEAVE");
      print('$BASEURL$Addmemberleave');
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$Addmemberleave'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "memberId": mid,
          "shiftTypeId": shiftid,
          "leaveTypeId":leaveid,
          "vehicleId": vehicleid,
          "reason": reson,
          "startDate": startdate,
          "endDate": enddate,
          "code": code,
          "details": details,
          "description": description,
          "note": note,
          "createdBy": createby,
          "updatedBy": updateby,

        }),
      );

      if (response.statusCode == 200) {
        return AddMemberLeave.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }

    }catch(_){
      throw 'message';
    }
  }
  Future<dynamic> AddMemberleavedata( String token,
      String mid,
      String shiftid,
      String leaveid,
      String vehicleid,
      String reson,
      String startdate,
      String enddate,
      String code,
      String details,
      String description,
      String note,
      String createby,
      String updateby,) async {
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$Addmemberleave'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "memberId": mid,
          "shiftTypeId": shiftid,
          "leaveTypeId":leaveid,
          "vehicleId": vehicleid,
          "reason": reson,
          "startDate": startdate,
          "endDate": enddate,
          "code": code,
          "details": details,
          "description": description,
          "note": note,
          "createdBy": createby,
          "updatedBy": updateby,
        }),
      );
      var data =jsonDecode(response.body);
      if (data['isSuccess']) {
        return data;
      } else {
        throw data;

      }
    }catch(_){
      return{
        "isSuccess":false,
        "message":"not found data"
      };
    }


  }
  Future<AddComplain> AddDriverComplain(String token,String did,String mid,String vehicleid,String message,String createdid,String updateby,bool isactive,bool isdeleted) async {

      final http.Response response = await http.post(
        Uri.parse('http://3.26.113.171:8080/api/Mobile/addDriverComplaints'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "driverId": did,
          "memberId": mid,
          "vehicleId": vehicleid,
          "complaintMessage": message,
          "createdBy": createdid,
          "updatedBy": updateby,
          "isActive": isactive.toString(),
          "isDeleted": isdeleted.toString()
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return AddComplain.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }








  }
  Future<AddSos> AddSosdata(String token,String memberid) async {
    print("$BASEURL$sos$memberid");
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$sos$memberid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{

        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return AddSos.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }
    }catch(_){
      throw "message";



    }

  }
  Future<AddDayoff> AddDayoffLeave(String token,String mid,String vehicleid,String createdby,String updatedby) async {
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$AddDayOff'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "memberId": mid,
          "vehicleId": vehicleid,
          "createdBy": createdby,
          "updatedBy": updatedby
        }),
      );
      if (response.statusCode == 200) {
        return AddDayoff.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }
    }catch(_){
      throw 'message';
    }

  }
  Future<UpdateProfile> updateprofile(String token,String memberid,String photo,String iamgename,String bloodgroup,String name,String Email) async {
    print("$BASEURL$updatemember$memberid");
    try{
      final http.Response response = await http.put(
        Uri.parse("$BASEURL$updatemember$memberid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "photo": photo,
          "imageName": iamgename,
          "bloodGroup": bloodgroup,
          "name": name,
          "email": Email
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return UpdateProfile.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }

    }catch(_){
      throw 'message';
    }

  }
  Future<Profile> getprofiledata(String token,String Memberid) async{
    print('$BASEURL$profile$Memberid');

    http.Response res = await get(Uri.parse('$BASEURL$profile$Memberid'),
        headers: <String ,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        });
    if(res.statusCode==200){
      print("data get ${res.statusCode}");
      print(res.statusCode);
      return Profile.fromJson(json.decode(res.body));
    }else{
      throw "Exception occured";
    }


  }
  Future<MemberWaitRequest> AddMemberWaitRequest(String token,String memberid,String shiftid,String vid) async {
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$AddWaitRequest'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "memberId": memberid,
          "shiftTypeId": shiftid,
          "vehicleId": vid

        }),
      );
      if (response.statusCode == 200) {
        return MemberWaitRequest.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }

    }catch(_){
      throw LoginScreen();



    }

  }
  Future<NotificationList> getNotification(String token,String userid,String usertype,String action) async {
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$notification'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "userId": userid,
          "userType": usertype,
          "action":action

        }),
      );

      if (response.statusCode == 200) {
        return NotificationList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }

    }catch(_){
      throw 'message';



    }

  }
  Future<NotificationCount> getNotificationcount(String token,String userid,String usertype,) async {
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$count'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "userId": userid,
          "userType": usertype

        }),
      );

      if (response.statusCode == 200) {
        return NotificationCount.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }

    }catch(_){
      throw 'message';



    }

  }
  Future<NotificationUpdate> getNotificationupdate(String token,String userid,String action,) async {
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$updatenotification'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "_id": userid,
          "action": action

        }),
      );

      if (response.statusCode == 200) {
        return NotificationUpdate.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }

    }catch(_){
      throw 'message';



    }

  }
  Future<dynamic> Appmapping(String token,String contct,String memberid,) async {
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$mapping'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "contactNo": contct,
          "memberId": memberid
        }),
      );
      var data =jsonDecode(response.body);
      if (data['isSuccess']) {
        return data;
      } else {
        throw data;

      }
    }catch(_){
      return{
        "isSuccess":false,
        "message":"not found data"
      };
    }
  }
 Future<dynamic> getMemberleavelist(String token,String Memberid) async {
    print("Call Leave list api ");
    String url="$BASEURL$Memberleave$Memberid";
    print(url);
    print("object");
    try{

      Response res = await get(Uri.parse("$BASEURL$Memberleave$Memberid"),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            'Authorization': "$token",
          });
      print("$BASEURL$Memberleave$Memberid");
      print(res.statusCode);
      if (res.statusCode == 200) {

        var data =json.decode(res.body);
        print(data);
        if(data['isSuccess']){
          return data;
        }
        else{
          return Failed.fromJson(data);
        }
      }
      else{
        return{
          "isSuccess":false,
          "message":"Some thing went wrong"
        };
      }
    } catch(_){
      return{
        "isSuccess":false,
        "message":"Exceptions occurred"
      };

    }
  }
  Future<dynamic> getMembersingleleavelist(String token,String Leaveid) async {
    print("Call Leave list api ");
    try{
      Response res = await get(Uri.parse("$BASEURL$singleMemberLeave$Leaveid"),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            'Authorization': "$token",
          });
      print("$BASEURL$Memberleave$Leaveid");
      print(res.statusCode);
      if (res.statusCode == 200) {

        var data =json.decode(res.body);
        print(data);
        if(data['isSuccess']){
          return data;
        }
        else{
          return Failed.fromJson(data);
        }
      }
      else{
        return{
          "isSuccess":false,
          "message":"Some thing went wrong"
        };
      }
    } catch(_){
      return{
        "isSuccess":false,
        "message":"Exceptions occurred"
      };

    }
  }
  Future<Updatecomplainldata> updatecomplain(String token,String id,String complinmessage) async {

    try{
      final http.Response response = await http.put(
        Uri.parse("$BASEURL$updatecompalin$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "complaintMessage": complinmessage
        }),
      );
      if (response.statusCode == 200) {
        return Updatecomplainldata.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }
    }catch(_){
      throw 'message';
    }

  }
  Future<Clearallcomplain> Clearallcomplaindata(String token, String mid,) async {
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$clearallcomplain'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "memberId": mid,
        }),
      );
      if (response.statusCode == 200) {
        return Clearallcomplain.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }
    }catch(_){
      throw 'message';
    }

  }
  Future<UpdateMemberleave> updateMemberleave(String token,String id,String startdate,String enddate,String reson,String shiftid,String leaveid) async {

    try{
      final http.Response response = await http.put(
        Uri.parse("$BASEURL$updateleave$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "startDate":startdate,
          "endDate":enddate,
          "reason":reson,
          "shiftTypeId": shiftid,
          "leaveTypeId":leaveid,

        }),
      );
      if (response.statusCode == 200) {
        return UpdateMemberleave.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }
    }catch(_){
      throw 'message';
    }

  }
  Future<dynamic> getMembercomplainlist(String token,String Memberid) async {
    print("Call Leave list api ");
    try{
      Response res = await get(Uri.parse("$BASEURL$Drivercomplain$Memberid"),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            'Authorization': "$token",
          });
      if (res.statusCode == 200) {

        var data =json.decode(res.body);
        print(data);
        if(data['isSuccess']){
          return data;
        }
        else{
          return Failed.fromJson(data);
        }
      }
      else{
        return{
          "isSuccess":false,
          "message":"Some thing went wrong"
        };
      }
    } catch(_){
      return{
        "isSuccess":false,
        "message":"Exceptions occurred"
      };

    }
  }
  Future<SosList> getsoslist(String token,String memberid) async {
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$soslist'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "memberId":memberid

        }),
      );

      if (response.statusCode == 200) {
        return SosList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }

    }catch(_){
      throw 'message';



    }

  }
  Future<ClearAllmemberleave> Clearallleavedata(String token, String mid,) async {
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$clearallleave'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "memberId": mid,
        }),
      );
      if (response.statusCode == 200) {
        return ClearAllmemberleave.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }
    }catch(_){
      throw 'message';
    }

  }
  Future<Cencelleave> cancelmemberleavedata(String token,String leaveid) async {
    print("$BASEURL$cancelmemberleave$leaveid");
    try{
      final http.Response response = await http.put(
        Uri.parse("$BASEURL$cancelmemberleave$leaveid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{


        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Cencelleave.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }

    }catch(_){
      throw 'message';
    }

  }
  Future<ClearAllsosRequest> Clearallsosdata(String token, String mid,) async {
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$clearallsos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "memberId": mid,
        }),
      );
      if (response.statusCode == 200) {
        return ClearAllsosRequest.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }
    }catch(_){
      throw 'message';
    }

  }
  Future<dynamic> getsoslistdata(String token,String memberid) async {
    print("$BASEURL$soslist");
    try{
      final http.Response response = await http.post(
        Uri.parse('$BASEURL$soslist'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{
          "memberId":memberid
        }),
      );
      var data =jsonDecode(response.body);
      print("SOSDATA");
      print(data['isSuccess']);
      print(data);
      if (data['isSuccess']) {
        return data;
      } else {
        throw data;

      }
    }catch(_){
      return{
        "isSuccess":false,
        "message":"Not_Found"
      };
    }


  }
  Future<Cencelcomplain> cancelmembercomplaindata(String token,String leaveid) async {
    print("$BASEURL$cancelcomplain$leaveid");
    try{
      final http.Response response = await http.put(
        Uri.parse("$BASEURL$cancelcomplain$leaveid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$token",
        },
        body: jsonEncode(<String, String>{


        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Cencelcomplain.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create album.');
      }

    }catch(_){
      throw 'message';
    }

  }
}