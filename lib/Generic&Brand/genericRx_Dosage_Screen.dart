import 'dart:convert';
import 'dart:io';

import 'package:doctorapp/Generic&Brand/generic_brand_screen.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';

class GenericRxDosageScreen extends StatefulWidget {
 GenericRxDosageScreen({Key? key, this.catName}) : super(key: key);
 String? catName;

  @override
  State<GenericRxDosageScreen> createState() => _GenericRxDosageScreenState();
}

class _GenericRxDosageScreenState extends State<GenericRxDosageScreen> {
  int curentIndex = 0;
  File? imageFile;
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Generic & Brand", isTrue: true, ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(child: Text("${catName}",style: TextStyle(
                        color: colors.black54
                    ),)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Logo Upload Area",style: TextStyle(fontSize: 15),),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      Text("image size : 200 pixel * 100 pixel",style: TextStyle(fontSize: 13)),
                      SizedBox(height: 5,),
                      InkWell(
                        onTap: () {
                          showExitPopup();
                        },
                        child: Container(
                          height: imageFile == null ? 50:150,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors.primary,
                              border: Border.all(color: colors.black54)
                            ),
                            child: imageFile == null || imageFile == ""
                                ? const Center(
                                child: Text("Upload image",style: TextStyle(
                                  color: colors.blackTemp
                                ),))
                                : Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.file(
                                    imageFile!,
                                    height: 148,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Text("Indication",),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                         controller:indicationC,
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0.0))
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Indication';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Text("Dosage"),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: dosageC,
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0.0)
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Dosage';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Text("Rx info",),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: rx_infoC,
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Rx info';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Text("Ads Upload Area",style: TextStyle(fontSize: 15)),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      Text("image size : 1360 pixel * 880 pixel(minimum one ad, maximum 3 ad)",style: TextStyle(fontSize: 11)),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {

                                showExitPopup1();
                              },
                              child: Container(
                                color: colors.primary,
                                height: imageFile1 == null ? 50:100,
                                child: Container(

                                  child: imageFile1 == null || imageFile1 == ""
                                      ? const Center(
                                      child: Text("Upload AD1",style: TextStyle(color: colors.whiteTemp),))
                                      : Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.file(
                                          imageFile1!,
                                          height: 100,
                                          width: double.maxFinite,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showExitPopup2();
                              },
                              child: Container(
                                color: colors.primary,
                                height: imageFile2 == null ? 50:100,
                                child: imageFile2 == null || imageFile2 == ""
                                    ? const Center(
                                    child: Text("Upload AD2",style: TextStyle(color: colors.whiteTemp),))
                                    : Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.file(
                                        imageFile2!,
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showExitPopup3();
                              },
                              child: Container(

                                color: colors.primary,
                                height: imageFile3 == null ? 50:100,
                                child: imageFile3 == null || imageFile3 == ""
                                    ? const Center(
                                    child: Text("Upload AD3",style: TextStyle(color: colors.whiteTemp),))
                                    : Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.file(
                                        imageFile3!,
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Text("Mobile No . for brand inquiry and order",style: TextStyle(fontSize: 15)),
                      Text("Insert 2 to 3 mobile number for brand inquiry and order)",style: TextStyle(fontSize: 11)),
                      SizedBox(height: 5,),
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(

                                  color:  colors.primary,
                                  child: TextFormField(
                                    controller: person1C,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 8),
                                        border: InputBorder.none,
                                        hintText: "Person Name 1",hintStyle: TextStyle(color: colors.white70,fontSize: 14,)
                                    ),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please Enter Per';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  color:  colors.black54.withOpacity(0.1),
                                  child: TextFormField(
                                    controller: mobile1C,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding: EdgeInsets.only(left: 8),
                                     border: InputBorder.none,
                                      hintText: "Mobile number",hintStyle: TextStyle(color: colors.black54,fontSize: 14,)
                                    ),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please Enter Per';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  color:  colors.primary,
                                  child: TextFormField(
                                    controller: person2C,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 8),
                                        border: InputBorder.none,
                                        hintText: "Person Name 2",hintStyle: TextStyle(color: colors.white70,fontSize: 14,)
                                    ),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please Enter Per';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  color:  colors.black54.withOpacity(0.1),
                                  child: TextFormField(
                                    controller: mobile2C,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      counterText: "",
                                        contentPadding: EdgeInsets.only(left: 8),
                                        border: InputBorder.none,
                                        hintText: "Mobile number",hintStyle: TextStyle(color: colors.black54,fontSize: 14,)
                                    ),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please Enter Per';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Column(
                              children: [

                                Container(
                                  color:  colors.primary,
                                  child: TextFormField(
                                     controller: person3C,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 8),
                                        border: InputBorder.none,
                                        hintText: "Person Name 3",hintStyle: TextStyle(color: colors.white70,fontSize: 14,)
                                    ),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please Enter Per';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                ),

                                SizedBox(height: 5,),
                                Container(
                                  color:  colors.black54.withOpacity(0.1),
                                  child: TextFormField(
                                    controller: mobile3C,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      counterText: "",
                                        contentPadding: EdgeInsets.only(left: 8),
                                        border: InputBorder.none,
                                        hintText: "Mobile number",hintStyle: TextStyle(color: colors.black54,fontSize: 14,)
                                    ),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please Enter Per';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      InkWell(
                        onTap: (){
                          if(_formKey.currentState!.validate()){
                            addBrandDetailApi();
                          }else{
                            Fluttertoast.showToast(msg: "Please fill all field");
                          }

                          brandListForJson.add({
                            "name":person1C.text,
                            "mobile":mobile1C.text,
                            "name":person2C.text,
                            "mobile":mobile2C.text,
                            "name":person3C.text,
                            "mobile":mobile3C.text,
                          });
                          setState(() {
                            brandListForJson.forEach((element) {print(element);});
                            print('__brandListForJson________${brandListForJson}_________');
                          });
                        },

                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colors.secondary,
                            // border: Border.all(color: colors.primary,width: 4),
                          ),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Submit',style: TextStyle(fontSize: 18),

                              ),
                            ),
                          )

                        ),
                      ),
                      // Container(
                      //     height: 50,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //       color: colors.secondary,
                      //       border: Border.all(color: colors.primary,width: 4),
                      //
                      //
                      //     ),
                      //     child: Center(
                      //       child: RichText(
                      //         text: TextSpan(
                      //           text: 'Subscribe now to upload ',style: TextStyle(fontSize: 15),
                      //           children: const <TextSpan>[
                      //             TextSpan(text: 'BRAND MODEL', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                      //           ],
                      //         ),
                      //       ),
                      //     )
                      //
                      // )
                    ],
                  ),
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }

  List newList = [];
  List brandListForJson = [];
  String? newData ;
  Future<bool> showExitPopup() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, context,1);
                },
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageCmera(ImageSource.gallery,context,1);

                },

                //return true when click on "Yes"
                child: Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }
  Future<bool> showExitPopup1() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, context,2);
                },
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageCmera(ImageSource.gallery,context,2);

                },

                //return true when click on "Yes"
                child: Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }
  Future<bool> showExitPopup2() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, context,3);
                },
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageCmera(ImageSource.gallery,context,3);

                },

                //return true when click on "Yes"
                child: Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }
  Future<bool> showExitPopup3() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, context,4);
                },
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageCmera(ImageSource.gallery,context,4);

                },

                //return true when click on "Yes"
                child: Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }
  Future getImage(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(
      source: source,
    );
    getCropImage(context, i, image);
    Navigator.pop(context);
  }
  Future getImageCmera(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(
      source: source,
    );
    getCropImage(context, i, image);
    Navigator.pop(context);
  }
  void getCropImage(BuildContext context, int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    setState(() {

      if (i == 1) {
        print('_____1_____${i}_________');
        imageFile = File(croppedFile!.path);
       }else if(i == 2){
        print('_____2_____${i}_________');
        imageFile1 = File(croppedFile!.path);
        }else if(i == 3){
        print('_____3_____${i}_________');
          imageFile2 = File(croppedFile!.path);
        }else if(i == 4){
        print('_____4_____${i}_________');
          imageFile3 = File(croppedFile!.path);
        }

      }
    );
  }
  TextEditingController indicationC =  TextEditingController();
  TextEditingController dosageC =  TextEditingController();
  TextEditingController rx_infoC =  TextEditingController();
  TextEditingController person1C =  TextEditingController();
  TextEditingController person2C =  TextEditingController();
  TextEditingController person3C =  TextEditingController();
  TextEditingController mobile1C =  TextEditingController();
  TextEditingController mobile2C =  TextEditingController();
  TextEditingController mobile3C =  TextEditingController();

  addBrandDetailApi() async {
    var headers = {
      'Cookie': 'ci_session=2135ff66fdd844c383bff78b985f0f45377b4718'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addBrandDetailApi}'));
    request.fields.addAll({
      'id': catId.toString(),
      'indication': indicationC.text,
      'dosage': dosageC.text,
      'rx_info': rx_infoC.text,
      'contact_details': brandListForJson.toString()
    });
    print('____cccccc______${request.fields}_________');
    // request.files.add(await http.MultipartFile.fromPath('logo', ''));
    // request.files.add(await http.MultipartFile.fromPath('images[]', ''));
    // request.files.add(await http.MultipartFile.fromPath('images[]', ''));
    // request.files.add(await http.MultipartFile.fromPath('images[]', ''));
    request.files.add(await http.MultipartFile.fromPath('logo', imageFile?.path ?? ""));
    request.files.add(await http.MultipartFile.fromPath('images[]', imageFile1?.path ?? ""));
    request.files.add(await http.MultipartFile.fromPath('images[]', imageFile2?.path ?? ""));
    request.files.add(await http.MultipartFile.fromPath('images[]', imageFile3?.path ?? ""));
    print('__request.files________${request.files}_________');

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
   var result =   await response.stream.bytesToString();
   var finalResult =  jsonDecode(result);
    Fluttertoast.showToast(msg: "${finalResult['message']}");
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
