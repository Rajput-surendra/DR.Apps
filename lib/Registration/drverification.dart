import 'dart:convert';

import 'package:doctorapp/AuthenticationView/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../AuthenticationView/VerifyOtp.dart';
import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import '../Screen/HomeScreen.dart';
import '../api/api_services.dart';

class NewCerification extends StatefulWidget {
  final otp;
  final mobile;
  const NewCerification({Key? key,this.otp,this.mobile}) : super(key: key);

  @override
  State<NewCerification> createState() => _NewCerificationState();
}

class _NewCerificationState extends State<NewCerification> {
  TextEditingController pinController = TextEditingController();
  verifyOtp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    print("successsssssssssssss");
    var headers = {
      'Cookie': 'ci_session=1fae43cb24be06ee09e394b6be82b42f6d887269'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.verifyOtp}'));
    request.fields.addAll({
      'mobile': widget.mobile.toString(),
      'otp': widget.otp.toString()
    });
    print("ooooooooooooo>>>>>>>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalresponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalresponse);

      if (!jsonresponse['error']){
        String? otp = jsonresponse["otp"];
        String userId = jsonresponse["data"]['id'];
        String roll = jsonresponse["data"]['roll'];
        // preferences.setBool('isLogin', true );
        preferences.setString('userId',userId);
        preferences.setString('roll',roll);
        Fluttertoast.showToast(msg: '${jsonresponse['message']}',backgroundColor: colors.secondary);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen()
            ));
      }
      else{
        Fluttertoast.showToast(msg: "${jsonresponse['message']}",backgroundColor: colors.secondary);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }
  loginwitMobile() async {
    String? token ;
    try{
      token  = await FirebaseMessaging.instance.getToken();

    } on FirebaseException{

    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('otp', "otp");
    preferences.setString('mobile', "mobile");
    print("this is apiiiiiiii");
    var headers = {
      'Cookie': 'ci_session=b13e618fdb461ccb3dc68f327a6628cb4e99c184'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.sendOTP}'));
    request.fields.addAll({
      'mobile': widget.mobile,
      'fcm_id' : '${token}'
    });


    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {

      var finalresponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalresponse);
      // Future.delayed(Duration(seconds: 1)).then((_) {
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => VerifyOtp()
      //       ));
      // });

      if (jsonresponse['error'] == false) {

        int? otp = jsonresponse["otp"];
        String mobile = jsonresponse["mobile"];
        Fluttertoast.showToast(msg: '${jsonresponse['message']}',backgroundColor: colors.secondary);
        print('____Surendra______${otp}_________');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyOtp(otp: otp.toString(),mobile:mobile.toString() ,)
            ));
      }
      else{
        Fluttertoast.showToast(msg: "${jsonresponse['message']}",backgroundColor: colors.secondary);
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    print('___widget.otp_______${widget.otp}_________');
    return  SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: colors.primary),
                      child: Text("YES"),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: colors.primary),
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          return true;
        },
        child: Scaffold(
          appBar: customAppBar(text: "Verification",isTrue: true, context: context),
          backgroundColor: colors.whiteTemp,
          body: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Code has sent to",
                    style: TextStyle(
                        color: colors.blackTemp,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Column(
                    children: [
                      Text(
                        "+91${widget.mobile}",
                        style: TextStyle(color:  colors.blackTemp,fontWeight:FontWeight.w500,fontSize: 18),
                      ),
                      // SizedBox(height: 5,),
                      // Text("OTP: ${widget.otp}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "OTP-${widget.otp}",
                  //   style: TextStyle(color:  colors.blackTemp,fontWeight:FontWeight.bold,fontSize: 16),
                  // ),

                  SizedBox(height: 20,),
                  Center(
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OtpTextField(
                            numberOfFields: 4,
                            borderRadius: BorderRadius.circular(50),
                            borderColor: colors.secondary,
                            focusedBorderColor: colors.secondary,
                            showFieldAsBox: true,
                            borderWidth: 1.0,
                            fieldWidth: 60,
                            onCodeChanged: (String code) {
                              print(code);

                            },
                            //runs when every textfield is filled
                            onSubmit: (String verificationCode) {
                              pinController.text = verificationCode;
                              if(widget.otp == pinController.text){
                                Fluttertoast.showToast(msg: "Otp is match ",backgroundColor: colors.secondary);
                              }else{
                                Fluttertoast.showToast(msg: "Otp Incorrect ",backgroundColor: colors.secondary);
                              }

                            },),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Text("Haven't received the verification code?",style: TextStyle(
                      color: colors.blackTemp,fontSize: 15,fontWeight: FontWeight.bold
                  ),),
                  InkWell(
                    onTap: (){
                      loginwitMobile();
                    },
                    child: Text("Resend",style: TextStyle(
                        color: colors.secondary,fontWeight: FontWeight.bold,fontSize: 17
                    ),),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Btn(
                    color: colors.secondary,
                    height: 45,
                    width: 300,
                    title: 'Submit',
                    onPress: () {
                      if(pinController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please Enter Otp!!!!",backgroundColor: colors.secondary);
                      }else{
                        verifyOtp();

                      }
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
