import 'dart:async';

import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthenticationView/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String? uid;
  String? type;
  bool? isSeen;

  @override
  void initState() {
    inIt();
    super.initState();
  }
  inIt() {
    Future.delayed(const Duration(seconds:2),() async{

      SharedPreferences prefs  = await SharedPreferences.getInstance();
      bool? isLogin  =  prefs.getBool('isLogin');
      print('__________${isLogin}_________');
      if(isLogin == true) {
        if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      }else if(isLogin == null){
        if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));

      }else{
        if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.primary,
        body: Center(
          child: Image.asset("assets/splash/splashimages.png",height: 200,)
        ),
      ),
    );
  }
}
