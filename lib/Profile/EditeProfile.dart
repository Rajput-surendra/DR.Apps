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
import 'package:permission_handler/permission_handler.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../New_model/get_cities_model.dart';
import '../New_model/get_pharma_category.dart';
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
  TextEditingController placeC = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController phonelController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cityController = TextEditingController();
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
  String? pharmaselected;
  String? SelectedPharma;
  String? teamSelected;
  int selectedIndex = 0;
  String? dropdownTeam ;
  var items = [
    'PMT team',
    'Marketing team',
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


  var stateselected;
  var cityselected;
  var placeselected;
  var selectedTitle;
  var selectedPharma;
  var selectedTeam;


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
      setState(() {
        getStateResponseModel =  finalResult;
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

  placeselected = preferences.getString('selectedPlace');

  selectedTeam = preferences.getString('selectedTeam');


}

  int category  = 2;
  var results ;
String? catName ;
  Future<bool> showExitPopup1() async {
    return await showDialog(

      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, context, 1);
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

                child: Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }

  void requestPermission(BuildContext context,int i) async{
    print("okay");
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.mediaLibrary,
      Permission.storage,
    ].request();
    if(statuses[Permission.photos] == PermissionStatus.granted&& statuses[Permission.mediaLibrary] == PermissionStatus.granted){
      getImage(ImageSource.gallery, context, 1);


    }else{
      getImageCmera(ImageSource.camera,context,1);
    }
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
        imageFile = File(croppedFile!.path);
      }

    });

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
    cityController.text = widget.getUserProfileModel.user?.userData?.first.city ?? '' ;
    genderController.text = widget.getUserProfileModel.user?.userData?.first.gender?? '' ;
    deegreeController.text = widget.getUserProfileModel.user?.userData?.first.docDigree ?? '' ;
    placeC.text = widget.getUserProfileModel.user?.userData?.first.placeName ?? '' ;
    image = widget.getUserProfileModel.user?.profilePic ?? '';
    catName = widget.getUserProfileModel.user?.userData?.first.categoryId ;
    //selectedTeam = widget.getUserProfileModel.user?.userData?.first.categoryId ;
    selectedTitle = widget.getUserProfileModel.user?.userData?.first.title ;
    selectedPharma = widget.getUserProfileModel.user?.userData?.first.title ;
    stateselected = widget.getUserProfileModel.user?.userData?.first.stateName ;
    cityselected = widget.getUserProfileModel.user?.userData?.first.cityName ;



    getStateApi();
    getRoll();
    super.initState();
  }
  String? roll;
  getRoll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    roll = preferences.getString('roll');

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

                          showExitPopup1();
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
                          child: Text("Title Pharma", style: TextStyle(
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
                                  child:Text("${selectedPharma}",
                                    style: TextStyle(
                                        color: colors.blackTemp,fontWeight: FontWeight.normal
                                    ),),
                                ),
                                // dropdownColor: colors.primary,
                                value: pharmaselected,
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
                                    pharmaselected = value!;

                                  });
                                },

                                items: items1
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
                                  child:Text("${selectedTitle}",
                                    style: TextStyle(
                                        color: colors.blackTemp,fontWeight: FontWeight.normal
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
                          hintText: 'Name',
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

                   SizedBox(height: 10,),
                    Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("State Name", style: TextStyle(
                                  color: colors.black54, fontWeight: FontWeight.bold),),
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
                                          color: colors.blackTemp,fontWeight: FontWeight.normal,fontSize:15
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
                                        getStateResponseModel!.data!.forEach((element) {
                                          if(element.name == value){
                                            selectedSateIndex = getStateResponseModel!.data!.indexOf(element);
                                            stateId = element.id;
                                            selectedCity = null;
                                            selectedPlace = null;
                                            getCityApi(stateId!);
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
                          ) ,
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
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
                                          color: colors.blackTemp,fontWeight: FontWeight.normal,fontSize:15
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
                          ),
                          SizedBox(height: 10,),

                        ],
                      ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Place Name ", style: TextStyle(
                                  color: colors.black54, fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 5,),
                            TextFormField(
                              controller: placeC,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: 'Place',
                                  hintStyle: TextStyle(
                                      fontSize: 15.0, color: colors.blackTemp),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  contentPadding: EdgeInsets.only(left: 10, top: 10)
                              ),

                            ),
                          ],
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),

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

                   roll == "2" ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Company Name ", style: TextStyle(
                                  color: colors.black54, fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 5,),
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

                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Select Category", style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),),
                        ),
                        Column(
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
                                    hint:  Padding(
                                      padding: EdgeInsets.only(bottom: 15),
                                      child: Text("${selectedTeam}",
                                        style: TextStyle(
                                            color: colors.blackTemp,fontWeight: FontWeight.normal
                                        ),),
                                    ),
                                    // dropdownColor: colors.primary,
                                    value: teamSelected,
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
                                        teamSelected = value!;
                                        selectedIndex = items.indexOf(value);
                                        if (selectedIndex == 0) {
                                          category = 2;
                                        } else {
                                          category = 3;
                                        }

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
                                              child: Text(value,style: const TextStyle(color: colors.blackTemp,fontWeight: FontWeight.normal),),
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
                        ) ,
                      ],
                    ):SizedBox.shrink(),

                        // : SizedBox.shrink(),
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
      'address': cityController.text,
      'email': emailController.text,
      'gender': genderController.text,
      'company': CompanyController.text,
      'degree': deegreeController.text,
      'experience': ExpController.text,
      'area_id': placeC.text,
      'title':titleController.text,
      'city': cityselected,
      'state':stateselected



    });
   if(imageFile != null){
     request.files.add(await http.MultipartFile.fromPath('image', imageFile?.path ?? ''));
   }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.encode(result);
      print("thi os ojon==========>${finalResult}");
     // Fluttertoast.showToast(msg: finalResult['message']);
      Fluttertoast.showToast(msg:'Updated Successfully',backgroundColor: colors.secondary);
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
  Widget select() {
    return InkWell(
      onTap:teamSelected == null ? (){
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
            ?  Padding(
          padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
          child: Text(
            catName ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: colors.blackTemp,
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
              child: Text(results.name??'',style: TextStyle(color:colors.blackTemp),),
            ),

          ],
        ),
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
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse =
          GetPharmaCategory.fromJson(json.decode(finalResult)).data;
      setState(() {
        pharmaCategoryList = jsonResponse ?? [];
      });
    } else {

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

      );
    });
  }

}

