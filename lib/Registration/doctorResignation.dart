import 'dart:convert';
import 'dart:io';

import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/New_model/get_pharma_category.dart';
import 'package:doctorapp/New_model/registration_model2.dart';
import 'package:doctorapp/Registration/hospital.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../New_model/GetCompanyNewModel.dart';
import '../New_model/GetSelectCatModel.dart';

import 'package:http/http.dart' as http;

import '../New_model/Get_company_model.dart';
import '../New_model/get_cities_model.dart';
import '../New_model/get_place_model.dart';
import '../New_model/get_state_model.dart';
import 'drverification.dart';

class DoctorResignation extends StatefulWidget {

  final int? role ;
  String? id;

  DoctorResignation({Key? key, this.role,this.id,}) : super(key: key);

  @override
  State<DoctorResignation> createState() => _DoctorResignationState();
}
class _DoctorResignationState extends State<DoctorResignation> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phonelController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController CpassController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController clinikaddressController = TextEditingController();
  TextEditingController docdegreeController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController experienceC = TextEditingController();
  SpeciplyData? catDrop;
  final FocusNode unitCodeCtrlFocusNode = FocusNode();

  String? selectedState;
  String? selectedCity;
  String? selectedPlace;

  Future<void> onTapCall1() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('selectedState',selectedState!);

    print('Selected Statelllllllllllll${selectedState}');


  }
  Future<void> onTapCall2() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('selectedCity',selectedCity!);
    print('Selected Statelllllllllllll${selectedCity}');

  }
  Future<void> onTapCall3() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('selectedPlace',selectedPlace!);
    print('Selected Statelllllllllllll${selectedPlace}');


  }

  List <GetStateData> getStateData = [];
  String? stateId;
  String?cityId;
  String?placeId;
  List <GetCitiesDataNew>getCitiesData = [];
  List <GetPlacedData>getPlacedData = [];
  int? selectedSateIndex;

  bool isDoctor = false;
  File? imageFile;
  File? newImageFile;
  String? SelectedPharma;
  String? SelectedGender;

  int _value = 1;
  bool isMobile = false;
  bool isSendOtp = false;
  bool isLoading = false;
  String gender =  "Male";

  int selectedIndex = 0;
  int selectedGender = 0;
  String finalString ='';

  int category  = 2;
  var results ;

  var items = [
    'PMT Team',
    'Marketing Team',
  ];
  String? dropdownDoctor ;
  var items2 = [
   'Dr.',
  'Prof.Dr.'
  ];
  String? dropdownGender ;
  var items1 = [
    'Mr.',
    'Mrs.',
    'Ms.',
  ];
  String? dropdownTeam ;
  var items3 = [
    'PMT team',
    'Marketing team',
  ];
 List<SpeciplyData> speciplyData =  [];
   String? selectedQualification;
  GetSelectCatModel? selectCatModel;
  bool show = false;


  getCatApi() async {
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
    print("this is a Response==========>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = GetSelectCatModel.fromJson(jsonDecode(result));
      print("this is =============>${finalResult}");
      setState(() {
        selectCatModel = finalResult;
        speciplyData =  finalResult.data ?? [];
      });

    }

    else {
      print(response.reasonPhrase);
    }
  }

  List<CompanyDataList> companyList= [];
  GetCompanyNewModel? getCompanyNewModel;
  getCompanyName() async {



    var headers = {
      'Cookie': 'ci_session=e5dbfebfc51701fd8aba3e57be6c399b3a13750d'
    };
    var request = http.Request('GET', Uri.parse('${ApiService.getCompaniesDropApi}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =    await response.stream.bytesToString();
      var finalResult  = GetCompanyNewModel.fromJson(json.decode(result));
      print('____sdsdfsdd______${finalResult}_________');
      setState(() {
        getCompanyNewModel = finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  GetStateResponseModel?getStateResponseModel;
  getStateApi() async {
     SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.setString('specialityId', widget.id ?? '');

    var headers = {
      'Cookie': 'ci_session=5231a97bed6f10b951ef18f96630501acb732acf'
    };
    var request = http.Request('POST', Uri.parse('${ApiService.getStateApi}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =await response.stream.bytesToString();
      var finalResult = GetStateResponseModel.fromJson(jsonDecode(result));
      print("+}++++++++++++++++++++++${finalResult}");
      setState(() {
       getStateResponseModel=  finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
  GetCitiesResponseModel?getCitiesResponseModel;
  getCityApi(String id) async {
    var headers = {
      'Cookie': 'ci_session=5f506e1040db4500177d9f8af1642e1974e5bcdb'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getCityApi}'));
    request.fields.addAll({
      'state_id': id.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =await response.stream.bytesToString();
      var finalResult = GetCitiesResponseModel.fromJson(jsonDecode(result));
      setState(() {
        getCitiesResponseModel = finalResult;
      });

    }
    else {
      print(response.reasonPhrase);
    }
  }
  GetPlaceResponseModel?getPlaceResponseModel;
  getPlaceApi(String id) async {
    var headers = {
      'Cookie': 'ci_session=5f506e1040db4500177d9f8af1642e1974e5bcdb'
    };
    var request = http.MultipartRequest('POST', Uri.parse("${ApiService.getPlaceApi}"));
    request.fields.addAll({
      'city_id': id.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =await response.stream.bytesToString();
      var finalResult = GetPlaceResponseModel.fromJson(jsonDecode(result));
      setState(() {
        getPlaceResponseModel = finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }



@override
  void initState() {
    // TODO: implement initState
     getStateApi();
     getCatApi();
     getCompanyName();
    super.initState();

  }

  final ImagePicker _picker = ImagePicker();

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
                  // _getFromCamera();
                },
                //return false when click on "NO"
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
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
                  // _getFromCamera1();
                },
                //return false when click on "NO"
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                },
                //return true when click on "Yes"
                child: Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }

  void requestPermission(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              InkWell(
                onTap: () async {
                  // getFromGallery(i);
                  getImageGallery(ImgSource.Gallery,context,i);
                },
                child: Container(
                  child: ListTile(
                      title:  Text("Gallery"),
                      leading: Icon(
                        Icons.image,
                        color: colors.primary,
                      )),
                ),
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  getImage(ImgSource.Camera, context, i);
                },
                child: Container(
                  child: ListTile(
                      title:  Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: colors.primary,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );

  }

  Future<void> getFromGallery(int i) async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        if(i==1){
          imageFile = File(result.files.single.path.toString());
        }
      });
      Navigator.pop(context);
    } else {
      // User canceled the picker
    }
  }

  Future getImage(ImgSource source, BuildContext context, int i) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: const Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    getCropImage(context, i, image);
    Navigator.pop(context);
  }
  Future getImageGallery(ImgSource source, BuildContext context, int i) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: const Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
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
        imageFile = File(croppedFile!.path);
      }

    });
    Navigator.pop(context);
  }

  RegistrationModel? detailsData;
  registration() async {
    isLoading ==  true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('otp', "otp");
    if(imageFile ==null ){
      Fluttertoast.showToast(msg: 'Please add profile photo');
    }
    else {
      String? token;
      try {
        token = await FirebaseMessaging.instance.getToken();
      } on FirebaseException {
      }

      // if (false) {
      //   // Fluttertoast.showToast(msg: 'Please select category');
      // } else {
      //   print("this is user registration ");
        var headers = {
          'Cookie': 'ci_session=7484a255faa8a60919687a35cf9c56e5c55326d2'
        };
        var request = http.MultipartRequest(
            'POST', Uri.parse('${ApiService.userRegister}'));
        request.fields.addAll({
          'email': emailController.text,
          'mobile': mobileController.text,
          'username': nameController.text,
          'gender': gender.toString(),
          'doc_degree': docdegreeController.text,
          'address': "",
          'c_address': clinikaddressController.text,
          'cat_type': widget.role == 2 ?SelectedPharma.toString():"",
          'category_id': widget.role == 2 ?catDrop!.id.toString():widget.id.toString(),
          'designation_id':widget.role == 2 ? results.id.toString():"",
          'password': passController.text,
          'roll': widget.role.toString(),
          'confirm_password': CpassController.text,
          'fcm_id': token ?? '',
          'city': cityController.text,
          'title': widget.role == 2 ? dropdownGender.toString():dropdownDoctor.toString(),
          "company_name": show ? companyController.text.toString() : selectedQualification.toString(),
          "company_division":widget.role == 2? catDrop!.id.toString():"",
          "state_id":widget.role == 1 ?'$stateId':"",
          "city_id": widget.role == 1 ? "$cityId":"",
          "area_id":widget.role == 1 ? "$placeId":"",
          "experience": experienceC.text,


        });

        if (imageFile != null) {
          request.files.add(await http.MultipartFile.fromPath(
              'image', imageFile?.path ?? ''));
        }
        // print(
        //     "this is request ===>>>>surendra ${request.fields}   ${request.files.toString()}");
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        print("${request.fields}");
      print("${request.url}");
      print("${request.files.first}");
        if (response.statusCode == 200) {
          final reslut = await response.stream.bytesToString();
          var finalResult = jsonDecode(jsonEncode(reslut));
          print("resultttttttttttttt${reslut}");
          String?  otp = finalResult['data']['otp'];
          String?  mobile = finalResult['data']['mobile'];
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('msg',finalResult['data']['message'] );
          Fluttertoast.showToast(msg: finalResult['message']);
          if (!(detailsData?.user ?? false)) {
            Fluttertoast.showToast(msg: finalResult['message']);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NewCerification (otp: otp.toString(),mobile:mobile)));
          }
          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          print(response.reasonPhrase);
        }
      //}
    }
  }
  void _showMultiSelect(int category) async {
    results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return MultiSelect(
            category: category,
          );
        });
      },
    );
    setState(() {});
  }
  bool _isObscure = true;
  bool _isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
            text:
            "${widget.role == 1 ? "Doctor" : "Pharma(PMT Team & Marketing)"}",
            isTrue: true,
            context: context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.role == 2 ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 5, top: 12),
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          decoration:
                          BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all( color: colors.black54),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              dropdownMaxHeight: 150,
                              hint: const Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text("Select Pharma Category",
                                  style: TextStyle(
                                      color: colors.black54,fontWeight: FontWeight.normal
                                  ),),
                              ),
                              // dropdownColor: colors.primary,
                              value: SelectedPharma,
                              icon:  const Padding(
                                padding: EdgeInsets.only(bottom: 30),
                                child: Icon(Icons.keyboard_arrow_down_rounded,  color: colors.secondary,size: 30,),
                              ),
                              // elevation: 16,
                              style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                              underline: Padding(
                                padding: const EdgeInsets.only(left: 0,right: 0),
                                child: Container(
                                  // height: 2,
                                  color:  colors.whiteTemp,
                                ),
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  SelectedPharma = value!;
                                  selectedIndex = items.indexOf(value);
                                  if (selectedIndex == 0) {
                                    category = 2;
                                  } else {
                                    category = 3;
                                  }
                                  // indexSectet = items.indexOf(value);
                                  // indexSectet++;
                                }
                                );
                              },

                              items: items
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child:
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(value,style: const TextStyle(color: colors.black54,fontWeight: FontWeight.normal),),
                                      ),
                                      const Divider(
                                        thickness: 0.2,
                                        color: colors.black54,
                                      )
                                    ],
                                  ),
                                );

                              }).toList(),

                            ),

                          )

                      ),

                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 15),
                      //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: colors.black54)),
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton(
                      //       hint: const Text("Select Pharma Category", style: TextStyle(color: colors.black54),),
                      //       isExpanded: true,
                      //       elevation: 0,
                      //       value: SelectedPharma,
                      //       icon: const Icon(
                      //         Icons.keyboard_arrow_down,
                      //         size: 40,
                      //         color: colors.primary,
                      //       ),
                      //       items: items.map((String items) {
                      //         return DropdownMenuItem(
                      //             value: items,
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Text(
                      //                 items,
                      //                 style: TextStyle(color: colors.primary),
                      //               ),
                      //             ));
                      //       }).toList(),
                      //       onChanged: (String? newValue) {
                      //         setState(() {
                      //           SelectedPharma = newValue!;
                      //
                      //           selectedIndex = items.indexOf(newValue);
                      //           if (selectedIndex == 0) {
                      //             category = 2;
                      //           } else {
                      //             category = 3;
                      //           }
                      //
                      //           /*selectedIndex++;
                      //     print("tttttt--------->${selectedIndex}");*/
                      //         });
                      //       },
                      //     ),
                      //   ),),
                      const SizedBox(height: 10,),
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: const [
                              Text(
                                "Designation",
                                style: TextStyle(
                                    color: colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                              ),
                            ],
                          )

                      ),
                      select(),
                    ],
                  ) : SizedBox.shrink(),
                  const SizedBox(
                    height: 10,
                  ),
                  widget.role == 2 ?Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: const [
                          Text(
                            "Title",
                            style: TextStyle(
                                color: colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )

                  ):SizedBox(),
                  widget.role == 2?    Container(
                      padding: EdgeInsets.only(right: 5, top: 12),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all( color: colors.black54),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          dropdownMaxHeight: 150,
                          hint: const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Text("Select Title",
                              style: TextStyle(
                                  color: colors.black54,fontWeight: FontWeight.normal
                              ),),
                          ),
                          // dropdownColor: colors.primary,
                          value: dropdownGender,
                          icon:  const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Icon(Icons.keyboard_arrow_down_rounded,  color: colors.secondary,size: 30,),
                          ),
                          // elevation: 16,
                          style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                          underline: Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Container(
                              // height: 2,
                              color:  colors.whiteTemp,
                            ),
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownGender = value!;

                            });
                          },

                          items: items1
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child:
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(value,style: const TextStyle(color: colors.black54,fontWeight: FontWeight.normal),),
                                  ),
                                  const Divider(
                                    thickness: 0.2,
                                    color: colors.black54,
                                  )
                                ],
                              ),
                            );

                          }).toList(),

                        ),

                      )

                  )

                      : SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  widget.role == 1 ?Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: const [
                          Text(
                            "Title",
                            style: TextStyle(
                                color: colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )

                  ):SizedBox(),
                  widget.role == 1 ?    Container(
                      padding: EdgeInsets.only(right: 5, top: 9),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all( color: colors.black54),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          hint: const Padding(
                            padding: EdgeInsets.only(top: 0,bottom: 10),
                            child: Text("Select Title",
                              style: TextStyle(
                                  color: colors.black54,fontWeight: FontWeight.normal
                              ),),
                          ),
                          // dropdownColor: colors.primary,
                          value: dropdownDoctor,
                          icon:  const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Icon(Icons.keyboard_arrow_down_rounded,  color: colors.secondary,size: 30,),
                          ),
                          // elevation: 16,
                          style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                          underline: Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Container(
                              // height: 2,
                              color:  colors.whiteTemp,
                            ),
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownDoctor = value!;
                              // indexSectet = items.indexOf(value);
                              // indexSectet++;
                            });
                          },

                          items: items2
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(value,style: TextStyle(color: colors.black54,fontWeight: FontWeight.normal),),
                                  ),
                                  const Divider(
                                    thickness: 0.2,
                                    color: colors.black54,
                                  )
                                ],
                              ),
                            );

                          }).toList(),

                        ),

                      )

                  ):SizedBox(),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child:Row(
                        children: const [
                          Text(
                            "Name",
                            style: TextStyle(
                                color: colors.black54, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )


                  ),
                  TextFormField(
                    style: TextStyle(color: colors.black54),
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixText: "",
                        hintText: '',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, color: colors.black54,fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "name is required";
                      }
                    },
                  ),
                  SizedBox(height: 15,),
               widget.role == 2?  Column(
                   children: [
                     Row(
                       children: const [
                         Padding(
                           padding: EdgeInsets.only(left: 5),
                           child: Text("Following Doctor's Speciality",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold)),
                         ),
                         Text("*",style: TextStyle(color: colors.red),),
                       ],
                     ),
                     SizedBox(height: 5,),
                     widget.role == 2?

                     Container(
                         padding: EdgeInsets.only(right: 5, top: 9),
                         width: MediaQuery.of(context).size.width,
                         height: 55,
                         decoration:
                         BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border: Border.all( color: colors.black54,),
                         ),
                         child: DropdownButtonHideUnderline(
                           child: DropdownButton2<SpeciplyData>(
                             
                             hint: const Padding(
                               padding: EdgeInsets.only(bottom: 15),
                               child: Text("Select Doctor's Speciality",
                                 style: TextStyle(
                                     color: colors.black54,fontWeight: FontWeight.normal
                                 ),),
                             ),
                             // dropdownColor: colors.primary,
                             value: catDrop,
                             icon:  const Padding(
                               padding: EdgeInsets.only(bottom: 30),
                               child: Icon(Icons.keyboard_arrow_down_rounded,  color: colors.secondary,size: 30,),
                             ),
                             // elevation: 16,
                             style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                             underline: Padding(
                               padding: const EdgeInsets.only(left: 0,right: 0),
                               child: Container(
                                 // height: 2,
                                 color:  colors.whiteTemp,
                               ),
                             ),
                             onChanged: (SpeciplyData? newValue) {
                               // This is called when the user selects an item.
                               setState(() {
                                 catDrop = newValue!;
                                 // indexSectet = items.indexOf(value);
                                 // indexSectet++;
                               });
                             },

                             items:speciplyData.map((SpeciplyData items) {
                               return DropdownMenuItem(
                                 value: items,
                                 child:   Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(6.0),
                                       child: Text(items.name??'',style: TextStyle(color:colors.black54,fontWeight: FontWeight.normal),),
                                     ),
                                     const Divider(
                                       thickness: 0.2,
                                       color: colors.black54,
                                     )
                                   ],
                                 ),

                               );
                             })
                                 .toList(),

                           ),

                         )

                     ):

                     SizedBox(),
                     const SizedBox(
                       height: 10,
                     ),
                     Padding(
                         padding: EdgeInsets.all(5.0),
                         child: Row(
                           children: const [
                             Text(
                               "Company Name",
                               style: TextStyle(
                                   color: colors.black54,
                                   fontWeight: FontWeight.bold),
                             ),
                             SizedBox(height: 2,),
                             Text(
                               "*",
                               style: TextStyle(
                                   color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                             ),
                           ],
                         )

                     ),
                     getCompanyNewModel == null ? Center(child: CircularProgressIndicator(),) :
                     Container(
                         padding: EdgeInsets.only(right: 5, top: 9),
                         width: MediaQuery.of(context).size.width,
                         height: 50,
                         decoration:
                         BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           border: Border.all( color: colors.black54),
                         ),
                         child: DropdownButtonHideUnderline(
                           child: DropdownButton2<String>(

                             hint: const Padding(
                               padding: EdgeInsets.only(bottom: 15),
                               child: Text("Select Company Name",
                                 style: TextStyle(
                                     color: colors.black54,fontWeight: FontWeight.normal
                                 ),),
                             ),
                             // dropdownColor: colors.primary,
                             value: selectedQualification,
                             icon:  const Padding(
                               padding: EdgeInsets.only(),
                               child: Icon(Icons.keyboard_arrow_down_rounded,  color: colors.secondary,size: 30,),
                             ),
                             // elevation: 16,
                             style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                             underline: Padding(
                               padding: const EdgeInsets.only(left: 0,right: 0),
                               child: Container(
                                 // height: 2,
                                 color:  colors.whiteTemp,
                               ),
                             ),
                             onChanged: (String? value) {
                               // This is called when the user selects an item.
                               setState(() {
                                 selectedQualification = value!;
                               });
                               if(selectedQualification == "Other"){
                                 setState(() {
                                   show = true;
                                 });
                                 // unitCodeCtrlFocusNode.requestFocus();
                               }else{
                                 setState(() {
                                   show = false;
                                 });
                               }
                             },

                             items: getCompanyNewModel!.data!.map((items) {
                               return DropdownMenuItem(
                                 value: items.name.toString(),
                                 child:  Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.only(top: 5),
                                       child: Container(
                                           width: 240,
                                           child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: TextStyle(color:colors.black54,fontWeight: FontWeight.normal),)),
                                     ),
                                     const Divider(
                                       thickness: 0.2,
                                       color: colors.black54,
                                     )
                                   ],
                                 ),

                               );
                             })
                                 .toList(),

                           ),

                         )

                     ),

                     const SizedBox(
                       height: 10,
                     ),
                     show?
                     TextFormField(
                       style: TextStyle(color: colors.black54),
                       // focusNode: unitCodeCtrlFocusNode,
                       controller: companyController,
                       keyboardType: TextInputType.text,
                       decoration: InputDecoration(
                           hintText: 'Company Name',
                           hintStyle: const TextStyle(
                               fontSize: 15.0, color: colors.black54),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10)),
                           contentPadding: EdgeInsets.only(left: 10, top: 10)),
                       validator: (v) {
                         if (v!.isEmpty) {
                           return " Company name is required";
                         }
                       },
                     )
                     : const SizedBox.shrink(),
                     Padding(
                         padding: EdgeInsets.all(5.0),
                         child:Row(
                           children: const [
                             Text(
                               "City Name",
                               style: TextStyle(
                                   color: colors.black54, fontWeight: FontWeight.bold),
                             ),
                             Text(
                               "*",
                               style: TextStyle(
                                   color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                             ),
                           ],
                         )


                     ),
                     TextFormField(
                       style: TextStyle(color: colors.black54),
                       controller: cityController,
                       keyboardType: TextInputType.text,
                       decoration: InputDecoration(
                           hintText: '',
                           hintStyle: const TextStyle(
                               fontSize: 15.0, color: colors.secondary),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10)),
                           contentPadding: EdgeInsets.only(left: 10, top: 10)),
                       validator: (v) {
                         if (v!.isEmpty) {
                           return " City name is required";
                         }
                       },
                     ),
                   ],
                 ):SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:Row(
                        children: const [
                         Text(
                            "Mobile No",
                            style: TextStyle(
                                color: colors.black54, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )
                  ),
                  TextFormField(
                    style: TextStyle(color: colors.black54),
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                        counterText: "",
                        hintText: '',
                        hintStyle:
                        TextStyle(fontSize: 15.0, color: colors.secondary),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.length != 10) {
                        return "mobile number is required";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: const [
                          Text(
                            "Email Id",
                            style: TextStyle(
                                color: colors.black54, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                          ),

                        ],
                      )

                  ),
                  TextFormField(
                    style: TextStyle(color: colors.black54),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: '',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, color: colors.secondary),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Email is required";
                      }
                      if (!v.contains("@")) {
                        return "Enter Valid Email Id";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "Select Gender",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            fillColor: MaterialStateColor.resolveWith(
                                    (states) =>  colors.secondary),
                            activeColor:  colors.secondary,
                            groupValue: _value,
                            onChanged: (int? value) {
                              setState(() {
                                _value = value!;
                                gender = "Male";
                                //isMobile = false;
                              });
                            },
                          ),
                          const Text(
                            "Male",
                            style: TextStyle(
                                color: colors.black54, fontSize: 15),
                          ),
                          SizedBox(height: 5,),
                          Radio(
                              value: 2,
                              fillColor: MaterialStateColor.resolveWith(
                                      (states) => colors.secondary),
                              activeColor:   colors.secondary,
                              groupValue: _value,
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value!;
                                  gender = "Female";
                                  // isMobile = true;
                                });
                              }),
                          // SizedBox(width: 10.0,),
                          const Text(
                            "Female",
                            style: TextStyle(
                                color:  colors.black54, fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Password",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3,left: 2),
                          child: Text(
                            "*",
                            style: TextStyle(
                                color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: colors.black54),
                    obscureText: _isObscurePassword,
                    controller: passController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: '',
                        hintStyle:
                        TextStyle(fontSize: 15.0, color: colors.secondary),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10),
                        suffixIcon: IconButton(
                            icon: Icon(
                              _isObscurePassword ? Icons.visibility : Icons.visibility_off,color: colors.secondary,),
                            onPressed: () {
                              setState(() {
                                _isObscurePassword = !_isObscurePassword;
                              });
                            })
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "password is required";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: const [
                          Text(
                            "Confirm password",
                            style: TextStyle(
                                color: colors.black54, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )

                  ),
                  TextFormField(
                    style: TextStyle(color: colors.black54),
                    obscureText: _isObscure,
                    controller: CpassController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: '',
                        hintStyle:
                        TextStyle(fontSize: 15.0, color: colors.secondary),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10),
                        suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off,color: colors.secondary,),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })
                    ),
                    validator: (v) {
                      if (v!.isEmpty || CpassController.text != passController.text) {
                        return "password does not match";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  widget.role == 1
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "City Name",
                          style: TextStyle(
                              color: colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: TextStyle(color: colors.black54),
                        controller: cityController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: '',
                            hintStyle: const TextStyle(
                                fontSize: 15.0, color: colors.secondary),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding:
                            const EdgeInsets.only(left: 10, top: 10)),
                        validator: (v) {
                          if (v!.isEmpty && widget.role == 1) {
                            return "City Name is required";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:Row(
                            children: const [
                              Text(
                                "Select State",
                                style: TextStyle(
                                    color: colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                              ),
                            ],
                          )

                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      getStateResponseModel== null? Center(child: CircularProgressIndicator()):Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: colors.black54)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            hint: const Text('State',
                              style: TextStyle(
                                  color: colors.black54,fontWeight: FontWeight.w500,fontSize:18
                              ),),
                            // dropdownColor: colors.primary,
                            value: selectedState,
                            icon:  const Padding(
                              padding: EdgeInsets.only(left:10.0),
                              child: Icon(Icons.keyboard_arrow_down_rounded,  color:colors.secondary,size: 30,),
                            ),
                            // elevation: 16,
                            style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                            underline: Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0),
                              child: Container(
                                // height: 2,
                                color:  colors.whiteTemp,
                              ),
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                selectedState = value!;
                                print('__________${getStateResponseModel!.data!.first.name}_________');
                                getStateResponseModel!.data!.forEach((element) {
                                  if(element.name == value){
                                    selectedSateIndex = getStateResponseModel!.data!.indexOf(element);
                                    stateId = element.id;
                                    selectedCity = null;
                                    selectedPlace = null;
                                    getCityApi(stateId!);
                                    onTapCall1();

                                    print('_____Surendra_____${stateId}_________');
                                    //getStateApi();
                                  }
                                });
                              });
                            },
                            items: getStateResponseModel!.data!.map((items) {
                              return DropdownMenuItem(
                                value: items.name.toString(),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                          width: MediaQuery.of(context).size.width/1.42,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:colors.black54),),
                                          )),
                                    ),
                                    const Divider(
                                      thickness: 0.2,
                                      color: colors.black54,
                                    ),

                                  ],
                                ),
                              );
                            })
                                .toList(),


                          ),

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:Row(
                            children: const [
                              Text(
                                "Select City",
                                style: TextStyle(
                                    color: colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                              ),
                            ],
                          )

                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // getCitiesResponseModel== null? Center(child: CircularProgressIndicator()):
                      Container(
                        width: MediaQuery.of(context).size.width/1.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: colors.black54)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            hint: const Text('City',
                              style: TextStyle(
                                  color: colors.black54,fontWeight: FontWeight.w500,fontSize:15
                              ),),
                            // dropdownColor: colors.primary,
                            value: selectedCity,
                            icon:  const Padding(
                              padding: EdgeInsets.only(left:10.0),
                              child: Icon(Icons.keyboard_arrow_down_rounded,  color:colors.secondary,size: 30,),
                            ),
                            // elevation: 16,
                            style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                            underline: Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0),
                              child: Container(
                                // height: 2,
                                color:  colors.whiteTemp,
                              ),
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                selectedCity = value!;
                                print('__________${selectedCity}_________');
                                getCitiesResponseModel!.data!.forEach((element) {
                                  if(element.name == value){
                                    selectedSateIndex = getCitiesResponseModel!.data!.indexOf(element);
                                    cityId = element.id;
                                    selectedPlace = null;
                                    getPlaceApi(cityId!);
                                    onTapCall2();
                                    setState(() {

                                    });
                                  }
                                });
                              });
                            },
                            items: getCitiesResponseModel?.data?.map((items) {
                              return DropdownMenuItem(
                                value: items.name.toString(),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                          width: MediaQuery.of(context).size.width/1.42,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:colors.black54),),
                                          )),
                                    ),
                                    const Divider(
                                      thickness: 0.2,
                                      color: colors.black54,
                                    ),

                                  ],
                                ),
                              );
                            })
                                .toList(),


                          ),

                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:Row(
                            children: const [
                              Text(
                                "Select Place",
                                style: TextStyle(
                                    color: colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                              ),
                            ],
                          )

                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // getCitiesResponseModel== null? Center(child: CircularProgressIndicator()):
                      Container(
                        width: MediaQuery.of(context).size.width/1.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: colors.black54)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            hint: const Text('Place',
                              style: TextStyle(
                                  color: colors.black54,fontWeight: FontWeight.w500,fontSize:18
                              ),),
                            // dropdownColor: colors.primary,
                            value: selectedPlace,
                            icon:  const Padding(
                              padding: EdgeInsets.only(left:10.0),
                              child: Icon(Icons.keyboard_arrow_down_rounded,  color:colors.secondary,size: 30,),
                            ),
                            // elevation: 16,
                            style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                            underline: Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0),
                              child: Container(
                                // height: 2,
                                color:  colors.whiteTemp,
                              ),
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                selectedPlace = value!;
                                getPlaceResponseModel!.data!.forEach((element) {
                                  if(element.name == value){
                                    selectedSateIndex = getPlaceResponseModel!.data!.indexOf(element);
                                    placeId = element.id;
                                    onTapCall3();
                                    //selectedCity = null;
                                    //selectedPlace = null;

                                    print('_____Surdfdgdgendra_____${placeId}_________');
                                    //getStateApi();
                                  }
                                });
                              });
                            },
                            items: getPlaceResponseModel?.data?.map((items) {
                              return DropdownMenuItem(
                                value: items.name.toString(),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                          width: MediaQuery.of(context).size.width/1.42,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:colors.black54),),
                                          )),
                                    ),
                                    const Divider(
                                      thickness: 0.2,
                                      color: colors.black54,
                                    ),

                                  ],
                                ),
                              );
                            })
                                .toList(),


                          ),

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:Row(
                            children: const [
                              Text(
                                "Dr.Degree",
                                style: TextStyle(
                                    color: colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "*",
                                style: TextStyle(
                                    color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                              ),
                            ],
                          )

                      ),
                      const SizedBox(
                        height: 5,
                      ),


                      TextFormField(
                        style: TextStyle(color: colors.black54),
                        controller: docdegreeController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: '',
                            hintStyle: const TextStyle(
                                fontSize: 15.0, color: colors.secondary),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding:
                            EdgeInsets.only(left: 10, top: 10)),
                        validator: (v) {
                          if (v!.isEmpty && widget.role == 1) {
                            return "degree is required";
                          }
                        },
                      ),
                      SizedBox(height: 10,),
                      const Text("Experience",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                      SizedBox(height:5,),
                      Container(
                        height: 50,
                        child: TextFormField(
                            controller: experienceC,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 2,left: 8),
                                counterText: "",
                                hintText:"Experience",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                    ],
                  )
                      : SizedBox.shrink(),
                  // Padding(
                  //     padding: const EdgeInsets.all(5.0),
                  //     child: Row(
                  //       children: const [
                  //         Text(
                  //           "Registration Card",
                  //           style: TextStyle(
                  //               color: colors.black54,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //         Text(
                  //           "*",
                  //           style: TextStyle(
                  //               color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                  //         ),
                  //       ],
                  //     )
                  //
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     showExitPopup();
                  //   },
                  //   child: SizedBox(
                  //     // height: MediaQuery.of(context).size.height/6,
                  //     height: imageFile == null ? 50:155,
                  //     child: DottedBorder(
                  //       borderType: BorderType.RRect,
                  //       radius: Radius.circular(5),
                  //       dashPattern: [5, 5],
                  //       color: Colors.grey,
                  //       strokeWidth: 2,
                  //       child: imageFile == null || imageFile == ""
                  //           ? Center(
                  //           child: Icon(
                  //             Icons.drive_folder_upload_outlined,
                  //             color: Colors.grey,
                  //             size: 30,
                  //           ))
                  //           : Column(
                  //         children: [
                  //           ClipRRect(
                  //             borderRadius: BorderRadius.circular(10),
                  //             child: Image.file(
                  //               imageFile!,
                  //               height: 150,
                  //               width: double.infinity,
                  //               fit: BoxFit.fill,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: const [
                          Text(
                            "Profile Image",
                            style: TextStyle(
                                color: colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )


                  ),

                  InkWell(
                    onTap: () {
                      requestPermission(context, 1);
                    },
                    child: Container(
                      height: imageFile == null ? 50:155,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(5),
                        dashPattern: [5, 5],
                        color: Colors.grey,
                        strokeWidth: 2,
                        child: imageFile == null || imageFile == ""
                            ? const Center(
                            child: Icon(
                              Icons.drive_folder_upload_outlined,
                              color: Colors.grey,
                              size: 30,
                            ))
                            : Column(
                          children: [
                            Image.file(
                              imageFile!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Center(
                    child: Btn(
                        height: 50,
                        width: 320,
                        title: isLoading ? "Please wait......" :  widget.role == 1 ? "Next" : 'Submit',
                        color: colors.secondary,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            print("hhhhhhhhhhhhhhhhhhhhhh${widget.role}");
                            if(widget.role == 1){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Hospital(title: dropdownDoctor ?? "",name:nameController.text
                                    ,mobile: mobileController.text,email: emailController.text,cityID:cityId ?? "",cityName: cityController.text,
                                  cPass: CpassController.text,degree: docdegreeController.text,gender: gender,pass: passController.text,placeID: placeId ?? "",
                                  profileImages: imageFile!.path,roll: widget.role.toString(),stateID:stateId ?? "",categoryId:widget.id.toString(),experience: experienceC.text,)));
                            }else {
                              print("surennnnnnnnnnnnnnnn");
                             registration();

                            }
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) =>HomeScreen()));
                          } else {

                            const snackBar = SnackBar(
                              content: Text('All Fields are required!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
  Widget select() {
    return InkWell(
      onTap:SelectedPharma == null ? (){
        Fluttertoast.showToast(msg: 'Please Select Pharma Category First',backgroundColor: colors.secondary);
      }: () {
        _showMultiSelect(category);
      },
      child: Container(
        height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: colors.white10,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black.withOpacity(0.7))),
          child: results == null
              ? const Padding(
            padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
            child: Text(
              'Select Designation',
              style: TextStyle(
                fontSize: 16,
                color: colors.black54,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
              :  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(results.name??'',style: TextStyle(color:colors.black54),),
              ),

            ],
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(top: 15,left: 5),
          //           child: Text(
          //             "${results.name}",
          //             style: TextStyle(color: colors.primary),
          //
          //             //item.name
          //           ),
          //         ),
          //         Divider(
          //           thickness: 1,
          //           color: colors.black54,
          //         )
          //
          //       ],
          //     )
      ),
    );
  }
}
class MultiSelect extends StatefulWidget {
  int category;
  MultiSelect({Key? key, required this.category}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}
class _MultiSelectState extends State<MultiSelect> {
  List<PharmaCategory> pharmaCategoryList = [];
  void _cancel() {
    Navigator.pop(context);
  }

  getPharmaCategory(int category) async {
    var headers = {
      'Cookie': 'ci_session=7484a255faa8a60919687a35cf9c56e5c55326d2'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getPharmaCategory}'));
    request.fields.addAll({
      'cat_type': category.toString(),
    });
    print("request________${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print('${response.statusCode}_____________statuscode');
    if (response.statusCode == 200) {
      print('_____________');
      var finalResult = await response.stream.bytesToString();
      final jsonResponse =
          GetPharmaCategory.fromJson(json.decode(finalResult)).data;
      //Fluttertoast.showToast(msg: "${jsonResponse}");
      setState(() {
        pharmaCategoryList = jsonResponse ?? [];
      });
    } else {
      //Fluttertoast.showToast(msg: "${detailsData?.message}");
      // Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
      print(response.reasonPhrase);
    }
  }
  bool isChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPharmaCategory(widget.category);
  }
  var selectedItems;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Select Multiple Categories',style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 18),),
        content: SingleChildScrollView(
          child: ListBody(
            children: pharmaCategoryList
                .map((item) =>
                InkWell(
                  onTap: (){
                    selectedItems = item;
                    Navigator.pop(context, item);
                  },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(item.name??'',style: TextStyle(color:colors.black54,fontWeight: FontWeight.normal,),),
                        ),
                        const Divider(
                          thickness: 0.2,
                          color: colors.black54,
                        )
                      ],
                    ),

                ),


          )
                .toList(),
          ),
        ),
        // actions: [
        //   TextButton(
        //     onPressed: _cancel,
        //     child: const Text(
        //       'Cancel',
        //       style: TextStyle(color: colors.primary),
        //     ),
        //   ),
        //   ElevatedButton(
        //     style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
        //     child: Text('Submit'),
        //     onPressed: () {
        //       // _submit();
        //
        //     }
        //     ,
        //   ),
        // ],
      );
    });
  }

}

