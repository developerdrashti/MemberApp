// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';

import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/Profile.dart';
import 'package:dropikme001/model/Updateprofile.dart';
import 'package:dropikme001/screens/Profile_Screen.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/AppImages.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import '../utils/AppColors.dart';
import 'package:path/path.dart' as path;

class ProfiledetailScreen extends StatefulWidget{
  var name;
  var email;
  var address;
  var bloodgroup;
  var image;
   ProfiledetailScreen(this.name,this.email,this.address,this.bloodgroup,this.image);



  @override
  State<StatefulWidget> createState() =>Profiledetail();

  }
  class Profiledetail extends State<ProfiledetailScreen>{
  bool NAME=false;
  bool EMAIL=false;
  bool ADDRESS=false;
  String _errorMessage = '';
    //var selectedImagePath = "".obs;
    File? galleryFile;
    final picker = ImagePicker();
  TextEditingController name=TextEditingController();
  TextEditingController Email=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController bloodgroup=TextEditingController();
    String image="http://3.26.113.171:8080/member/image/";
    String _base64Image="";
   String Selectedimage="";
  String ImageName ="";
  String binart="";
  String profile="";
  String imagepath = "";
  @override
  void initState(){
    super.initState();
    dataset();
  }
    Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.primary,
        title: const Text("Profile Details",style: TextStyle(
            fontFamily: "OpenSans",
            color: Colors.white,
            fontSize: 20
        ),),
        leading: GestureDetector(
          onTap: (){
          Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        actions: [
          GestureDetector(
              onTap: (){
               // showAlertDialog(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Icon(Icons.notifications_none),
              )
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Appcolors.primary,
                ),
              ),
              Expanded(
                child: Container(
                  color: Appcolors.white,
                ),
              )
            ],
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  child:   Container(
                    margin: const EdgeInsets.only(top: 100, bottom: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 100),
                              margin: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: TextField(
                                            controller:name,
                                            style:const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                            autofocus: false,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  12.0,
                                                ),
                                              ),
                                              enabledBorder:
                                              const OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        12.0)),
                                                borderSide: BorderSide(

                                                ),
                                              ),

                                              hintStyle: const TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.w500,
                                              ),
                                              errorText: NAME?"":null,
                                              contentPadding:
                                              const EdgeInsets.all(20),
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'E-Mail',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: TextField(
                                            onChanged: (val){
                                              validateEmail(val);
                                            },
                                            controller: Email,
                                            style:const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                            autofocus: false,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  12.0,
                                                ),
                                              ),
                                              enabledBorder:
                                              const OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        12.0)),
                                                borderSide: BorderSide(

                                                ),
                                              ),
                                              errorText: EMAIL?"":null,
                                              hintStyle: const TextStyle(
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
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Address',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: TextField(
                                            controller: address,
                                            style:const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                            autofocus: false,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  12.0,
                                                ),
                                              ),
                                              enabledBorder:
                                              const OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        12.0)),
                                                borderSide: BorderSide(

                                                ),
                                              ),
                                              errorText: ADDRESS?"":null,
                                              hintStyle: const TextStyle(
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
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Blood Group',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: TextField(
                                            controller: bloodgroup,
                                            style:const TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                            autofocus: false,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  12.0,
                                                ),
                                              ),
                                              enabledBorder:
                                              const OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        12.0)),
                                                borderSide: BorderSide(

                                                ),
                                              ),
                                              hintStyle: const TextStyle(
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

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _showPicker(context: context);
                  },
                  child: galleryFile==null?Container(
                    margin: const EdgeInsets.only(left: 0,top: 20),
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Appcolors.primary,
                          width: 3.0,
                          style: BorderStyle.solid),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(160)),
                      boxShadow: [
                        BoxShadow(
                          color: Appcolors.primary.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 25,
                          offset: const Offset(
                              0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child:Image.network(widget.image, height: 200,
                          width: 200,)

                        ),
                      ),

                  ):Container(
                    margin: const EdgeInsets.only(left: 0,top: 20),
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Appcolors.primary,
                          width: 3.0,
                          style: BorderStyle.solid),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(160)),
                      boxShadow: [
                        BoxShadow(
                          color: Appcolors.primary.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 25,
                          offset: const Offset(
                              0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child:
                        Image.file(galleryFile!,height: 200,width: 200,

                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  padding:  const EdgeInsets.all(20),
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
                        //Navigator.push(context,MaterialPageRoute(builder: (context)=>EditStudentsDetails()));
                        if(name.text.trim().isNotEmpty && Email.text.trim().isNotEmpty && address.text.trim().isNotEmpty){
                          updateprofile(name.text,Email.text,address.text,bloodgroup.text,);
                        }else{
                          setState(() {
                            name.text.trim().isEmpty?NAME=true:NAME=false;
                            Email.text.trim().isEmpty?EMAIL=true:EMAIL=false;
                           address.text.trim().isEmpty?ADDRESS=true:ADDRESS=false;
                          });
                        }
                      },
                      child: const Text('Submit',style: TextStyle(
                          fontFamily:'OpenSans',fontSize: 18,fontWeight: FontWeight.w600
                      ),),
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }

  void updateprofile(String name,String Email,String address,String bloodgroup,) async {
    print("UPDATED PROFILE");
    HttpService api = HttpService();
    SessionManagement sessionManagement = await SessionManagement();
    Login updateprofile = await sessionManagement.getmodel("Member");
    String token = updateprofile.result.member.response.token;
    String memberid = updateprofile.result.member.response.memberId;
    UpdateProfile update = await api.updateprofile(token,memberid,Selectedimage,ImageName,bloodgroup,name,Email);
    print(update.message);
    if (update.message == "Ok") {
      print(update.message);
     // Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
      Fluttertoast.showToast(
          msg: update.message, toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(msg: "notupdated", toastLength: Toast.LENGTH_LONG);
    }
  }
  void dataset() async{
    setState(() {
      name.text=widget.name;
      Email.text=widget.email;
      address.text=widget.address;
      bloodgroup.text=widget.bloodgroup;



    });
    print("kdsughiulesoifdjds");
    print(Email.text);
  }



  void _showPicker({required BuildContext context,}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery,);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
    // Future<void> getImage(ImageSource img) async {
    //   final pickedImage = await picker.pickImage(source: img);
    //
    //   if (pickedImage != null) {
    //     final File imageFile = File(pickedImage.path);
    //     final bytes = await imageFile.readAsBytesSync();
    //     final imageName = path.basename(pickedImage.path);
    //
    //     setState(() {
    //       _base64Image = base64Encode(bytes);
    //       galleryFile = File(pickedImage!.path);
    //       imagepath=imageName;
    //       selectedImagePath.value=pickedImage.path;
    //       print("abcdefghijklmnopqrstuvwxyz");
    //       print(imageFile);
    //     });print(_base64Image);
    //     print(bytes);
    //     print(pickedImage.path);
    //     print("ONLY IMNAGE NAME PRINT ");
    //     print(imageName);
    //   }
    // }
    void getImage(ImageSource imageSource) async {
      var pickedFile = await ImagePicker().pickImage(
        source: imageSource,
      );

      if (pickedFile != null) {
        // imgFile= pickedFile as File;
        final imageName = path.basename(pickedFile.path);
        galleryFile = File(pickedFile.path);
        // base64Image = imgFile.path;
        _base64Image = base64Encode(galleryFile!.readAsBytesSync());
        print('imgFile path: $galleryFile');
        debugPrint('base64Image: $_base64Image');
        //selectedImagePath.value = pickedFile.path;
        setState(() {
          imagepath=pickedFile.path;
          Selectedimage=base64Encode(galleryFile!.readAsBytesSync());
          ImageName=path.basename(pickedFile.path);


         // name.text=Selectedimage;
        });
        print("print selecte dimage data");
        print(Selectedimage);
        print(ImageName);

       // update();
      } else {

      }
    }

  void validateEmail(String val) {
    if(val.isEmpty){
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    }else if(!EmailValidator.validate(val, true)){
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    }else{
      setState(() {

        _errorMessage = "";
      });
    }
  }



}