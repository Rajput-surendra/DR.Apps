import 'dart:convert';
import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import 'package:http/http.dart'as http;

class VerifyOtp extends StatefulWidget {


  final otp;
  final mobile;

  VerifyOtp({Key? key,this.otp,this.mobile}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController pinController = TextEditingController();

  @override

  verifyOtp() async {
    print('____widget.otp______${widget.otp}_________');
    SharedPreferences preferences = await SharedPreferences.getInstance();

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
        print('__________${otp}__Otp_______');
        String userId = jsonresponse["data"]['id'];
        String roll = jsonresponse["data"]['roll'];
        String mobile = jsonresponse["data"]['mobile'];
        preferences.setBool('isLogin', true);
        preferences.setString('userId',userId);
        preferences.setString('roll',roll);
        preferences.setString('userMobile',mobile);
        Fluttertoast.showToast(msg: '${jsonresponse['message']}',backgroundColor: colors.secondary);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen()
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
  loginwitMobile() async {
    String? token ;
    try{
      token  = await FirebaseMessaging.instance.getToken();
      print("-----------token:-----${token}");
    } on FirebaseException{
      print('__________FirebaseException_____________');
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

      if (jsonresponse['error'] == false) {
        int? otp = jsonresponse["otp"];
        String mobile = jsonresponse["mobile"];
        Fluttertoast.showToast(msg: '${jsonresponse['message']}',backgroundColor: colors.secondary);
        print('_____otp_____${otp}_________');
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => VerifyOtp(otp: otp.toString(),mobile:mobile.toString() ,)
        //     ));
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
  void initState() {
    super.initState();
    //verifyOtp();
    // Future.delayed(Duration(seconds: 60)).then((_) {
    //   verifyOtp();
    //
    // });

  }
  @override
  Widget build(BuildContext context) {
    print('____widget.otp______${widget.otp}_________');
    return SafeArea(
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
          appBar: customAppBar(text: "Verification",isTrue: false, context: context),
          backgroundColor: colors.whiteTemp,
          body: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Code has sent to",
                    style: TextStyle(
                        color: colors.blackTemp,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Text(
                    "+91${widget.mobile}",
                    style: TextStyle(color:  colors.blackTemp,fontWeight:FontWeight.w500,fontSize: 18),
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

                            //runs when a code is typed in
                            onCodeChanged: (String code) {
                              print(code);

                            },
                            onSubmit: (String verificationCode) {
                              pinController.text = verificationCode;
                              if(widget.otp == pinController.text){
                                Fluttertoast.showToast(msg: "Otp  is match ",backgroundColor: colors.secondary);
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
                      // verifyOtp();
                      if(pinController.text== widget.otp){
                        verifyOtp();
                      }else{

                        Fluttertoast.showToast(msg: "Please enter valid otp!",backgroundColor: colors.secondary);
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
