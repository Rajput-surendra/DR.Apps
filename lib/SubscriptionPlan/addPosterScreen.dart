import 'dart:convert';
import 'dart:io';

import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../Generic&Brand/slider_plan_screen.dart';
import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/Check_plan_model.dart';
import '../New_model/GetSelectCatModel.dart';
import '../New_model/getUserProfileModel.dart';
import '../New_model/get_cities_model.dart';
import '../New_model/get_state_model.dart';
import '../api/api_services.dart';

class AddPosterScreen extends StatefulWidget {
  const AddPosterScreen({Key? key}) : super(key: key);

  @override
  State<AddPosterScreen> createState() => _AddPosterScreenState();
}
String? selectedValue ;
class _AddPosterScreenState extends State<AddPosterScreen> {
  String? userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRole();
    getUserProfile();
    getSpecialityApi();
    getStateApi();
  }


  String? selectedState;
  String? selectedCity;
  int? selectedSateIndex;
  List <GetStateData> getStateData = [];
  String? stateId;
  String?cityId;
  List <GetCitiesDataNew>getCitiesData = [];
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
  // _getFromGallery(bool type) async {
  //   FilePickerResult? result;
  //   if(type){
  //     result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpeg', 'jpg']);}
  //   else{
  //     result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['mp4']);}
  //
  //   if (result != null) {
  //     setState(() {
  //       files = result!.paths.map((path) => File(path!)).toList();
  //     });}
  //
  //
  //
  // }
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
      result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['mp4',]);}
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
  getUploadBannerNewApi() async {
    setState(() {
      isloader = true;
    });
    var headers = {
      'Cookie': 'ci_session=f5c119f5040eaef28e6a4c420b14b794a449a6c4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getUploadBannerApi}'));
    request.fields.addAll({
      'user_id': '$userId',
      'link': linkController.text,
      // if(role == "1" )
      //  'type': role == "1" ? "" : dropdownInput
      'type': role == "1" ? "": dropdownInput,
       'speciality':catDrop?.id.toString() ?? "",
       'state_id': role == "2" ? "":stateId.toString(),
       'city_id':role == "2" ? "":cityId.toString(),
    });
    print("getEventUserId--------------->${request.fields}");
    if(files == null) {
      print('________2__________');
      if (filesVideo != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'image', filesVideo[0].path ?? '' ));
      }
    }else{
      if (files != null) {
        print('__________3_________');
        request.files.add(await http.MultipartFile.fromPath(
            'image',  files[0].path ?? '' ));
      }
    }

    print("files--------------->${request.files}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.decode(result);
      print("thi os ojon==========>${finalResult}");
      Fluttertoast.showToast(msg: finalResult['message'],backgroundColor: colors.secondary);
      linkController.clear();
      files.clear();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      setState(() {
        isloader = false;
      });
    }
    else {
      setState(() {
        isloader = false;
      });
      print(response.reasonPhrase);
    }
  }
  int _value = 1;
  bool isVideo = false;
  bool isImage = false;
  var dropdownInput ;
  List<Map<String, dynamic>> list = [
    // {'id': 'Doctor_Request', 'name' : "Doctor's Request"},
    // {'id': 'event_webinars_slide', 'name' : 'Event & Webinars'},
    // {'id': 'pharma_product_slide', 'name' : 'Pharma Product'},
    // {'id': 'free_graphic_slide', 'name' : 'Free Graphic'},
    // {'id': 'awareness', 'name' : 'Awareness Input'},
    // {'id': 'doctor_plus_slide', 'name' : 'Doctor plus'},

    {'id': 'main_dashboard', 'name' : 'Main Dashboard'},
    {'id': 'Doctor_Request', 'name' : "Doctor's Request"},
    {'id': 'event_webinar_slide', 'name' : 'Event & Webinars'},
    {'id': 'generic_brand_slide', 'name' : 'Generic Brand'},
    {'id': 'free_graphic_slide', 'name' : 'Free Graphic'},
    {'id': 'awareness', 'name' : 'Awareness'},

  ];


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

  CheckPlanModel? checkPlanModel;
  checkSubscriptionApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userId');
    role = preferences.getString('roll');
    print('__________${role}_________');
    var headers = {
      'Cookie': 'ci_session=64caa747045713fca2e42eb930c7387e303fd583'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getCheckSubscriptionApi}'));
    request.fields.addAll({
      'user_id': "$userId",
      'type':role =="1" ?"doctor":'pharma'
    });
    print('___sadsfdsfsdfsdafgsdgdg_______${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var  result = await response.stream.bytesToString();
      var finalResult = CheckPlanModel.fromJson(jsonDecode(result));
      if(finalResult.status == true){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPosterScreen()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SliderPlanScreen()));
      }
      print('____Bew Api______${finalResult}_________');
      setState(() {
        checkPlanModel =  finalResult ;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

 Future<bool> checkSubscriptionStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userId');
    role = preferences.getString('roll');
    print('__________${role}_________');
    var headers = {
      'Cookie': 'ci_session=64caa747045713fca2e42eb930c7387e303fd583'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getCheckSubscriptionApi}'));
    request.fields.addAll({
      'user_id': "$userId",
      'type':role =="1" ?"doctor":'pharma'
    });
    print('___sadsfdsfsdfsdafgsdgdg_______${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var  result = await response.stream.bytesToString();
      var finalResult = CheckPlanModel.fromJson(jsonDecode(result));
      if(finalResult.status == true){
        return true; // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPosterScreen()));
      }else{
        return false; // Navigator.push(context, MaterialPageRoute(builder: (context)=>SliderPlanScreen()));
      }
    }else{
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Btn(
            height: 50,
            title: isloader ? "Please wait......" : 'Advertisement',
            onPress: () async{
              print('__filesVideo != null________${filesVideo}_________');
              // if(files != null){
              //   Fluttertoast.showToast(msg: "Please select all field",backgroundColor: colors.secondary);
              // }
              // if(selectedState ==  null ){
              //   Fluttertoast.showToast(msg: "Please select state",backgroundColor: colors.secondary);
              // }
              // else {
              //
              //
              //
              // }
              if(await checkSubscriptionStatus()){
                getUploadBannerNewApi();
              } else {
              checkSubscriptionApi();
              }

            },
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.secondary,
        title:role == "1"?Image.asset("assets/images/dr_plus_logo.png",height: 50,): Image.asset("assets/splash/DR.app.png",height: 50,),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_sharp)),
      ),
      body:getStateResponseModel == null || getStateResponseModel == ""? Center(child: CircularProgressIndicator()) :Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 10),
        child: SingleChildScrollView(
          child: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Form(
              // key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                 role == "1" ? Text("Advertisement for DR Plus app and DR Plus website",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),):Text("Advertisement",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                  SizedBox(height: 15,),
                  //  Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Radio(
                  //       value: 1,
                  //       fillColor: MaterialStateColor.resolveWith(
                  //               (states) =>  colors.secondary),
                  //       activeColor:  colors.secondary,
                  //       groupValue: _value,
                  //       onChanged: (int? value) {
                  //         setState(() {
                  //           _value = value!;
                  //           isVideo = false;
                  //         });
                  //       },
                  //     ),
                  //     Text(
                  //       "Video",
                  //       style: TextStyle(
                  //           color: colors.secondary, fontSize: 21),
                  //     ),
                  //     Radio(
                  //         value: 2,
                  //         fillColor: MaterialStateColor.resolveWith(
                  //                 (states) => colors.secondary),
                  //         activeColor:   colors.secondary,
                  //         groupValue: _value,
                  //         onChanged: (int? value) {
                  //           setState(() {
                  //             _value = value!;
                  //             isImage = true;
                  //           });
                  //         }),
                  //     // SizedBox(width: 10.0,),
                  //     Text(
                  //       "Images",
                  //       style: TextStyle(
                  //           color:  colors.secondary, fontSize: 21),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                    Text("Select AD format" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
                  ],
                  ),
                  SizedBox(height: 2,),
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
                          dropdownMaxHeight: 300,
                          hint: const Padding(
                            padding: EdgeInsets.only(bottom: 12,top: 0),
                            child: Text("Select AD Format",
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

                          items: ['Image AD','Video AD']
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
                  // SizedBox(height: 15,),
                  getViewBasedOnSelectedValue(),
                  SizedBox(height: 5,),
                  role == "1" ?SizedBox.shrink(): Column(
                    children: [
                      Row(
                        children: [
                          Text("Select App Dashboard" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
                        ],),
                      SizedBox(height: 3,),
                      Container(
                          padding: EdgeInsets.only(right: 5, top: 5),
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
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text("Select",
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
                                        padding: const EdgeInsets.only(top: 10),
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
                    ],
                  ),
                  // _value == 1  ?   video(): image(),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Link" ,textAlign: TextAlign.start)
                    ],
                  ),
                  SizedBox(height: 3,),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: linkController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5,left: 5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: '(Link Optional)'
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Link is required";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 15,),

                 //role  == "1" ?
                 Column(
                   children: [
                     Row(
                       children: [
                         Text("Select Speciality" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
                       ],),
                     SizedBox(height: 3,),

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
                               padding: EdgeInsets.only(bottom: 10),
                               child: Text("Select Speciality",
                                 style: TextStyle(
                                     color: colors.black54,fontWeight: FontWeight.w500,fontSize:15
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
                                       child: Text(items.name??'',style: TextStyle(color:colors.black54,),),
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

                   ],
                 ),

                    // :SizedBox(),
                  SizedBox(height: 15,),

                  role  == "1" ?
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Select State" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
                            ],),
                          SizedBox(height: 3,),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: colors.black54)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                hint: const Text('State',
                                  style: TextStyle(
                                      color: colors.black54,fontWeight: FontWeight.w500,fontSize:15
                                  ),),
                                // dropdownColor: colors.primary,
                                value: selectedState,
                                icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:colors.secondary,size: 30,),
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
                                        getCityApi(stateId!);
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
                        ],
                      )

                      :SizedBox(),
                  SizedBox(height: 15,),
                  role  == "1" ? Column(
                    children: [
                      Row(
                        children: [
                          Text("Select City" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
                        ],),
                      SizedBox(height: 3,),
                      Container(
                        height: 50,
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
                                getCitiesResponseModel!.data!.forEach((element) {
                                  if(element.name == value){
                                    selectedSateIndex = getCitiesResponseModel!.data!.indexOf(element);
                                    cityId = element.id;
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
                                          // width: MediaQuery.of(context).size.width/1.42,
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


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget getViewBasedOnSelectedValue() {
    switch (selectedValue) {
      case 'Image AD':
        return image();
      case 'Video AD':
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
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          // height: MediaQuery.of(context).size.height/6,
          height: newImageFile == null ?70:120,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(5),
            dashPattern: [5, 5],
            color: Colors.grey,
            strokeWidth: 2,
            child: filesVideo.length > 0  ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("${filesVideo[0]}")),
            ) :
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Center(
                  child:
                  Column(
                    children: [
                      Icon(Icons.drive_folder_upload_outlined,color: Colors.grey,size: 25,),
                      Text("Video file Upload",style: TextStyle(color: colors.red,fontSize: 13),),
                      Text("16:4 pixel",style: TextStyle(color: colors.red,fontSize: 12),)
                    ],
                  )

              ),
            ),

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
      }, child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
        height: imageFile == null ?70:130,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(5),
          dashPattern: [5, 5],
          color: Colors.grey,
          strokeWidth: 2,
          child: files.length > 0  ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("${files[0]}")),
          ) :
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Center(
                child:
                Column(
                  children: [
                    Icon(Icons.drive_folder_upload_outlined,color: Colors.grey,size: 25,),
                    Text("Banner file Upload",style: TextStyle(color: colors.red,fontSize: 13),),
                    Text("1360*880 pixel",style: TextStyle(color: colors.red,fontSize: 12),)
                  ],
                )

            ),
          ),

        ),
    ),
      ),);
  }

  GetUserProfileModel? getprofile;
  getUserProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');

    var headers = {
      'Cookie': 'ci_session=9aba5e78ffa799cbe054723c796d2bd8f2f7d120'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getUserProfile}'));
    request.fields.addAll(
        {'user_id': "${userId}"}
    );
    print('______request.fields____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse =
      GetUserProfileModel.fromJson(json.decode(finalResult));
      setState(() {
        getprofile = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }


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

    print('______ccccccccccccccc____${request.fields}_________');
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
}
