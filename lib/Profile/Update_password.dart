import 'dart:convert';

import 'package:doctorapp/AuthenticationView/LoginScreen.dart';
import 'package:doctorapp/Helper/Appbar.dart';
import 'package:doctorapp/New_model/update_profile_response.dart';
import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Helper/AppBtn.dart';
import '../Helper/Color.dart';
import '../api/api_services.dart';

class UpdatePassword extends StatefulWidget {
   UpdatePassword({Key? key,this.MOBILE,this.OTP}) : super(key: key);
  String? OTP,MOBILE;

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final newPasswordC = TextEditingController();
  final CpasswordC = TextEditingController();

  final pinController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('__________${widget.OTP}_________');
    verifyOtp() async {
      var headers = {
        'Cookie': 'ci_session=8aab49b6e6c12572dfec865bf8b192a8a73d19de'
      };
      var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_booking/app/v1/api/verify_otp'));
      request.fields.addAll({
        'mobile': widget.MOBILE.toString(),
        'otp': pinController.text,
        'otp_text': widget.OTP.toString(),
        'password': newPasswordC.text,
        'cnf_password': CpasswordC.text
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var finalResult =  jsonDecode(result);
        Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor: colors.secondary);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      else {
      print(response.reasonPhrase);
      }

    }
    return Scaffold(
      appBar:
          customAppBar(text: "Update password", isTrue: true, context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OtpTextField(
                          focusedBorderColor: colors.secondary,
                          numberOfFields: 4,
                          borderColor:colors.blackTemp,
                          fillColor: colors.blackTemp,
                          showFieldAsBox: true,
                          borderRadius: BorderRadius.circular(50),
                          // focusedBorderColor: colors.secondary,

                          borderWidth: 1.0,
                          fieldWidth: 60,

                          onCodeChanged: (String code) {
                            print(code);

                          },
                          onSubmit: (String verificationCode) {
                            pinController.text = verificationCode;
                            if(widget.OTP == pinController.text){
                              Fluttertoast.showToast(msg: "Otp  is match ",backgroundColor: colors.secondary);
                            }else{
                              Fluttertoast.showToast(msg: "Otp Incorrect ",backgroundColor: colors.secondary);
                            }

                          },),

                      ],
                    ),
                  ),
                ),
              SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "New Password",
                    style: TextStyle(
                        color: colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: newPasswordC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: '',
                      hintStyle:
                          TextStyle(fontSize: 15.0, color: colors.secondary),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.only(left: 10, top: 10)),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "password is required";
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Confirm New Password",
                    style: TextStyle(
                        color: colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: CpasswordC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: '',
                      hintStyle:
                          TextStyle(fontSize: 15.0, color: colors.secondary),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.only(left: 10, top: 10)),
                  validator: (v) {
                    if (newPasswordC.text != CpasswordC.text) {
                      return "password must be same";
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Btn(
                    color: colors.secondary,
                    height: 50,
                    width: 320,
                    title: 'Update Password',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        verifyOtp();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // updateProfile() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? userId = preferences.getString('userId');
  //
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           '${ApiService.getUserProfile}'));
  //   request.fields.addAll({
  //     'user_id': userId ?? '',
  //     'old': oldPasswordController.text,
  //     'new': newPasswordController.text,
  //   });
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     final response2 = await response.stream.bytesToString();
  //
  //     final result = UpdateprofileResponse.fromJson(jsonDecode(response2));
  //
  //     if (result.error == false) {
  //       print('__________${response2}_____________');
  //
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text(result.message ?? '')));
  //
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text(result.message ?? '')));
  //     }
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }
}
