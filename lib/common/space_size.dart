import 'package:flutter/material.dart';
class SpaceSize{
  static double spaceHeightSize(BuildContext context, double size){
    return MediaQuery.of(context).size.height * size;
  }
  static double spaceWidthSize(BuildContext context, double size){
    return MediaQuery.of(context).size.width * size;
  }
}