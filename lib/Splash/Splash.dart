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

  // void checkingLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     uid = prefs.getString('USERID');
  //     type = prefs.getString('Role');
  //   });
  // }

  // checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _seen = (prefs.getBool('seen') ?? false);
  //
  //   if (_seen) {
  //     print("this is working here");
  //     if(uid == "" || uid == null ){
  //       // return SeekerDrawerScreen();
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  //     }
  //     else{
  //       print("hello user here  ${uid} and ${type}");
  //       if(type == "seeker") {
  //         print("working this here");
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => Dashboard()));
  //       }
  //       else{
  //         print("working now here ");
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => RecruiterDashboard()));
  //         /// jsut for ddummy data RecruiterDashboard data is use
  //       }
  //       // Navigator.push(context,
  //       //     MaterialPageRoute(builder: (context) => RecruiterDashboard()));
  //     }
  //
  //     // Navigator.of(context).pushReplacement(
  //     //     new MaterialPageRoute(builder: (context) => new LoginScreen()));
  //   } else {
  //     await prefs.setBool('seen', true);
  //     Navigator.of(context).pushReplacement(
  //         new MaterialPageRoute(builder: (context) => new IntroSlider()));
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration(milliseconds: 500),(){
    //   return ch eckingLogin();
    // });
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
          // Container(
          //     decoration: BoxDecoration(
          //         image:DecorationImage(
          //             image:AssetImage('assets/splash/splashimages.png',),
          //         )
          //     )
          // ),
        ),
      ),
    );
  }
}
