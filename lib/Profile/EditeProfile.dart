import 'dart:convert';
import 'dart:io';

import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/New_model/getUserProfileModel.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../New_model/get_cities_model.dart';
import '../New_model/get_place_model.dart';
import '../New_model/get_state_model.dart';


class EditeProfile extends StatefulWidget {
  const EditeProfile({Key? key, required this.getUserProfileModel}) : super(key: key);
  final  GetUserProfileModel getUserProfileModel;

  @override
  State<EditeProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController phonelController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController CompanyController = TextEditingController();
  TextEditingController ExpController = TextEditingController();
   TextEditingController deegreeController = TextEditingController();

  File? imageFile;
  File? registrationImage;
  final ImagePicker _picker = ImagePicker();
  bool? isFromProfile ;
  String? image;
  bool  isLodding = false;

  String? selectedState;
  String? selectedCity;
  String? selectedPlace;
  var stateselected;
  var cityselected;
  var placeselected;

  List <GetStateData> getStateData = [];
  String? stateId;
  String?cityId;
  String?placeId;
  List <GetCitiesDataNew>getCitiesData = [];
  List <GetPlacedData>getPlacedData = [];
  int? selectedSateIndex;


  GetStateResponseModel?getStateResponseModel;
   getStateApi() async {
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


onTapCall2() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  stateselected = preferences.getString('selectedState');
  cityselected = preferences.getString('selectedCity');
  placeselected = preferences.getString('selectedPlace');
  print('Selecteccccccccccccccccccccccc${stateselected}');

}


