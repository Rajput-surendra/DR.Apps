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
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/Get_brands_Rx_dosage_model.dart';
import 'genericRx_Dosage_Details_Screen.dart';
import 'generic_brand_details_screen.dart';

class GenericRxDosageScreen extends StatefulWidget {
  GenericRxDosageScreen({Key? key, this.catName,this.id,this.isTrueValue}) : super(key: key);
  String? catName,id;
  bool?isTrueValue;


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
  TextEditingController indicationC =  TextEditingController();
  TextEditingController dosageC =  TextEditingController();
  TextEditingController rx_infoC =  TextEditingController();
  TextEditingController person1C =  TextEditingController();
  TextEditingController person2C =  TextEditingController();
  TextEditingController person3C =  TextEditingController();
  TextEditingController mobile1C =  TextEditingController();
  TextEditingController mobile2C =  TextEditingController();
  TextEditingController mobile3C =  TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  if(widget.isTrueValue ?? false ){
    genericRxDosageDetailsApi();
  }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.secondary,
        leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GenericBrandDetailsScreen()));
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: widget.isTrueValue  ?? false ? const Text("Speciality Brands",style: TextStyle(color: colors.whiteTemp),) :const Text("Generics & Brands",style: TextStyle(color: colors.whiteTemp),),
      ),
      // appBar: customAppBar(context: context, text:"Generic & Brand", isTrue: true, ),
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
                    child: Center(child: Text("${catName}",style: const TextStyle(
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
                        children: const [
                          Text("Logo Upload Area",style: TextStyle(fontSize: 15),),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      const Text("image size : 200 pixel * 100 pixel",style: TextStyle(fontSize: 13)),
                      const SizedBox(height: 5,),
                      InkWell(
                        onTap: () {
                          showExitPopup();
                        },
                        child:

                        Card(
                          child: Container(
                            height: imageFile ==  null ? 50:150 ,
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
                                  child:   Image.file(
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
                      const SizedBox(height: 15,),
                      Row(
                        children: const [
                          Text("Indication",),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        controller:indicationC,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
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
                      const SizedBox(height: 15,),
                      Row(
                        children: const [
                          Text("Dosage"),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        controller: dosageC,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
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
                      const SizedBox(height: 15,),
                      Row(
                        children: const [
                          Text("Rx info",),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      const SizedBox(height: 5,),
                      TextFormField(
                        controller: rx_infoC,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
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
                      const SizedBox(height: 15,),
                      Row(
                        children: const [
                          Text("Ads Upload Area",style: TextStyle(fontSize: 15)),
                          Text("*",style: TextStyle(color: colors.red),)
                        ],
                      ),
                      const Text("image size : 1360 pixel * 880 pixel(minimum one ad, maximum 3 ad)",style: TextStyle(fontSize: 11)),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {

                                showExitPopup1();
                              },
                              child:
                              Container(
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
                          const SizedBox(width: 5,),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showExitPopup2();
                              },
                              child:
                              Container(
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
                          const SizedBox(width: 5,),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showExitPopup3();
                              },
                              child:

                              Container(

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
                      const SizedBox(height: 15,),
                      const Text("Mobile No . for brand inquiry and order",style: TextStyle(fontSize: 15)),
                      const Text("Insert 2 to 3 mobile number for brand inquiry and order)",style: TextStyle(fontSize: 11)),
                      const SizedBox(height: 5,),
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
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 8),
                                        border: InputBorder.none,
                                        hintText: "Person Name 1",hintStyle: TextStyle(color: colors.white70,fontSize: 14,)
                                    ),

                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Container(
                                  color:  colors.black54.withOpacity(0.1),
                                  child: TextFormField(
                                    controller: mobile1C,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        contentPadding: EdgeInsets.only(left: 8),
                                        border: InputBorder.none,
                                        hintText: "Mobile number",hintStyle: TextStyle(color: colors.black54,fontSize: 14,)
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  color:  colors.primary,
                                  child: TextFormField(
                                    controller: person2C,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 8),
                                        border: InputBorder.none,
                                        hintText: "Person Name 2",hintStyle: TextStyle(color: colors.white70,fontSize: 14,)
                                    ),

                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Container(
                                  color:  colors.black54.withOpacity(0.1),
                                  child: TextFormField(
                                    controller: mobile2C,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        contentPadding: EdgeInsets.only(left: 8),
                                        border: InputBorder.none,
                                        hintText: "Mobile number",hintStyle: TextStyle(color: colors.black54,fontSize: 14,)
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Expanded(
                            child: Column(
                              children: [

                                Container(
                                  color:  colors.primary,
                                  child: TextFormField(
                                    controller: person3C,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 8),
                                        border: InputBorder.none,
                                        hintText: "Person Name 3",hintStyle: TextStyle(color: colors.white70,fontSize: 14,)
                                    ),

                                  ),
                                ),

                                const SizedBox(height: 5,),
                                Container(
                                  color:  colors.black54.withOpacity(0.1),
                                  child: TextFormField(
                                    controller: mobile3C,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        contentPadding: EdgeInsets.only(left: 8),
                                        border: InputBorder.none,
                                        hintText: "Mobile number",hintStyle: TextStyle(color: colors.black54,fontSize: 14,)
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      InkWell(
                        onTap: (){
                          if(_formKey.currentState!.validate()){
                            brandListForJson.add(json.encode({
                              "name":person1C.text,
                              "mobile":mobile1C.text,}));

                            brandListForJson.add(json.encode({
                              "name":person2C.text,
                              "mobile":mobile2C.text,}));

                            brandListForJson.add(json.encode({
                              "name":person3C.text,
                              "mobile":mobile3C.text,}));

                            setState(() {
                              brandListForJson.forEach((element) {print(element);});
                            });
                            addBrandDetailApi();
                          }else{
                            Fluttertoast.showToast(msg: "Please fill all field",backgroundColor: colors.secondary);
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: colors.secondary,
                              // border: Border.all(color: colors.primary,width: 4),
                            ),
                            child: islodder  ? const Center(child: CircularProgressIndicator()):Center(
                              child: RichText(
                                text: const TextSpan(
                                  text: 'Submit',style: TextStyle(fontSize: 18),

                                ),
                              ),
                            )

                        ),
                      ),

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
          title: const Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImageLogo(ImageSource.camera, context,);
                },
                child: const Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getGalleryLogo(ImageSource.gallery,context,);
                },
                //return true when click on "Yes"
                child: const Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }
  Future getImageLogo(ImageSource source, BuildContext context, ) async {
    var image = await ImagePicker().pickImage(
      imageQuality: 100,
      source: source,
    );
    getCropImageLogo(context,image);
    Navigator.pop(context);
  }
  Future getGalleryLogo(ImageSource source, BuildContext context, ) async {
    var image = await ImagePicker().pickImage(
      imageQuality: 100,
      source: source,
    );
    getCropImageLogo(context, image);
    Navigator.pop(context);
  }
  Future getCropImageLogo(BuildContext context,  var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: colors.secondary,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false
        ),

      ],
    );
    setState(() {
      imageFile = File(croppedFile!.path);
    }
    );
  }

  Future<bool> showExitPopup1() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, context,1);
                },
                child: const Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageCmera(ImageSource.gallery,context,1);
                },
                //return true when click on "Yes"
                child: const Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }
  Future<bool> showExitPopup2() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Select Image'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, context,2);
                },
                child: const Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageCmera(ImageSource.gallery,context,2);
                },
                child: const Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false;
  }
  Future<bool> showExitPopup3() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, context,3);
                },
                child: const Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageCmera(ImageSource.gallery,context,3);

                },

                //return true when click on "Yes"
                child: const Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }
  Future getImage(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(
      imageQuality: 100,
      source: source,
    );
    getCropImage(context, i, image);
    Navigator.pop(context);
  }
  Future getImageCmera(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(
      imageQuality: 100,
      source: source,
    );
    getCropImage(context, i, image);
    Navigator.pop(context);
  }
  Future getCropImage(BuildContext context, int i, var image) async   {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: colors.secondary,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false
        ),

      ],
    );
    setState(() {

      if (i == 1) {
        imageFile1 = File(croppedFile!.path);
      }else if(i == 2){

        imageFile2 = File(croppedFile!.path);
      }else if(i == 3){

        imageFile3 = File(croppedFile!.path);
      }

    }
    );
  }

  bool islodder = false ;
  addBrandDetailApi() async {
    setState(() {
      islodder = true;
    });
    var headers = {
      'Cookie': 'ci_session=2135ff66fdd844c383bff78b985f0f45377b4718'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addBrandDetailApi}'));
    request.fields.addAll({
      'id': cardId.toString(),
      'indication': indicationC.text,
      'dosage': dosageC.text,
      'rx_info': rx_infoC.text,
      'contact_details': brandListForJson.toString()
    });


    request.files.add(await http.MultipartFile.fromPath('logo', imageFile?.path ?? ""));
    if(imageFile1 != null){
      request.files.add(await http.MultipartFile.fromPath('images[]', imageFile1?.path ?? ""));
    }else if(imageFile2 != null){
      request.files.add(await http.MultipartFile.fromPath('images[]', imageFile2?.path ?? ""));
    }else{
      request.files.add(await http.MultipartFile.fromPath('images[]', imageFile3?.path ?? ""));
    }

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GenericRxDosageDetailsScreen())).then((value) {
        if(value !=null){
          genericRxDosageDetailsApi();
          brandListForJson.clear() ;
        }
      });
      person1C.clear();
      person2C.clear();
      person3C.clear();
      mobile1C.clear();
      mobile2C.clear();
      mobile3C.clear();
      indicationC.clear();
      dosageC.clear();
      rx_infoC.clear();

      brandListForJson.clear();
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

  String ?userId;
  GetBrandsRxDosageModel ? getBrandsRxDosageModel;
  genericRxDosageDetailsApi() async {
    SharedPreferences  preferences = await  SharedPreferences.getInstance();
    userId = preferences.getString("userId");
    var headers = {
      'Cookie': 'ci_session=fd48e2b4f3fe06cb3b11d5a806253ec62f6af057'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getBrandApi}'));
    request.fields.addAll({
      'user_id':  userId.toString(),
      'id':cardId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      getBrandsRxDosageModel =  GetBrandsRxDosageModel.fromJson(jsonDecode(result));
      setState(() {
        indicationC.text = getBrandsRxDosageModel?.data?.first.details?.indication ?? "" ;
        rx_infoC.text = getBrandsRxDosageModel?.data!.first.details?.rxInfo ?? "" ;
        dosageC.text = getBrandsRxDosageModel?.data!.first.details?.dosage ?? "" ;
        if(getBrandsRxDosageModel?.data?[0].contactDetails?.isNotEmpty ?? false || getBrandsRxDosageModel?.data?[0].contactDetails != null )
          for(int i=0; i<getBrandsRxDosageModel!.data![0].contactDetails!.length; i++){
            person1C.text = getBrandsRxDosageModel!.data![0].contactDetails![0].name!;
            person2C.text = getBrandsRxDosageModel!.data![0].contactDetails![1].name!;
            person3C.text = getBrandsRxDosageModel!.data![0].contactDetails![2].name!;
            mobile1C.text = getBrandsRxDosageModel!.data![0].contactDetails![0].mobile!;
            mobile2C.text = getBrandsRxDosageModel!.data![0].contactDetails![1].mobile!;
            mobile3C.text = getBrandsRxDosageModel!.data![0].contactDetails![2].mobile!;
          }
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
}