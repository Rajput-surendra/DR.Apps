import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:doctorapp/Generic&Brand/generic_brand_screen.dart';
import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Appbar.dart';
import '../New_model/Get_brand_model.dart';
import 'Gereric_Brand_Uplaod_Screen.dart';
import 'genericRx_Dosage_Screen.dart';
import 'package:http/http.dart' as http;

import 'get_brand_details_plans.dart';

class GenericBrandDetailsScreen extends StatefulWidget {
  GenericBrandDetailsScreen({Key? key, this.catId, this.catName})
      : super(key: key);
  String? catId, catName;

  @override
  State<GenericBrandDetailsScreen> createState() =>
      _GenericBrandDetailsScreenState();
}

class _GenericBrandDetailsScreenState extends State<GenericBrandDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GerericBrandUplaodScreen(
                          catName: catName,
                          catId: widget.catId,
                        )));
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: colors.primary, borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: Text(
              "Add Your Brand",
              style: TextStyle(color: colors.whiteTemp),
            )),
          ),
        ),
      ),
      appBar: customAppBar(
        context: context,
        text: "Generic & Brand",
        isTrue: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                    child: Text(
                  "${catName}",
                  style: TextStyle(color: colors.black54),
                )),
              ),
            ),
            getBrandModel == null
                ? Center(child: CircularProgressIndicator())
                : getBrandModel!.data!.length == 0
                    ? Center(child: Text("No brand list ??"))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: getBrandModel!.data == null ||
                                getBrandModel!.data == ""
                            ? 0
                            : getBrandModel!.data!.length,
                        itemBuilder: (c, i) {
                          var branddata = getBrandModel!.data;
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${branddata![i].name}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: colors.secondary, fontSize: 25),
                                ),
                                Text(
                                  "${branddata[i].genericName}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: colors.black54,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(10)),
                                            color: colors.darkIcon),
                                        child: Center(
                                            child: Text(
                                          "${branddata[i].companyName}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: colors.whiteTemp,
                                              fontSize: 12),
                                        )),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          if(branddata[i].isDetailPlanSubscribed == true){
                                            _showAlertDialog(context);
                                          }else{
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>GenericRxDosageScreen()));
                                          }


                                        },
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              color: colors.red),
                                          child: Center(
                                            child: BlinkText(
                                                '${branddata[i].detailText}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                                beginColor: colors.blackTemp,
                                                endColor: colors.whiteTemp,
                                                times: 1000,
                                                duration: Duration(seconds: 1)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
            SizedBox(
              height: 20,
            ),
            Text(
              "Thanks you \n Your brand with generic name\n and company name uploaded \nsuccessfully for Doctors area ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  GetBrandModel? getBrandModel;

  getBrandApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId");
    var headers = {
      'Cookie': 'ci_session=87531d167d460becac4ab2de220e6b1aa7a800bd'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${ApiService.getBrandApi}'));
    request.fields.addAll(
        {'user_id': userId.toString(), 'category_id': widget.catId.toString()});
    print('__________${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetBrandModel.fromJson(jsonDecode(result));
      setState(() {
        getBrandModel = finalResult;
        print('__________${finalResult}_________');
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  String? userId;

  getRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId");
    print('_____userId_____${userId}_________');
  }

  @override
  void initState() {
    super.initState();
    getRole();
    getBrandApi();
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
              height: MediaQuery.of(context).size.height/1.6,
              width: double.infinity,
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Detail layout of ',
                      style: TextStyle(fontSize: 13,color: colors.blackTemp),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'BRAND DETAILS AREA',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: colors.blackTemp)),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Image.asset("assets/images/generic.png"),
                  // Container(
                  //   height: 50,
                  //  decoration: BoxDecoration(
                  //    border: Border.all(color: colors.blackTemp)
                  //  ),
                  //   child: Center(child: Text("Logo upload area\n image size : 200 pixel * 100 pixed",style: TextStyle(fontSize: 12),)),
                  // ),
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandDetailsPlansScreen()));
                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: colors.secondary,
                          // border: Border.all(color: colors.primary,width: 4),


                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Subscribe now to upload ',style: TextStyle(fontSize: 11),
                              children: const <TextSpan>[
                                TextSpan(text: 'BRAND MODEL', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                              ],
                            ),
                          ),
                        )

                    ),
                  )
                ],
              )),
          // actions: [],
        );
      },
    );
  }
}
