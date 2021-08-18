import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowSnack{
  static showSnack(BuildContext context, String text) async{
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), behavior: SnackBarBehavior.floating, duration: Duration(seconds: 3), backgroundColor: Colors.blue,content: Container(child: Row(children: [text.text.bold.color(Colors.white).xl.make(), Container(height: 30, width: 45,child: CircularProgressIndicator(color: Colors.white,).px8())],))));
  }

  static showSnackMessage(BuildContext context, String text) async{
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), behavior: SnackBarBehavior.floating, duration: Duration(seconds: 3), backgroundColor: Colors.blue,content: Container(child: text.text.bold.color(Colors.white).xl.make(),)));
  }
}