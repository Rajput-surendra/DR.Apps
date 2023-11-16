import 'dart:convert';

import 'package:doctorapp/AuthenticationView/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../AuthenticationView/VerifyOtp.dart';
import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import '../Screen/HomeScreen.dart';
import '../api/api_services.dart';

class NewCerification extends StatefulWidget {
  int? otp;
  final mobile;

  List? newList1 ;
  String? title, name, email,gender,pass,cPass,cityName,stateID,cityID,placeID,degree,profileImages,roll,categoryId,experience,companyName,companyDivision,designationId,catType;
      NewCerification({Key? key,this.otp,this.mobile, this.title, this.name, this.email, this.gender, this.cityName, this.cityID, this.cPass, this.pass, this.degree, this
      .placeID, this.profileImages, this.stateID, this.roll, this.categoryId, this.experience,this.newList1,this.companyName,this.companyDivision,this.designationId,this.catType}) : super(key: key);

  @override
  State<NewCerification> createState() => _NewCerificationState();
}

class _NewCerificationState extends State<NewCerification> {

  bool isLoading =  false;
  String? msg;

   OtpFieldController  pinController = OtpFieldController();
   TextEditingController  pinController1 = TextEditingController();
  verifyOtp() async {


  }
  notRegistrtion() async {

    var headers = {
      'Cookie': 'ci_session=df570ff9aff445c600c3dbfa4fe01f9e4b8a7004'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_booking/app/v1/api/send_otp'));
    request.fields.addAll({
      'roll': widget.roll.toString(),
      'mobile': widget.mobile
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var  result =  await response.stream.bytesToString();
      var  finalResult =  jsonDecode(result);
      if(finalResult['error'] == false){
        int? otp = finalResult['data']['otp'];
        String?  mobile = finalResult['data']['mobile'];
        widget.otp = otp;

      }
      Fluttertoast.showToast(msg: "${finalResult['message']}");
    }
    else {
      print(response.reasonPhrase);
    }

  }

  registration() async {
    setState(() {
      isLoading = true;
    });
    if(false ){
    }
    else {
      String? token;
      try {
        token = await FirebaseMessaging.instance.getToken();
      } on FirebaseException {
      }
      List newList = [];
      var headers = {
        'Cookie': 'ci_session=7484a255faa8a60919687a35cf9c56e5c55326d2'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiService.userRegister}'));
      request.fields.addAll({
        'email': widget.email.toString(),
        'mobile':widget.mobile,
        'username': widget.name.toString(),
        'gender':widget.gender.toString(),
        'doc_degree':widget.degree.toString(),
        'address': widget.cityName.toString(),
        'c_address':"${newList}",
        'cat_type':widget.roll == "2" ?widget.catType.toString():"",
        'category_id':widget.categoryId.toString(),
        'designation_id':widget.roll == "2" ?widget.designationId.toString():"",
        'password':widget.pass.toString(),
        'roll': widget.roll.toString(),
        'confirm_password':widget.cPass.toString(),
        'fcm_id': token ?? '',
        'city': widget.cityName.toString(),
        'title': widget.title.toString(),
        "company_name": widget.companyName.toString(),
        "company_division":widget.roll == "2"? widget.companyDivision.toString():"",
        "state_id":widget.stateID.toString(),
        "city_id":widget.cityID.toString(),
        "area_id":widget.placeID.toString(),
        "experience":widget.experience.toString(),
        "json":widget.roll == "1" ? "${widget.newList1}" :""

      });

        if(widget.profileImages != "" && widget.profileImages != null){
      request.files.add(await http.MultipartFile.fromPath('image', widget.profileImages ?? ''));
      }
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final result = await response.stream.bytesToString();
        var finalResult = json.decode(result);
        msg = finalResult['message'];
        if (finalResult['error'] == false) {
          Fluttertoast.showToast(msg: finalResult['message'],backgroundColor: colors.secondary);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen()
              ));
          setState(() {
            isLoading = false;
          });
        }else{
          Fluttertoast.showToast(msg: finalResult['message'],backgroundColor: colors.secondary);

        }

      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg:'Email & Mobile Number Already registered',backgroundColor: colors.secondary);
        print(response.reasonPhrase);
      }
      //}
    }
  }
  String? newPin ;
  String? newPin1 ;
  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();

  @override
  void dispose() {
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),


                  const SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: OTPTextField(
                       outlineBorderRadius: 50 ,
                        controller:pinController,
                        otpFieldStyle: OtpFieldStyle(backgroundColor:colors.whiteTemp,borderColor:colors.whiteTemp),
                        length: 4,
                        keyboardType: TextInputType.number,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 50,
                        style: const TextStyle(fontSize: 17,color: colors.blackTemp),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.box,


                        onCompleted: (val) {
                          print("Completed: " + val);
                          setState(() {
                              newPin = val.toString().trim() ;
                          });
                        },

                      ),
                    ),

                  SizedBox(height: 40,),
                  Text("Haven't received the verification code?",style: TextStyle(
                      color: colors.blackTemp,fontSize: 15,fontWeight: FontWeight.bold
                  ),),
                  InkWell(
                    onTap: (){
                      notRegistrtion();
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
                       if(newPin.toString() == widget.otp.toString() ) {
                         registration();
                       }else{
                         Fluttertoast.showToast(msg: "Wrong OTP",backgroundColor: colors.secondary);
                       }


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
