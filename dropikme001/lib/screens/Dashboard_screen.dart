import 'dart:async';
import 'package:dropikme001/model/AddDayOff.dart';
import 'package:dropikme001/model/Conts.dart';
import 'package:dropikme001/model/Failed.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/MemberWaitRequest.dart';
import 'package:dropikme001/model/NotificationCount.dart';
import 'package:dropikme001/model/mapingmember.dart';
import 'package:dropikme001/screens/Notification_screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/AppColors.dart';
import 'package:dropikme001/utils/AppString.dart';
import 'package:dropikme001/utils/Apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class DashboardScreen extends StatefulWidget {
  State<DashboardScreen> createState() => Dashboard();
}

class Dashboard extends State<DashboardScreen> {
  String shiftid="";
  String vehicalid="";
  String memberid="";
  bool onclick=false;
  List<Datum> list_notification=[];
  DateTime currentTime = new DateTime.now();
  late final Timer _timer;
  int _start = Appstring.time;
  String count="";
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(23.129318, 72.544884);
  static const LatLng destination = LatLng(23.129318, 72.544884);
  double? latvalue;
  double? lngtvalue;
  List<LatLng> polyCoordinates = [];
  LocationData? currentLocation;
  Set<Circle> circles = Set.from([
    Circle(
      circleId: CircleId('1'),
      center: sourceLocation,
    )
  ]);
  final nearbyCarsLocation = [
    LatLng(23.0274641, 72.5245811),
    LatLng(23.0274641, 72.5245811), //24.9294892,67.0391903,18.73z
  ];
  List<Marker> getMarker = [
    // Marker(markerId: MarkerId("source"), position: sourceLocation),
    // Marker(markerId: MarkerId("destination"), position: destination)
  ];
  Future<void> _getNearByCars() async {
    var now = new DateTime.now().millisecondsSinceEpoch;

    getMarker.add(Marker(
      markerId: MarkerId('1'),
      position: destination,
      icon: BitmapDescriptor.defaultMarker,

      // infoWindow: InfoWindow(title: address, snippet: "go here"),
    ));
  }
  void getCurrentlocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
      setState(() {
        latvalue = currentLocation?.latitude;
        lngtvalue = currentLocation?.longitude;
      });
      print("lat value${latvalue}");
      print("lat value${lngtvalue}");
    });
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
     // setState(() {});
    });
  }
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(23.0274641, 72.5245811),
        PointLatLng(destination.latitude, destination.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polyCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
  }

  @override
  void initState() {
   // getnotificationcount();
    Apicallmapping();
    print("fixdate == '12-50' ? WaitRequest() :null;");

    // Timer.periodic(Duration(seconds: 10), (timer) {
    //   String? fixdate = DateFormat('HH:mm').format(DateTime.now());
    //   fixdate=='16:08'?WaitRequest():print("API NOT CALL AT THE DESIDED TIME");
    // });

    //fixdate = Timer.periodic(const Duration(seconds: 10), (_) => postLntLng());

   // fixdate == '2-25' ? WaitRequest :null;
    _getNearByCars();
    getCurrentlocation();
    print("My location is ${currentLocation.runtimeType}");
    print("YOUR LIVE LOCATION :$latvalue & $lngtvalue");
    getPolyPoints();
    setdata();
    super.initState();
  }

  Widget build(BuildContext context) {

    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Appcolors.primary,
        //   title: Text(
        //     "Dashboard",
        //     style: TextStyle(
        //         fontFamily: "OpenSans", color: Colors.white, fontSize: 20),
        //   ),
        //   leading: GestureDetector(
        //     onTap: () {
        //       Scaffold.of(context).openDrawer();
        //     },
        //     child: Icon(Icons.menu),
        //   ),
        //   actions: [
        //
        //     GestureDetector(
        //         onTap: () {
        //           showAlertDialog(context);
        //         },
        //         child: Padding(
        //           padding: EdgeInsets.only(top: 10),
        //           child: Icon(Icons.power_settings_new),
        //         )),
        //     GestureDetector(
        //         onTap: () {
        //           Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
        //          // showAlertDialog(context);
        //         },
        //         child: Padding(
        //           padding: EdgeInsets.all(20),
        //           child:  Stack(
        //             children: [
        //               Icon(Icons.notifications_none),
        //               Padding(padding: EdgeInsets.only(left: 15),
        //                   child:   Container(
        //                       height: 15,
        //                       width: 15,
        //                       decoration: BoxDecoration(
        //                           color: Colors.green,
        //                           borderRadius: BorderRadius.all(Radius.circular(20))
        //                       ),
        //                       child: Center(
        //                         child: Text(count),
        //                       )
        //                   ))
        //             ],
        //           ),
        //         ))
        //   ],
        // ),
        body: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                          child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Container(
                                      height: 80,
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          Appstring
                                                              .lastlocation,
                                                          style: Apptextstyle
                                                              .dashtitle),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Apptextstyle.dividersmall,
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text("Gota",
                                                          style: Apptextstyle
                                                              .dashvalue)
                                                    ],
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Container(
                                      height: 80,
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          Appstring.arrivaltime,
                                                          style: Apptextstyle
                                                              .dashtitle),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Apptextstyle.dividersmall,
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text("10:30",
                                                          style: Apptextstyle
                                                              .dashvalue)
                                                    ],
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          child: currentLocation==null?Text(""):GoogleMap(
                            buildingsEnabled: true,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            circles: circles,
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    currentLocation == null ? 2 : currentLocation!.latitude!,
                                    currentLocation == null
                                        ? 2
                                        : currentLocation!.longitude!),
                                zoom: 14.5),
                            polylines: {
                              Polyline(
                                  polylineId: PolylineId("route"),
                                  points: polyCoordinates,
                                  color: primarycolor,
                                  width: 6),
                            },
                            markers: getMarker.toSet(),
                            onMapCreated: (mapcontroller) {
                              _controller.complete(mapcontroller);
                            },
                          ),
                        ),
                       Container(
                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                         child:  Column(
                           children: [
                             Row(
                               children: [
                                 Card(
                                   elevation: 5,
                                   color: Colors.white,
                                   shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.all(
                                           Radius.circular(20))),
                                   child: Container(
                                     width: 170,
                                     padding: EdgeInsets.all(10),
                                     margin: EdgeInsets.all(10),
                                     child: Row(
                                       children: [
                                         Expanded(
                                             child: Column(
                                               children: [
                                                 Row(
                                                   children: [
                                                     Expanded(
                                                       child: Text(Appstring.speed,
                                                           style: Apptextstyle
                                                               .dashtitle),
                                                     ),
                                                     Align(
                                                       alignment:
                                                       Alignment.centerRight,
                                                       child: Text(Appstring.tem,
                                                           style: Apptextstyle
                                                               .dashtitle),
                                                     )
                                                   ],
                                                 ),
                                                 SizedBox(
                                                   height: 10,
                                                 ),
                                                 Apptextstyle.divider,
                                                 SizedBox(
                                                   height: 10,
                                                 ),
                                                 Row(
                                                   crossAxisAlignment:
                                                   CrossAxisAlignment.end,
                                                   children: [
                                                     Expanded(
                                                       child: Text("20/km",
                                                           style: Apptextstyle
                                                               .dashvalue),
                                                     ),
                                                     Expanded(
                                                         child: Align(
                                                           alignment:
                                                           Alignment.centerRight,
                                                           child: Text("20",
                                                               style: Apptextstyle
                                                                   .dashvalue),
                                                         )),
                                                   ],
                                                 ),
                                               ],
                                             )),
                                       ],
                                     ),
                                   ),
                                 ),
                                Expanded(child:  Card(

                                 // margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child:  Column(
                                      children: [
                                        Text("Wait",
                                            style: Apptextstyle.dashtitle.copyWith(
                                                fontWeight: FontWeight.w600)),
                                        GestureDetector(
                                          onTap: () {
                                            AlertDiolog(context);

                                          },
                                          child: Icon(
                                            Icons.access_time,
                                            size: 30,
                                          ),
                                        ),
                                        onclick==true?Text("$_start",style: Apptextstyle.dashtitle.copyWith(color: Appcolors.red),):Text(""),
                                        onclick==true?Text("Second",style: Apptextstyle.dashtitle.copyWith(fontSize: 14),):Text(""),
                                        // Visibility(
                                        //   visible: onclick,
                                        //   child:  Text("$_start",
                                        //     style: Apptextstyle.dashtitle
                                        //         .copyWith(color: Appcolors.red)),),
                                        //  Visibility(
                                        //    visible: onclick,
                                        //    child: Text("Second",
                                        //      style: Apptextstyle.dashtitle
                                        //          .copyWith(fontSize: 14)),)

                                      ],
                                    ),
                                  ),
                                ),)

                               ],
                             )
                           ],
                         ),
                       ),
                        Container(

                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Container(

                                      height: 100,
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(Appstring.vehicalno,
                                                          style: Apptextstyle
                                                              .dashtitle),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Apptextstyle.dividersmall,
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text("GJ01w1111",
                                                          style: Apptextstyle
                                                              .dashvalue)
                                                    ],
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Container(
                                      height: 100,
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(Appstring.routename,
                                                          style: Apptextstyle
                                                              .dashtitle),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Apptextstyle.dividersmall,
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text("adalaj to gota",
                                                          style: Apptextstyle
                                                              .dashvalue)
                                                    ],
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 0, bottom: 0),
                          child: Text(
                            Appstring.droptitle,
                            style: Apptextstyle.login
                                .copyWith(color: Appcolors.primary),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.all(20),
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(Appstring.dlocation,
                                              style: Apptextstyle.dashtitle),
                                        ),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(Appstring.dtime,
                                              style: Apptextstyle.dashtitle),
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Apptextstyle.divider,
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Text("Gota",
                                              style: Apptextstyle.dashvalue),
                                        ),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text("7:30",
                                              style: Apptextstyle.dashvalue),
                                        )),
                                      ],
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 0, bottom: 0),
                          child: Text(Appstring.pickuptitle,
                              style: Apptextstyle.login
                                  .copyWith(color: Appcolors.primary)),
                        ),
                        Card(
                          margin: EdgeInsets.all(20),
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            Appstring.plocation,
                                            style: Apptextstyle.dashtitle,
                                          ),
                                        ),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(Appstring.ptime,
                                              style: Apptextstyle.dashtitle),
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Apptextstyle.divider,
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Text("Adalaj",
                                              style: Apptextstyle.dashvalue),
                                        ),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text("11:30",
                                              style: Apptextstyle.dashvalue),
                                        )),
                                      ],
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )))
                ],
              ),
            ),
          ],
        ));
  }


  AlertDiolog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        WaitRequest();
      onclick=true;
      startTimer();
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(

      title: Text("Wait Request Conformation"),
      content: Text("Are You sure for wait request"),
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

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _start;
            onclick=false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }


  void WaitRequest()async {
    print("add member sos");
    Fluttertoast.showToast(msg: "Wait Request Send",toastLength: Toast.LENGTH_LONG);
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login sosrequest=await sessionManagement.getmodel("Member");
    String token= sosrequest.result.member.response.token;
    String memberid=sosrequest.result.member.response.memberId;
    print(memberid);
    MemberWaitRequest login= await api.AddMemberWaitRequest(token,memberid,shiftid,vehicalid);
    if(login.message=="Ok"){
      print("update data successfully");
      Fluttertoast.showToast(msg: "Wait Request Add successfully",toastLength: Toast.LENGTH_LONG);

    }else{
      Fluttertoast.showToast(msg: "Wait Request not Add",toastLength: Toast.LENGTH_LONG);
    }

  }

  void getnotificationcount()async {
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login sosrequest=await sessionManagement.getmodel("Member");
    String token= sosrequest.result.member.response.token;
    String memberid=sosrequest.result.member.response.memberId;
    print(memberid);
    NotificationCount login= await api.getNotificationcount(token,memberid,"MEB",);
    if(login.message=="Ok"){
      setState(() {
         list_notification=login.result;
         count=login.result[0].notificationCount.toString();
      });
      print("FULL NOTIFICATION LIST SHOW");
      print(list_notification);
    }else{
      Fluttertoast.showToast(msg: "Wait Request not Add",toastLength: Toast.LENGTH_LONG);
    }

  }

  void Apicallmapping() async{
    print("ASDFGHJKLZXCVBNM");
    HttpService api=  HttpService();
    SessionManagement sessionManagement=SessionManagement();
    Login logindata = await sessionManagement.getmodel('Member');
    String token  = logindata.result.member.response.token;
    String memberid=logindata.result.member.response.memberId;
    String contct=logindata.result.member.response.contactNo;
    print(logindata.result.member.response.memberId);
    dynamic login= await api.Appmapping(token,contct,memberid);
    print("ABCDEFGHIJKLMN");
    print(login["isSuccess"]);
    print(login["isSuccess"]);
    if(login["isSuccess"]==true){
      Mappingmember mapping=Mappingmember.fromJson(login);
      sessionManagement.CreateSessionMap(mapping);
    }else{
      Failed fail=Failed.fromJson(login);
      print(fail.message);
    }
  }

  Future<void> setdata() async {
    SessionManagement sessionManagment = SessionManagement();
    Mappingmember map=await sessionManagment.getmodelMap("Map");
    setState(() {

      shiftid=map.result.memberDefaultMapping[0].shiftTypeId;
      vehicalid=map.result.memberDefaultMapping[0].memberVehicleRegId;
    });
    print("GET MAPPING DATA AT THIS SCREN");
    print(shiftid);
  }

}
