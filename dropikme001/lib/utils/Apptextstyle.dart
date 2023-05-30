import 'package:dotted_line/dotted_line.dart';
import 'package:dropikme001/utils/AppColors.dart';
import 'package:flutter/material.dart';

class Apptextstyle{
 static TextStyle login=TextStyle(
    fontFamily: "OpenSans",
    fontWeight: FontWeight.w600,
    color: Appcolors.black
  );
 static TextStyle lable=TextStyle(
     fontFamily: "OpenSans",
     fontWeight: FontWeight.w400,
     color: Appcolors.black,
  fontSize: 20
 );
 static TextStyle drawerlable=TextStyle(
     fontFamily: "OpenSans",
     fontWeight: FontWeight.w500,
     color: Appcolors.black,
     fontSize: 20
 );
 static TextStyle dashtitle=TextStyle(
     fontSize: 16,
     fontFamily: "OpenSans",
     fontWeight: FontWeight.w600,
     color: Colors.black
 );
 static TextStyle dashvalue=TextStyle(
     fontFamily: "OpenSans",
     fontWeight: FontWeight
         .w400,
     fontSize: 14,
     color: Colors
         .black.withOpacity(0.5));
 static DottedLine divider=DottedLine(

  dashColor: Colors.black,
  dashGapLength: 3,
  dashLength: 5,
 );
 static DottedLine dividersmall= DottedLine(
  lineLength:140,
  dashColor: Colors.black,
  dashGapLength: 3,
  dashLength: 5,
 );
 static DottedLine dividercoman= DottedLine(
  dashColor: Colors.black.withOpacity(0.08),
  dashGapLength: 3,
  dashLength: 5,
 );
 static DottedLine dividerprofile= DottedLine(
  dashColor: Colors.black,
  dashGapLength: 3,
  dashLength: 5,
 );
}