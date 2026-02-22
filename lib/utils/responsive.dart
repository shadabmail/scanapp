import 'package:flutter/material.dart';
import '../config/app_config.dart';

class Responsive {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  
  static double sp(BuildContext context, double size) {
    return size * MediaQuery.of(context).textScaleFactor.clamp(AppConfig.textScaleMin, AppConfig.textScaleMax);
  }
  
  static double wp(BuildContext context, double percentage) {
    return width(context) * percentage / 100;
  }
  
  static double hp(BuildContext context, double percentage) {
    return height(context) * percentage / 100;
  }
}
