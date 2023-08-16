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
    Future.delayed(Duration(seconds:2),() async{
      SharedPreferences prefs  = await SharedPreferences.getInstance();
      bool? isLogin  =  prefs.getBool('isLogin');
      if(isLogin ?? false) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      }

      // checkFirstSeen();

      // if(uid == null || uid == ""){
      //   // return SeekerDrawerScreen();
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      // }
      // else{
      //   if(type == "seeker") {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => RecruiterDashboard()));
      //   }
      //   else{
      //     /// jsut for ddummy data RecruiterDashboard data is use
      //   }
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => RecruiterDashboard()));
      //   }
      //return SignInScreen();
    });
    // Timer(Duration(seconds: 3), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> IntroSlider()));});
    super.initState();

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
