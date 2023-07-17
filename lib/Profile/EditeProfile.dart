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

import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../New_model/get_cities_model.dart';
import '../New_model/get_place_model.dart';
import '../New_model/get_state_model.dart';
import '../Registration/doctorResignation.dart';

List <String>_selectedItems2 = [];
class EditeProfile extends StatefulWidget {
   EditeProfile({Key? key, required this.getUserProfileModel,required this.isTrue}) : super(key: key);
  final  GetUserProfileModel getUserProfileModel;
  bool isTrue;
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
   TextEditingController dayController = TextEditingController();
   TextEditingController morningTimeController = TextEditingController();
   TextEditingController eveingTimeController = TextEditingController();
   TextEditingController appointNOController = TextEditingController();
   TextEditingController clinicController = TextEditingController();
   TextEditingController hospitalController = TextEditingController();


  File? imageFile;
  File? registrationImage;
  final ImagePicker _picker = ImagePicker();
  bool? isFromProfile ;
  String? image;
  bool  isLodding = false;

  String? selectedState;
  String? selectedCity;
  String? selectedPlace;
  String? titleSelected;
  String? selectedPharmaTitle;


  var stateselected;
  var cityselected;
  var placeselected;
  var selectedTitle;
  var pharmaTitleSelected;


  List <GetStateData> getStateData = [];
  String? stateId;
  String?cityId;
  String?placeId;
  String?titleId;
  String?pharmaTitleSelectedID;
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
  selectedTitle = preferences.getString('selectedTitle');
  pharmaTitleSelected = preferences.getString('selectedPharmaTitle');
  print('Selecteccccccccccccccccccccccc${pharmaTitleSelected}');

}
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

  void requestPermission(BuildContext context,int i) async{
    getImageGallery(ImageSource.gallery, context ,i);
    /*return await showDialog<void>(
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
    );*/
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
  Future getImage(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(

      source: source,
     //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    getCropImage(context, i, image);
    Navigator.pop(context);
  }
  Future getImageGallery(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(

      source: source,
     //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
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
    // deegreeController.text = widget.getUserProfileModel.user?.userData?.first.docDigree ?? '' ;
    image = widget.getUserProfileModel.user?.profilePic ?? '';



    getStateApi();
    getRoll();
    super.initState();
  }
  String? roll;
  getRoll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    roll = preferences.getString('roll');
    print('___roll__________roll__________roll__________roll_______${roll}_________');
  }
  @override
  Widget build(BuildContext context) {
    print('_____jhhhhkhhhkhhjkh_____${widget.isTrue}_________');
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
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(100),
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
                    roll == "2" ?   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                hint: Padding(
                                  padding: EdgeInsets.only(top: 0,bottom: 10),
                                  child:selectedPharmaTitle == null ?Text("Loading!!!") :Text("${pharmaTitleSelected}",
                                    style: TextStyle(
                                        color: colors.black54,fontWeight: FontWeight.normal
                                    ),),
                                ),
                                // dropdownColor: colors.primary,
                                value: selectedPharmaTitle,
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
                                    selectedPharmaTitle = value!;

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

                        )
                      ],
                    ): Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text("Title hai", style: TextStyle(
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
                                hint: Padding(
                                  padding: EdgeInsets.only(top: 0,bottom: 10),
                                  child:selectedTitle == null ?Text("Loading!!!") :Text("${selectedTitle}",
                                    style: TextStyle(
                                        color: colors.black54,fontWeight: FontWeight.normal
                                    ),),
                                ),
                                // dropdownColor: colors.primary,
                                value: titleSelected,
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
                                    titleSelected = value!;

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

                        )
                      ],
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
                    ),
                    SizedBox(height: 10,),
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
                          contentPadding: EdgeInsets.only(left: 10, top: 5)
                      ),
                    ),

                    roll == "1" ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                    color: colors.black54,fontWeight: FontWeight.w500,fontSize:15
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
                        )
                      ],
                    ) : SizedBox.shrink(),
                    const SizedBox(
                      height: 10,
                    ),
                    roll == "1" ?Column(
                      children: [
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
                      ],
                    ):SizedBox.shrink(),

                    SizedBox(height: 10,),
                    roll == "1" ? Column(
                       children: [
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
                                     color: colors.black54,fontWeight: FontWeight.w500,fontSize:15
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
                       ],
                     ):SizedBox.shrink(),
                    roll == "1" ?  Column(
                       children: [
                         Padding(
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
                         SizedBox(height: 10,),
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
                         )
                       ],
                     ):SizedBox.shrink(),


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
                    ),
                    const SizedBox(height: 10,),

                    roll == 1 ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      ],
                    ): SizedBox.shrink(),
                    SizedBox(height: 10,),
                    const SizedBox(height: 60,),


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

  Widget EveningShiftEnd() {
    return  InkWell(
      onTap: () {
        chooseTimeEnd(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTimeOld != null
                  ? '${_selectedTimeOld!.format(context)}'
                  : 'Evening Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  Widget MorningShiftStart() {
    return InkWell(
      onTap: () {
        selectTimeStart(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTimeNew != null
                  ? '${_selectedTimeNew!.format(context)}'
                  : 'Morning Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget MorningShift() {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTime != null
                  ? '${_selectedTime!.format(context)}'
                  : 'Morning Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  Widget EveningShift() {
    return  InkWell(
      onTap: () {
        chooseTime(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTime1 != null
                  ? '${_selectedTime1!.format(context)}'
                  : 'Evening Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTime1;
  TimeOfDay? _selectedTimeNew;
  TimeOfDay? _selectedTimeOld;
  List<String>? results;
  List <String>_selectedItems2 = [];
  String? days;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime) {

      setState(() {
        _selectedTime = pickedTime;
        eveingTimeController.text = _selectedTime!.format(context);
      });
      print('_____eveingTime_____${_selectedTime!.format(context)}_________');
    }

  }
  Future<void> chooseTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime1 ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime1) {
      setState(() {
        _selectedTime1 = pickedTime;
        morningTimeController.text = _selectedTime1!.format(context);
        print('_____selectedTime1!.format(context)______${_selectedTime1!.format(context)}_________');
      });
    }
  }
  Future<void> selectTimeStart(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTimeNew ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTimeNew) {

      setState(() {
        _selectedTimeNew = pickedTime;
      });
      print('_____sfgfdgfdg_____${_selectedTimeNew!.format(context)}_________');
    }

  }
  Future<void> chooseTimeEnd(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTimeOld ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTimeOld) {
      setState(() {
        _selectedTimeOld = pickedTime;
      });
    }
  }
  // Widget select() {
  //   return InkWell(
  //     onTap:
  //     _selectedItems2 == null ? (){
  //       Fluttertoast.showToast(msg: 'Please Select Days',backgroundColor: colors.secondary);
  //
  //     }: () {
  //       setState(() {
  //         _showMultiSelect();
  //       });
  //     },
  //     child: Container(
  //         height: 50,
  //         width: MediaQuery.of(context).size.width,
  //         padding: const EdgeInsets.only(left: 10),
  //         decoration: BoxDecoration(
  //             color: colors.white10,
  //             borderRadius: BorderRadius.circular(15),
  //             border: Border.all(color: Colors.black.withOpacity(0.7))),
  //         child: results == null
  //             ? const Padding(
  //           padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
  //           child: Text(
  //             'Select Days',
  //             style: TextStyle(
  //               fontSize: 16,
  //               color: colors.black54,
  //               fontWeight: FontWeight.normal,
  //             ),
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         )
  //             :
  //         Wrap(
  //           crossAxisAlignment: WrapCrossAlignment.start,
  //           children: results!.map((e){
  //             return Padding(
  //               padding: const EdgeInsets.only(top: 10,left: 1,right: 1),
  //               child: Container(
  //                   width:45,
  //                   height: 30,
  //                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: colors.secondary),
  //                   child: Center(child: Text("${e}",style: TextStyle(color: colors.whiteTemp),))),
  //             );
  //           }).toList(),
  //         )
  //
  //     ),
  //   );
  // }
  void _showMultiSelect() async {
    results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState)

              {
                return
                  MultiSelect();
              }
          );
        }
    );
    setState(() {
    });

    print("checking result here ${results.runtimeType}");

  }

}