  String? dropdownDoctor ;
  var items2 = [
    'Dr.',
    'Prof.Dr.'
  ];



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
              // enableCloseButton == true
              //     ? GestureDetector(
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   child: Align(
              //       alignment: Alignment.topRight,
              //       child: closeIcon ??
              //           Icon(
              //             Icons.close,
              //             size: 14,
              //           )),
              // )
              //     : Container(),
              InkWell(
                onTap: () async {
                  //getFromGallery(i);
                  getImageGallery(ImgSource.Gallery, context ,i);
                },
                child: Container(
                  child: const ListTile(
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
                  //   ImagePicker()
                  //       .getImage(
                  //       source: ImageSource.camera,
                  //       maxWidth: maxWidth,
                  //       maxHeight: maxHeight)
                  //       .then((image) {
                  //     Navigator.pop(context, image);
                  //   });
                },
                child: Container(
                  child: const ListTile(
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
    // var status = await Permission.storage.request();
    // final status = await Permission.photos.status;
    // // final storage = await Permission.accessMediaLocation.status;
    // if(status.isGranted){
    //     getImage(ImgSource.Both, i);
    // }
    // else if(status.isPermanentlyDenied){
    //   openAppSettings();
    // }

    ///
//     if (await Permission.camera.isRestricted || await Permission.storage.isRestricted) {
//       openAppSettings();
//     }
//     else{
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.camera,
//         Permission.storage,
//       ].request();
// // You can request multiple permissions at once.
//
//       if(statuses[Permission.camera]==PermissionStatus.granted&&statuses[Permission.storage]==PermissionStatus.granted){
//         getImage(ImgSource.Both, context,i);
//
//       }else{
//         if (await Permission.camera.isDenied||await Permission.storage.isDenied) {
//           openAppSettings();
//         }else{
//           setSnackbar("Oops you just denied the permission", context);
//         }
//       }
//     }

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
        }else  if(i==2) {
          registrationImage = File(result.files.single.path.toString());
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
      // androidUiSettings: AndroidUiSettings(
      //     toolbarTitle: 'Cropper',
      //     toolbarColor: Colors.lightBlueAccent,
      //     toolbarWidgetColor: Colors.white,
      //     initAspectRatio: CropAspectRatioPreset.original,
      //     lockAspectRatio: false),
      // iosUiSettings: IOSUiSettings(
      //   minimumAspectRatio: 1.0,
      // )
    );
    setState(() {
      if (i == 1) {
        imageFile = File(croppedFile!.path);
      } else if (i == 2) {
        registrationImage = File(croppedFile!.path);
      }
      // else if(i==6){
      //   insuranceImage = File(croppedFile!.path);
      // }
      // else if(i==7){
      //   bankImage = File(croppedFile!.path);
      // }
      // else{
      //   _finalImage = File(croppedFile!.path);
      // }
    });
    Navigator.pop(context);
  }
  @override
  void initState() {
    onTapCall2();
    // TODO: implement initState
    emailController.text = widget.getUserProfileModel.user?.userData?.first.email ?? '' ;
    nameController.text = widget.getUserProfileModel.user?.userData?.first.username ?? '' ;
    mobileController.text = widget.getUserProfileModel.user?.userData?.first.mobile?? '' ;
    passController.text = widget.getUserProfileModel.user?.userData?.first.password?? '';
    ExpController.text = widget.getUserProfileModel.user?.userData?.first.experience ?? '' ;
    CompanyController.text = widget.getUserProfileModel.user?.userData?.first.companyName ?? '' ;
    dobController.text = widget.getUserProfileModel.user?.userData?.first.cityName ?? '' ;
    genderController.text = widget.getUserProfileModel.user?.userData?.first.gender?? '' ;
    deegreeController.text = widget.getUserProfileModel.user?.userData?.first.docDigree ?? '' ;
    deegreeController.text = widget.getUserProfileModel.user?.userData?.first.docDigree ?? '' ;
    image = widget.getUserProfileModel.user?.profilePic ?? '';

    getStateApi();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color:colors.secondary,
              borderRadius: BorderRadius.circular(10)
          ),
          height: 50,
          child: InkWell(
              onTap: (){
                updateProfileApi();
                // if(image != null || image != '') {
                //   if (imageFile == null) {
                //     Fluttertoast.showToast(
                //         msg: "please selected profile image");
                //   } else {
                //
                //   }
                // }else{
                //   if (imageFile == null) {
                //     Fluttertoast.showToast(
                //         msg: "please selected profile image");
                //   } else {
                //     updateProfileApi();
                //   }
                // }

              },
              child:isLodding ? Center(child: CircularProgressIndicator()) :Center(child: Text("Update Profile",style: TextStyle(color: colors.whiteTemp),))
          ),
        ),
      ),
      appBar: customAppBar(text: "",isTrue: true, context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>[
            const SizedBox(height: 20,),
            Stack(
                children:[
                  imageFile == null
                      ?  SizedBox(
                    height: 110,
                    width: 110,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      elevation: 5,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(image!, fit: BoxFit.fill,)
                        // Image.file(imageFile!,fit: BoxFit.fill,),
                      ),
                    ),
                  ) :

                  Container(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(imageFile ?? File(''),fit: BoxFit.fill)
                      // Image.file(imageFile!,fit: BoxFit.fill,),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      // top: 30,
                      child: InkWell(
                        onTap: (){
                          isFromProfile = true ;
                          requestPermission(context, 1);
                          // showExitPopup(isFromProfile ?? false);
                        },
                        child: Container(
                            height: 30,width: 30,
                            decoration: BoxDecoration(
                                color: colors.secondary,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Icon(Icons.camera_enhance_outlined,color: Colors.white,)),
                      ))
                ]
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Title", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    const SizedBox(height: 10,),

                    Container(
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

                    ),

                    SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Name", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.secondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return "name is required";
                      //   }
                      // },
                    ),

                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Email Id", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email Id',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.secondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return "Email is required";
                      //   }
                      //   if (!v.contains("@")) {
                      //     return "Enter Valid Email Id";
                      //   }
                      // },
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Mobile No", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: mobileController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: 'Mobile No',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.secondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return "mobile number is required";
                      //   }
                      //
                      // },
                    ),
                    SizedBox(height: 10,),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Password", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: passController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              fontSize: 15.0, color: colors.secondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return "mobile number is required";
                      //   }
                      //
                      // },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("City Name", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: dobController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'City Name',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.secondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return "Date of Birth is required";
                      //   }
                      //
                      // },
                    ),
                    const SizedBox(height: 10,),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("State Name", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    getStateResponseModel== null ? Center(child: CircularProgressIndicator()):
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colors.black54)
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          hint: Text('${stateselected}',
                            style: const TextStyle(
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
                          hint:Text('${cityselected}',
                            style: const TextStyle(
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
                          hint:  Text('${placeselected}',
                            style: const TextStyle(
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




                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Experience ", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: ExpController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Experience Name',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.blackTemp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return "Date of Birth is required";
                      //   }
                      //
                      // },
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Degree ", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: deegreeController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Degree',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.blackTemp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return "Date of Birth is required";
                      //   }
                      //
                      // },
                    ),

                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Gender ", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: genderController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Gender',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.blackTemp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return "Date of Birth is required";
                      //   }
                      //
                      // },
                    ),

                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Company Name ", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: CompanyController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Company',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.blackTemp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return "Date of Birth is required";
                      //   }
                      //
                      // },
                    ),
                    SizedBox(height: 60,)

                    /*const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Gender", style: TextStyle(
                          color: colors.black54, fontWeight: FontWeight.bold),),
                    ),

                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: genderController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Male',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.secondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return "Gender is required";
                      //   }
                      // },
                    ),
                    SizedBox(height: 10,)*/
                    // Padding(
                    //   padding: const EdgeInsets.all(5.0),
                    //   child: Text("Registration Card", style: TextStyle(
                    //       color: colors.black54, fontWeight: FontWeight.bold),),
                    // ),
                    // SizedBox(height: 10,),

                    // InkWell(
                    //   onTap: (){
                    //     isFromProfile = false ;
                    //     requestPermission(context, 2);
                    //     // showExitPopup(isFromProfile ?? false);
                    //   },
                    //   child: Container(
                    //     width: double.infinity,
                    //     // height: MediaQuery.of(context).size.height/4,
                    //     height:   registrationImage == null ? 60:154,
                    //     child: DottedBorder(
                    //       borderType: BorderType.RRect,
                    //       radius: Radius.circular(5),
                    //       dashPattern: [5, 5],
                    //       color: Colors.grey,
                    //       strokeWidth: 2,
                    //       child: registrationImage == null || registrationImage == ""  ?
                    //       Center(child:Icon(Icons.drive_folder_upload_outlined,color: Colors.grey,size: 30,)): Column(
                    //         children: [
                    //           Image.file(registrationImage!,fit: BoxFit.fill,
                    //             height: 150,
                    //             width: double.infinity,),
                    //         ],
                    //       ),
                    //
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 10,),
                    // SizedBox(height: 45,),
                    // Center(
                    //   child: Btn(
                    //       height: 50,
                    //       width: 320,
                    //       color: colors.secondary,
                    //       title: 'Update',
                    //       // onPress: () {
                    //       //   {
                    //       //     Navigator.push(context,
                    //       //         MaterialPageRoute(
                    //       //             builder: (context) => HomeScreen()));
                    //       //   }
                    //       // },
                    //       onPress: () {
                    //         updateProfileApi();
                    //       }
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }


  updateProfileApi() async{
    setState(() {
      isLodding = true;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId  =  preferences.getString('userId');
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getupdateUser}'));
    request.fields.addAll({
      'user_id': userId ?? '',
      'username': nameController.text,
      'mobile': mobileController.text,
      'address': dobController.text,
      'email': emailController.text,
      'gender': genderController.text,
      'company': CompanyController.text,
      'degree': deegreeController.text,
      'experience': ExpController.text,


    });
    print("this os p spos pms oskm ms=========>${request.files}");
   // request.files.add(await http.MultipartFile.fromPath('registration_card', registrationImage?.path ?? ''  ));
   if(imageFile != null){
     request.files.add(await http.MultipartFile.fromPath('image', imageFile?.path ?? ''));
   }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.encode(result);
      print("thi os ojon==========>${finalResult}");
     // Fluttertoast.showToast(msg: finalResult['message']);
      Fluttertoast.showToast(msg:'Updated Successfully');
      Navigator.pop(context);
      setState(() {
        isLodding =  false;
      });
    }
    else {
      setState(() {
        isLodding = false;
      });
      print(response.reasonPhrase);
    }

  }




}
