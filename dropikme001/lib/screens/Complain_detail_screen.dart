import 'package:dropikme001/model/AddDriverComplain.dart';
import 'package:dropikme001/model/AddMemberLeave.dart';
import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/mapingmember.dart';
import 'package:dropikme001/screens/Complain_screen.dart';
import 'package:dropikme001/screens/Navigation_screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Complaindetailscreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>Complaindetail();
   
  }
  class Complaindetail extends State<Complaindetailscreen>{
    @override
    void initState() {
      super.initState();
      setdata();
    }
    TextEditingController Compalin=TextEditingController();
    bool compalinerror =false;
    String driverid="";
    String vehicalid="";
    String createdby="";
    String updatedby="";
    bool isactive=true;
    bool isdelete=false;
    @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Appcolors.primary,
      title: Text("Complain Details",style: TextStyle(
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
        Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(" Complain",style: TextStyle(
                  fontSize: 20,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w400,
                  color: Colors.black
              ),),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextField(
                  controller: Compalin,
                  style:TextStyle(
                    fontSize: 18,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w500,
                  ),
                  autofocus: false,
                  maxLines: 10,
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

                    hintText: "Enter Your Complain",
                    errorText: compalinerror?"":null,
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding:
                    const EdgeInsets.all(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(

                  padding:  EdgeInsets.all(20),
                  color: Colors.white,
                  child: SizedBox(
                    height: 60,
                    width: 360,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all(Appcolors.primary),

                          backgroundColor: MaterialStateProperty.all(
                              Appcolors.primary),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              )
                          )
                      ),

                      onPressed: () {
                      if(Compalin.text.trim().isNotEmpty){
                        Addcomplain(Compalin.text);
                      }else{
                        setState(() {
                          Compalin.text.trim().isEmpty?compalinerror=true:compalinerror=false;
                        });
                      }
                        //Navigator.push(context,MaterialPageRoute(builder: (context)=>EditStudentsDetails()));

                      },
                      child: Text('Submit',style: TextStyle(
                          fontFamily:'OpenSans',fontSize: 18,fontWeight: FontWeight.w600
                      ),),
                    ),
                  )
              ),
            ],
          ),
        )
      ],
    )
  );
  }

  void Addcomplain(String complainmessage) async {
    HttpService api=  HttpService();
    SessionManagement sessionManagement=await SessionManagement();
    Login addleave=await sessionManagement.getmodel("Member");
    String memberid=addleave.result.member.response.memberId;
    String token= addleave.result.member.response.token;
        AddComplain Complain= await api.AddDriverComplain(token,driverid,memberid , vehicalid,complainmessage  , memberid, memberid, true, false);
    if(Complain.message=="Ok"){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationScreen(selectIndex: 3,)), (route) => false);
      Fluttertoast.showToast(msg: "Complain Add successfully",toastLength: Toast.LENGTH_LONG);

    }else{
      Fluttertoast.showToast(msg: "Complain not Add",toastLength: Toast.LENGTH_LONG);
    }
  }

  void setdata()async {
      SessionManagement session=await SessionManagement();
      Mappingmember map=await session.getmodelMap("Map");
      setState(() {
      driverid=map.result.memberDefaultMapping[0].memberDriverId;
      vehicalid=map.result.memberDefaultMapping[0].memberVehicleRegId;
      });

  }
  
}