class MultiSelect extends StatefulWidget {

  // String type;
  // required this.type
  MultiSelect({Key? key, }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}
class _MultiSelectState extends State<MultiSelect> {
  List selectedItems = [];
  List<String> eventCat = [];
  bool isChecked = false;
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        setState(() {
          _selectedItems2.add(itemValue);
        });
      } else {
        setState(() {
          _selectedItems2.remove(itemValue);
        });
      }
    });
    print("this is selected values ${_selectedItems2.toString()}");
  }
  void _cancel() {
    Navigator.pop(context);
  }
  void _submit() {
    List selectedItem = _selectedItems2.map((item) => item).toList();
    //Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_selectedItems2.clear();
  }

  String finalList = '';
  var dayList = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState)
        {
          return
            AlertDialog(
              title: const Text('Select Days'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: dayList
                      .map((data) =>
                      CheckboxListTile(
                        activeColor: colors.primary,
                        value: _selectedItems2.contains(data),
                        title: Text(data),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) => _itemChange(data, isChecked!),

                      )
                  ).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancel',
                    style: TextStyle(color: colors.primary),),
                  onPressed: _cancel,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: colors.primary
                    ),
                    child: Text('Submit'),
                    onPressed: () {
                      //_submit();
                      Navigator.pop(context, _selectedItems2);

                    }
                ),
              ],
            );
        }
    );
  }

}