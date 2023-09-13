import 'dart:convert';

import 'package:doctorapp/Generic&Brand/generic_brand_screen.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import 'generic_brand_details_screen.dart';

class GerericBrandUplaodScreen extends StatefulWidget {
   GerericBrandUplaodScreen({Key? key,this.catName,this.catId}) : super(key: key);
   String ? catName,catId;

  @override
  State<GerericBrandUplaodScreen> createState() => _GerericBrandUplaodScreenState();
}

class _GerericBrandUplaodScreenState extends State<GerericBrandUplaodScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: customAppBar(context: context, text:"Generics & Brands", isTrue: true, ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key:_formKey ,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: SizedBox(
                    height: 50,
                    child: Center(child: Text("${catName}",style: TextStyle(
                        color: colors.black54
                    ),)),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Brand Name"),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: brandNameC,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Brand Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text("Generic Name"),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: genericNameC,
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Generic Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),

                      Row(
                        children: [
                          Text("Company Name"),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: companyNameC,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Company Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 100,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            if(_formKey.currentState!.validate()){
                              uploadBrandApi();

                            }else{
                              Fluttertoast.showToast(msg: "All field are required",backgroundColor: colors.secondary);
                            }
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>GerericBrandUplaodScreen(catName:widget.catName,)));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: colors.primary,
                                borderRadius: BorderRadius.circular(15)
                            ),

                            child: Center(child: islodder ?Center(child: CircularProgressIndicator()): Text("Upload",style: TextStyle(color: colors.whiteTemp),)),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ) ,
    );
  }
  bool islodder = false;
  TextEditingController brandNameC =  TextEditingController();
  TextEditingController genericNameC =  TextEditingController();
  TextEditingController companyNameC =  TextEditingController();

  uploadBrandApi() async {
    setState(() {
      islodder =  true;
    });
    var headers = {
      'Cookie': 'ci_session=82be97770e4a4583108b0ce7341eef3db295b57c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.createBrandApi}'));
    request.fields.addAll({
      'user_id': userId.toString(),
      'category_id': widget.catId.toString(),
      'brand_name': brandNameC.text,
      'generic_name': genericNameC.text,
      'company_name': companyNameC.text
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       var  result = await response.stream.bytesToString();
       var finalResult = jsonDecode(result);
       Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor: colors.secondary);
       Navigator.pop(context,[true]);
       brandNameC.clear();
       genericNameC.clear();
       companyNameC.clear();
       setState(() {
         islodder = false;
       });
    }

    else {
      setState(() {
        islodder = false;
      });
    print(response.reasonPhrase);
    }

  }

  String? userId;
  getRole()async{
    SharedPreferences preferences  = await  SharedPreferences.getInstance();
    userId = preferences.getString("userId");
  }
  @override
  void initState() {
    super.initState();
    getRole();
  }
}
