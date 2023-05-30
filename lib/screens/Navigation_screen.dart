import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:dropikme001/model/AddDayOff.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/NotificationCount.dart';
import 'package:dropikme001/model/NotificationUpdate.dart';
import 'package:dropikme001/model/mapingmember.dart';
import 'package:dropikme001/screens/Complain_screen.dart';
import 'package:dropikme001/screens/Dashboard_screen.dart';
import 'package:dropikme001/screens/Leave_screen.dart';
import 'package:dropikme001/screens/Login_screen.dart';
import 'package:dropikme001/screens/Notification_screen.dart';
import 'package:dropikme001/screens/Payment_screen.dart';
import 'package:dropikme001/screens/Profile_Screen.dart';
import 'package:dropikme001/screens/Sos_list_screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/AppColors.dart';
import 'package:dropikme001/utils/AppImages.dart';
import 'package:dropikme001/utils/AppString.dart';
import 'package:dropikme001/utils/Apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    title: 'Home',
  ),
  TabItem(
    icon: Icons.calendar_today,
    title: 'Leave',
  ),
  TabItem(
    icon: Icons.payment,
    title: 'Payment',
  ),
  TabItem(
    icon: Icons.people,
    title: 'Complain',
  ),
  TabItem(
    icon: Icons.surround_sound,
    title: 'SOS',
  ),

];
List<TabItem> items1 = [
  TabItem(
    icon: Icons.home,
    title: 'Home',
  ),
  TabItem(
    icon: Icons.calendar_today,
    title: 'Leave',
  ),
  TabItem(
    icon: Icons.people,
    title: 'Complain',
  ),

  TabItem(
    icon: Icons.surround_sound,
    title: 'SOS',
  ),

];

class NavigationScreen extends StatefulWidget{
  int? selectIndex;
  NavigationScreen({super.key, this.selectIndex,});

  State<NavigationScreen> createState() => Navigation();
}

