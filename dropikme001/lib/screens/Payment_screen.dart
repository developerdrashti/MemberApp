import 'package:dropikme001/model/Login.dart';
import 'package:dropikme001/model/mapingmember.dart';
import 'package:dropikme001/services/Apiclass.dart';
import 'package:dropikme001/services/sessionmangement.dart';
import 'package:dropikme001/utils/AppImages.dart';
import 'package:dropikme001/utils/Apptextstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/AppColors.dart';

class PaymentScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>Payment();

}
class Payment extends State<PaymentScreen>{

  @override
 
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Appcolors.primary,
      //   title: Text("Payment",style: TextStyle(
      //       fontFamily: "OpenSans",
      //       color: Colors.white,
      //       fontSize: 20
      //   ),),
      //   leading: GestureDetector(
      //     onTap: (){
      //       Scaffold.of(context).openDrawer();
      //     },
      //     child: Icon(Icons.menu),
      //   ),
      //   actions: [
      //     GestureDetector(
      //         onTap: (){
      //           // showAlertDialog(context);
      //         },
      //         child: Padding(
      //           padding: EdgeInsets.all(20),
      //           child: Icon(Icons.notifications_none),
      //         )
      //     )
      //   ],
      // ),

      body: Stack(
        children: [

          Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Appcolors.primary),
                      child:Padding(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        child: Row(
                          children: [
                            // Expanded(
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //
                            //     children: [
                            //       Text("Total Amount",style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600,
                            //       fontSize: 18,
                            //       color: Appcolors.white),),
                            //       Text("20,000", style: Apptextstyle.lable.copyWith(fontSize: 14))
                            //     ],
                            //   ),
                            //
                            //
                            // ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Panding Amount",
                                  style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600,
                                color: Appcolors.white),
                                ),
                                SizedBox(height: 10,),
                                Text("6000", style: Apptextstyle.lable.copyWith(fontSize: 16,color: Appcolors.white))
                              ],
                            ),


                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Paid Amount",style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600,
                                  color: Appcolors.white),),
                                  SizedBox(height: 10,),
                                  Text("14000", style: Apptextstyle.lable.copyWith(fontSize: 16,color: Appcolors.white))
                                ],
                              ),


                            ),

                          ],
                        ),
                      )
                  ),

                  Expanded(
                      child:
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount:5,
                          itemBuilder: (context, position) {
                            // StudentList student=  list_student.length.toString();
                            return GestureDetector(
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>studentsdetails(list_student[position].wpUsrId,widget.wpid)));
                              },
                              child: Container(
                                margin:
                                const EdgeInsets.only(left: 20, right: 20,top: 10),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    // height: 120,
                                    decoration: BoxDecoration(
                                        color: Appcolors.primary.withOpacity(0.05),
                                        borderRadius: const BorderRadius.all(Radius.circular(15))),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(

                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Container(
                                                    margin: EdgeInsets.all(10),

                                                    height: 80,
                                                    width: 80,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.all(Radius.circular(15))
                                                    ),
                                                    child: ClipRRect(


                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        child: Image.asset(AppImages.bus,
                                                          fit: BoxFit.fitHeight,)
                                                    )
                                                )
                                            ),
                                         
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Bansi Manek",
                                              style: Apptextstyle.lable.copyWith(fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(height: 5,),
                                            Apptextstyle.dividercoman,
                                            SizedBox(height: 5,),
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_today,color: Appcolors.black.withOpacity(0.5),),
                                              SizedBox(width: 10,),
                                              Text(
                                                "December to March",
                                                style: Apptextstyle.lable.copyWith(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                            SizedBox(height: 5,),
                                            Apptextstyle.dividercoman,
                                            SizedBox(height: 5,),
                                            Text("1 jan 2022")


                                          ],
                                        ),),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                ],
              )),


        ],
      ),
    );
  }
}






