import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../Profile/Update_password.dart';
import '../api/api_services.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
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
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.sendForgotOtp}'));
    request.fields.addAll({
      'mobile': mobileController.text,
      'fcm_id' : '${token}'
    });
///Are ghar jaao enjoy karo
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalresponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalresponse);

      if (jsonresponse['error'] == false) {
        String otp = jsonresponse['data'][0]["otp"];
        String mobile = jsonresponse['data'][0]["mobile"];

        Fluttertoast.showToast(msg: '${jsonresponse['message']}',backgroundColor: colors.secondary);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UpdatePassword(OTP: otp.toString(),MOBILE:mobile.toString() ,)
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
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
      child: Scaffold(
        appBar: customAppBar(text: "Forgot Password", isTrue: true, context: context),
        body: Form(
          key: _formKey,
          child: Column(
             children: [
               SizedBox(height: 50,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Card(
                   shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   elevation: 1,
                   child: Center(
                     child: TextFormField(
                       controller: mobileController,
                       keyboardType: TextInputType.number,
                       maxLength: 10,
                       validator: (v) {
                         if (v!.length != 10) {
                           return "mobile number is required";
                         }
                       },
                       decoration: const InputDecoration(
                         border: InputBorder.none,
                         counterText: "",
                         contentPadding:
                         EdgeInsets.only(left: 15, top: 15),
                         hintText: "Mobile Number",hintStyle: TextStyle(color: colors.secondary),
                         prefixIcon: Icon(
                           Icons.call,
                           color:colors.secondary,
                           size: 20,
                         ),

                       ),
                     ),
                   ),
                 ),
               ),
               SizedBox(height: 10,),
               InkWell(
                   onTap: (){
                     setState((){
                       isLoading = true;
                     });
                     if(mobileController.text.isNotEmpty && mobileController.text.length == 10){
                       loginwitMobile();
                     }else{
                       setState((){
                         isLoading = false;
                       });
                       Fluttertoast.showToast(msg: "Please enter valid mobile number!",backgroundColor: colors.secondary);
                     }
                   },
                   child:  Padding(
                     padding: const EdgeInsets.only(left: 0,top: 10,bottom: 10),
                     child: Container(
                       height: 50,
                       width: MediaQuery.of(context).size.width/1.2,
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: colors.secondary),
                       child:
                       Center(child: Text("Send OTP", style: TextStyle(fontSize: 18, color: colors.whiteTemp))),
                     ),
                   )
               ),

             ],
          ),
        ),
      ),
    );
  }
}
