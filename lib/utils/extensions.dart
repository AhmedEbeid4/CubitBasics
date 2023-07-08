import 'package:flutter/material.dart';

extension Space on num{
  SizedBox get he => SizedBox(height: toDouble(),);
  SizedBox get wi => SizedBox(width: toDouble(),);
}

extension  ExtendedNavigator on BuildContext{
  Future<dynamic> pushNamed(String routeName,{Object? arguments})async{
    await Navigator.pushNamed(this, routeName,arguments: arguments);
  }
  Future<dynamic> pushReplacementNamed(String routeName,{Object? arguments}) async{
    await Navigator.pushReplacementNamed(this, routeName, arguments: arguments);
  }
}