class Navigation extends State<NavigationScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _selectedIndex = 0;
  String contactNo = "11111111111";
  String Membername = "";
  String Baseurl="http://3.26.113.171:8080/member/image/";
  String profile = "";
  bool payment=false;
  bool countshow=false;
  String count="";
  String driverid="";
  String vehicalid="";
  String createdby="";
  String updatedby="";
  List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    LeaveScreen(),
    PaymentScreen(),
    ComplainScreen(),
    SOS_List_Screen(),

  ];
  List<Widget> _widgetOptions1 = <Widget>[
    DashboardScreen(),
    LeaveScreen(),
    ComplainScreen(),
    SOS_List_Screen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.selectIndex != null ? _selectedIndex = widget.selectIndex! : null;
    setdata();
    getnotification();

  }

  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
        appBar: AppBar(
          backgroundColor: Appcolors.primary,
          title: payment==true?Text(_selectedIndex==0?"Dashboard":_selectedIndex==1?"Leave":_selectedIndex==2?"Payment":_selectedIndex==3?"Complain":_selectedIndex==4?"SOS":"",style: TextStyle(
              fontFamily: "OpenSans",
              color: Colors.white,
              fontSize: 20
          ),)
                :Text(_selectedIndex==0?"Dashboard":_selectedIndex==1?"Leave":_selectedIndex==2?"Complain":_selectedIndex==3?"SOS":_selectedIndex==4?"SOS":"",style: TextStyle(
              fontFamily: "OpenSans",
              color: Colors.white,
              fontSize: 20
          ),) ,leading: GestureDetector(
            onTap: (){
             _key.currentState!.openDrawer();
            },
            child: Icon(Icons.menu),
          ),
          actions: [
            _selectedIndex==0? GestureDetector(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.power_settings_new),
                )):Text(""),
            GestureDetector(
                onTap: () {
                  notificationupdate();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                  // showAlertDialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child:  Stack(
                    children: [
                      Icon(Icons.notifications_none),
                      Visibility(
                        visible: countshow,
                        child: Padding(padding: EdgeInsets.only(left: 15),
                            child:   Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Center(
                                  child: Text(count),
                                )
                            )),
                      )
                    ],
                  ),
                ))
          ],
        ),
        body: payment==true?_widgetOptions.elementAt(_selectedIndex):_widgetOptions1.elementAt(_selectedIndex),

        bottomNavigationBar: Container(


          child: payment==true?BottomBarInspiredOutside(
            items: items,
            backgroundColor: Appcolors.primary,
            color: Colors.white,
            colorSelected: Colors.white,
            indexSelected: _selectedIndex,
            onTap: (int index) => setState(() {
              _selectedIndex = index;
            }),

            top: -28,animated: false,itemStyle: ItemStyle.circle,chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.softEdge),

          ):BottomBarInspiredOutside(

            items: items1,
            backgroundColor: Appcolors.primary,
            color: Colors.white,
            colorSelected: Colors.white,
            indexSelected: _selectedIndex,
            onTap: (int index) => setState(() {
              _selectedIndex = index;
            }),

            top: -28,animated: false,itemStyle: ItemStyle.circle,chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.softEdge),

          ),
        ),
        drawer: Drawer(
            child: Container(
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Appcolors.primary,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30))
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                // the radius must be at least half of the width of the child Container
                                  borderRadius: BorderRadius.circular(600),
                                  child:
                                  Container(width: 100,
                                    height: 100,
                                    color: Colors.blue[200],
                                    child: Image.network("$Baseurl$profile",
                                      fit: BoxFit.cover,),
                                  )
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Membername, style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600),),
                                  Text(contactNo, style: Apptextstyle.lable.copyWith(fontSize: 14),)
                                ],
                              )
                            ],
                          )
                      ),
                      Expanded(
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => ProfileScreen()));
                                },
                                leading: Icon(Icons.note_outlined),
                                title: Text(Appstring.profile,
                                    style: Apptextstyle.drawerlable),
                              ),
                              ListTile(
                                onTap: () {
                                 payment==true?_onItemTapped(3):_onItemTapped(2);
                                 Navigator.pop(context);
                                },
                                title: Text(Appstring.complain,
                                    style: Apptextstyle.drawerlable),
                                leading: Icon(Icons.people),
                              ),
                              ListTile(
                                onTap: () {
                                  _onItemTapped(1);
                                  Navigator.pop(context);
                                },
                                leading: Icon(Icons.note_outlined),
                                title: Text(Appstring.leave,
                                    style: Apptextstyle.drawerlable),
                              ),

                              // ListTile(
                              //   onTap: () {},
                              //   leading: Icon(Icons.settings),
                              //   title: Text(Appstring.settings,
                              //       style: Apptextstyle.drawerlable),
                              // ),
                              // ListTile(
                              //   onTap: () {},
                              //   leading: Icon(Icons.report_gmailerrorred),
                              //   title: Text(Appstring.report,
                              //       style: Apptextstyle.drawerlable),
                              // )
                            ],
                          )),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(30))),
                        margin: EdgeInsets.all(20),
                        height: 60,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: ElevatedButton(

                          child: Text(Appstring.logout,
                            style: Apptextstyle.lable.copyWith(
                                color: Appcolors.white,
                                fontWeight: FontWeight.w600),),
                          onPressed: () {
                            Logout(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )

                          ),
                        ),
                      )
                    ],
                  ),
                )
            )
        )

    );
  }

  Future<void> setdata() async {
    SessionManagement sessionManagment = SessionManagement();
    Login student = await sessionManagment.getmodel('Member');
    Mappingmember map=await sessionManagment.getmodelMap("Map");
    setState(() {
      contactNo = student.result.member.response.contactNo;
      Membername = student.result.member.response.memberName;
      profile = student.result.member.response.profilePhoto;
      payment=student.result.member.paymentCheck;
      driverid=map.result.memberDefaultMapping[0].memberDriverId;
      vehicalid=map.result.memberDefaultMapping[0].memberVehicleRegId;
    });
    print("GET MAPPING DATA AT THIS SCREN");
    print(driverid);
    print(profile);
  }


  Future Logout(BuildContext context) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setBool("Login", false);
    SessionManagement sessionManagement=await SessionManagement();
    sessionManagement.DestroyLogindata();
    Fluttertoast.showToast(
        msg: "Logout Successfully ", toastLength: Toast.LENGTH_SHORT);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));




  }

  void getnotification() async {
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login sosrequest=await sessionManagement.getmodel("Member");
    String token= sosrequest.result.member.response.token;
    String memberid=sosrequest.result.member.response.memberId;
    print(memberid);
    NotificationCount login= await api.getNotificationcount(token,memberid,"MEB",);
    if(login.message=="Ok"){
      setState(() {
        //count=login.result.notificationCount.toString();
      });
      print("FULL NOTIFICATION LIST SHOW");
    }else{
      Fluttertoast.showToast(msg: "Wait Request not Add",toastLength: Toast.LENGTH_LONG);
    }

  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        AddDayoffleave();
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Leave Conformation"),
      content: Text("Are You sure for leave"),
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

  void AddDayoffleave()async {
    print("add member sos");
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login addleave=await sessionManagement.getmodel("Member");
    String token= addleave.result.member.response.token;
    String memberid=addleave.result.member.response.memberId;
    AddDayoff Adddayoff= await api.AddDayoffLeave(token,memberid,vehicalid,memberid,memberid);
    if(Adddayoff.message=="Ok"){
      print("update data successfully");
      Fluttertoast.showToast(msg: "Day Off Leave Add successfully",toastLength: Toast.LENGTH_LONG);

    }else{
      Fluttertoast.showToast(msg: "Leave not Add",toastLength: Toast.LENGTH_LONG);
    }

  }

  void notificationupdate()async {
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login sosrequest=await sessionManagement.getmodel("Member");
    String token= sosrequest.result.member.response.token;
    String memberid=sosrequest.result.member.response.memberId;
    print(memberid);
    NotificationUpdate login= await api.getNotificationupdate(token,memberid,"CLEAR",);
    if(login.message=="Ok"){
      setState(() {
        countshow=login.result.isRead;
      });
      print("FULL NOTIFICATION LIST SHOW");
    }else{
      Fluttertoast.showToast(msg: "Wait Request not Add",toastLength: Toast.LENGTH_LONG);
    }

  }
}