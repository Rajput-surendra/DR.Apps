import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DoctorRequest/add_request.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import '../New_model/GetSelectCatModel.dart';
import '../api/api_services.dart';

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({Key? key}) : super(key: key);

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Advertisement", isTrue: true, ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Form(
          // key: _formKey,
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
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("Select Type of ad" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
                ],
              ),
              SizedBox(height: 2,),
              Container(
                  padding: EdgeInsets.only(right: 5, top: 12),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration:
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all( color: colors.black54),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      dropdownMaxHeight: 300,
                      hint: const Padding(
                        padding: EdgeInsets.only(bottom: 12,top: 0),
                        child: Text("Select Type of ad",
                          style: TextStyle(
                              color: colors.blackTemp,fontWeight: FontWeight.normal,fontSize: 14
                          ),),
                      ),
                      // dropdownColor: colors.primary,
                      value: selectedValue,
                      icon:  const Padding(
                        padding: EdgeInsets.only(bottom: 30,left: 10),
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
                          selectedValue = value!;

                        });
                      },

                      items: ['Image','Video']
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
              SizedBox(height: 15,),
              getViewBasedOnSelectedValue(),
              SizedBox(height: 15,),

              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Doctor's Speciality",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold)),
                  ),
                  Text("*",style: TextStyle(color: colors.red),),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                  padding: EdgeInsets.only(right: 5, top: 9),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration:
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all( color: colors.black54,),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<SpeciplyData>(

                      hint: const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text("Select Speciality",
                          style: TextStyle(
                              color: colors.blackTemp,fontWeight: FontWeight.normal
                          ),),
                      ),
                      // dropdownColor: colors.primary,
                      value: catDrop,
                      icon:  const Padding(
                        padding: EdgeInsets.only(bottom: 20,top: 5),
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
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(items.name??'',style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.normal),),
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
              SizedBox(height: 15,),
              Row(
                children: [Text("Select area to publish ad " ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
                ],),
              SizedBox(height: 3,),
              Container(
                  padding: EdgeInsets.only(right: 5, top: 5),
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all( color: colors.black54),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      hint: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Select App Dash Board",
                          style: TextStyle(
                              color: colors.blackTemp,fontWeight: FontWeight.normal
                          ),),
                      ),
                      // dropdownColor: colors.primary,
                      value: dropdownInput,
                      icon:  Icon(Icons.keyboard_arrow_down_rounded,  color: colors.secondary,size: 30,),
                      // elevation: 16,
                      style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                      underline: Container(
                        // height: 2,
                        color:  colors.whiteTemp,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownInput = value!;
                        });
                      },
                      items: list.map((items) {
                        return DropdownMenuItem(
                          value: items['id'].toString(),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Container(
                                    width: 250,
                                    child: Text(items['name'].toString(),overflow:TextOverflow.ellipsis,style: TextStyle(color:colors.blackTemp,fontWeight: FontWeight.normal),)),
                              ),
                              Divider(
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

              SizedBox(height: 100,),

            ],
          ),
        ),
      ),
    );
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

    }
    );
  }
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
  String? userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRole();
    getSpecialityApi();
  }
  getRole() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userId');
    role = preferences.getString('roll');
    print('_______sadsadasdas___${role}_________');
  }
  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  File? newImageFile;
  bool isloader = false;
  List<File> files = [];
  _getFromGallery(bool type) async {
    FilePickerResult? result;
    if(type){
      result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpeg', 'jpg']);}
    if (result != null) {
      setState(() {
        files = result!.paths.map((path) => File(path!)).toList();
      });}
    else {
      result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null) {
        setState(() {
        });
      }
    }

  }
  List<File> filesVideo = [];
  _getFromGalleryVideo(bool type) async {
    FilePickerResult? result;
    if(type){
      result = await FilePicker.platform.pickFiles(type: FileType.video);}
    if (result != null) {
      setState(() {
        filesVideo = result!.paths.map((path) => File(path!)).toList();
      });}
    else {
      result = await FilePicker.platform.pickFiles(
          type: FileType.video);
      if (result != null) {
        setState(() {
        });
      }
    }

  }
  TextEditingController linkController = TextEditingController();
  String? role;
  // getUploadBannerNewApi() async {
  //   setState(() {
  //     isloader = true;
  //   });
  //   var headers = {
  //     'Cookie': 'ci_session=f5c119f5040eaef28e6a4c420b14b794a449a6c4'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getUploadBannerApi}'));
  //   request.fields.addAll({
  //     'user_id': '$userId',
  //     'link': linkController.text,
  //     // if(role == "1" )
  //     //  'type': role == "1" ? "" : dropdownInput
  //     'type': dropdownInput
  //   });
  //   print("getEventUserId--------------->${request.fields}");
  //   if(files == null) {
  //     print('________2__________');
  //     if (filesVideo != null) {
  //       request.files.add(await http.MultipartFile.fromPath(
  //           'image',  filesVideo[0].path ?? '' ));
  //     }
  //   }else{
  //     if (files != null) {
  //       print('__________3_________');
  //       request.files.add(await http.MultipartFile.fromPath(
  //           'image',  files[0].path ?? '' ));
  //     }
  //   }
  //
  //   print("files--------------->${request.files}");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     final result =  await response.stream.bytesToString();
  //     final finalResult = json.decode(result);
  //     print("thi os ojon==========>${finalResult}");
  //     Fluttertoast.showToast(msg: finalResult['message'],backgroundColor: colors.secondary);
  //     linkController.clear();
  //     files.clear();
  //     Navigator.pop(context);
  //     setState(() {
  //       isloader = false;
  //     });
  //   }
  //   else {
  //     setState(() {
  //       isloader = false;
  //     });
  //     print(response.reasonPhrase);
  //   }
  // }
  int _value = 1;
  bool isVideo = false;
  bool isImage = false;
  var dropdownInput ;
  List<Map<String, dynamic>> list = [
    {'id': 'main_dashboard', 'name' : 'Main Dashboard'},
    {'id': 'Doctor_Request', 'name' : "Doctor's Request"},
    {'id': 'event_webinar_slide', 'name' : 'Event & Webinars'},
    {'id': 'generic_brand_slide', 'name' : 'Generic Brand'},
    {'id': 'free_graphic_slide', 'name' : 'Free Graphic'},
    {'id': 'awareness_input_slide', 'name' : 'Awareness'},

  ];
  Widget getViewBasedOnSelectedValue() {
    switch (selectedValue) {
      case 'Image':
        return image();
      case 'Video':
        return video();
      default:
        return SizedBox();
    }
  }
  video(){
    return InkWell(
      onTap: (){
        // showExitPopup();
        _getFromGalleryVideo(true);
      },
      child: Container(
        decoration: BoxDecoration(
            color: colors.primary,
          border: Border.all(color: colors.blackTemp)
        ),

        // height: MediaQuery.of(context).size.height/6,
        height: newImageFile == null ?60:120,
        child: filesVideo.length > 0  ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text("${filesVideo[0]}")),
        ) :
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
              child:
              Text("Upload Video",style: TextStyle(color: colors.blackTemp),)

          ),
        ),
      ),
    );
  }
  image(){
    return InkWell(
      onTap: (){
        // showExitPopup();
        _getFromGallery(true);
      }, child: Container(
      decoration: BoxDecoration(
          color: colors.primary,
          border: Border.all(color: colors.blackTemp)
      ),
      height: imageFile == null ?60:130,
      child: files.length > 0  ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text("${files[0]}")),
      ) :
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: Center(
            child:
            Text("Upload Image ",style: TextStyle(color: colors.blackTemp),)

        ),
      ),
    ),);
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
}
