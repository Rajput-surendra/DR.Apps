import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Generic&Brand/generic_brand_screen.dart';
import '../Helper/Appbar.dart';
import 'package:http/http.dart'as http;

import '../Helper/Color.dart';
import '../New_model/GetSelectCatModel.dart';
import '../api/api_services.dart';
import 'multiple_select.dart';

class BrandUploadScreen extends StatefulWidget {
  BrandUploadScreen({Key? key,this.catName,this.catId}) : super(key: key);
  String ? catName,catId;
  @override
  State<BrandUploadScreen> createState() => _BrandUploadScreenState();
}

class _BrandUploadScreenState extends State<BrandUploadScreen> {
  final _formKey = GlobalKey<FormState>();


  String? userId;
  getRole()async{
    SharedPreferences preferences  = await  SharedPreferences.getInstance();
    userId = preferences.getString("userId");
  }
  @override
  void initState() {
    super.initState();
    getRole();
    getSpecialityApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Speciality Brand", isTrue: true, ),
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
                      SizedBox(height: 10,),
                      Text("Select brand speciality to promote your brand. Select minimum 1 and maximum 5 brand specialties.",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text("Select Brand Speciality"),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      SizedBox(height: 5,),
                      select(),
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
  List<String> results = [];
  Widget select() {
    return InkWell(
      onTap: () {
        setState(() {
            _showMultiSelect();
        });
      },
      child:
     Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            border: Border.all(color: colors.blackTemp.withOpacity(0.4))),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:results==null ?[]:  results.map((e) {
              return Padding(
                padding:
                const EdgeInsets.only(top: 15,right: 2,left: 2),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colors.primary),
                    child: Center(
                        child: Text(
                          "${e}",
                          style: TextStyle(color: colors.whiteTemp),
                        ))),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  void _showMultiSelect() async {
    results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return MultiSelect1(speciplyList: selectCatModel?.data );
        });
      },
    );
    setState(() {});
  }
  SpeciplyData? catDrop;
  List<SpeciplyData> speciplyData =  [];
  GetSelectCatModel? selectCatModel;
  getSpecialityApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? Roll = preferences.getString('roll');
    print("getRoll--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=742f7d5e34b7f410d122da02dbbe7e75f06cadc8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.selectCategory}'));
    request.fields.addAll({
      'roll':"1",
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = GetSelectCatModel.fromJson(jsonDecode(result));
      setState(() {
        selectCatModel = finalResult;
        speciplyData =  finalResult.data ?? [];
      });

    }
    else {
      print(response.reasonPhrase);
    }
  }
}

