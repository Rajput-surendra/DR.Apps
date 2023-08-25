import 'dart:convert';
import 'dart:io';

import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import '../New_model/getUserProfileModel.dart';

class AddRequest extends StatefulWidget {
  const AddRequest({Key? key}) : super(key: key);

  @override
  State<AddRequest> createState() => _AddRequestState();
}
String? selectedValue ;

class _AddRequestState extends State<AddRequest> {
  final _formKey = GlobalKey<FormState>();
  String? awarenessValue ;
  final List<String> awarenesslist = ['Greeting','Poster', 'Video'];
  String? doctorValue ;
  final List<String> doctorlist = ['Yes', 'No'];
  String? requestValue ;
  final List<String> items = ['Poster', 'Leaflet', 'Booklet','Video'];
  String? standyValue ;
  final List<String> standyValueList = ['Standy ','Poster ', 'Leaflet ', 'Booklet ','Video ',];
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController drController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController  clinicHospitalController = TextEditingController();
  TextEditingController  emailController = TextEditingController();
  TextEditingController  messageAwereController = TextEditingController();
  TextEditingController  messageWorldAwereController = TextEditingController();
  TextEditingController  messagPersonalizedController = TextEditingController();
  TextEditingController  messageWorldEmeController = TextEditingController();
  TextEditingController  messageEventController = TextEditingController();
  TextEditingController  messageWebinarController = TextEditingController();
  TextEditingController  awarenessController = TextEditingController();
  TextEditingController  drAssociationController = TextEditingController();
  TextEditingController  speakerController = TextEditingController();
  TextEditingController  degreespeakerController = TextEditingController();
  TextEditingController  moderatorController = TextEditingController();
  TextEditingController  moderatorDegreeController = TextEditingController();
  TextEditingController  eventController = TextEditingController();
  TextEditingController  conferenceController = TextEditingController();
  TextEditingController  conferencedegreeController = TextEditingController();
  TextEditingController  requestCMEController = TextEditingController();
  TextEditingController  requestEventController = TextEditingController();
  TextEditingController  requestOnlineController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();

    requestCMEController = TextEditingController(text: "CME Invitation Designs");
    requestEventController = TextEditingController(text: "Event Invitation Designs");
    requestOnlineController = TextEditingController(text: "Online Webinar Invitation Designs");
    messagPersonalizedController = TextEditingController(text: "I Request to pharma companies can you please provide above awareness input for my clinic/hospital my social media a/c for awareness purpose only");
    messageAwereController =  TextEditingController(text:'I Request to pharma companies can you please provide above awareness input for my clinic/hospital my social media a/c for awareness purpose only.');
    messageWorldAwereController =  TextEditingController(text:' I Request to pharma companies can you please provide awareness input for my clinic/hospital/my social media a/c for awareness purpose only.');
    messageWorldEmeController =  TextEditingController(text:' I Request to pharma companies can you please design above CME invitation for our CME.');
    messageEventController =  TextEditingController(text:'I Request to pharma companies can you please design above Event invitation for our Event.');
    messageWebinarController =  TextEditingController(text:'I Request to pharma companies can you please design above Webinar invitation for our online webinar.');
  }
  bool isLoder = true;
  GetUserProfileModel? getprofile;
  getUserProfile() async {
    setState(() {
      isLoder == true
          ? const Center(child: CircularProgressIndicator())
          : SizedBox();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');

    var headers = {
      'Cookie': 'ci_session=9aba5e78ffa799cbe054723c796d2bd8f2f7d120'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getUserProfile}'));
    request.fields.addAll({'user_id': "${userId}"});
    print('_____ request.fields_____${ request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = GetUserProfileModel.fromJson(json.decode(finalResult));
      setState(() {
        getprofile = jsonResponse;
        emailController.text = getprofile!.user!.email ??  '' ;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  List newList = [];
  List  requestListForJson = [];
  String? newData ;
  String? staticDdfsdfsfsdfsdfsdfsdata;
  Future<bool> _onWillPop() async {
    return false; 
  }
  @override

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: customAppBar(context: context, text:"Add Request", isTrue: true, ),
        body: SingleChildScrollView(
          child: Form(
            key:  _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                        dropdownMaxHeight: 300,
                        hint: const Padding(
                          padding: EdgeInsets.only(bottom: 12,top: 0),
                          child: Text("Select Your Request to Pharma Company ",
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

                        items: ['Awareness inputs','Worlds Awareness Day inputs','CME Invitation Designs','Event Invitation Designs','Online Webinar Invitation Designs','Personalized Awareness']
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
                SizedBox(height: 10),
               getViewBasedOnSelectedValue(),
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
      case 'Awareness inputs':
        return awareness();
      case 'Worlds Awareness Day inputs':
        return awareness();
      case 'CME Invitation Designs':
        return awareness();
      case 'Event Invitation Designs':
        return awareness();
      case 'Online Webinar Invitation Designs':
        return awareness();
        case 'Personalized Awareness':
        return awareness();
      default:
        return Container();
    }
  }
  String? _email;
  bool isValidEmail(String value) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }
  awareness(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        selectedValue == "Awareness inputs" ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Request for" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
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
                    dropdownMaxHeight: 220,
                    hint: const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text("Select Request",
                        style: TextStyle(
                            color: colors.blackTemp,fontWeight: FontWeight.normal
                        ),),
                    ),
                    // dropdownColor: colors.primary,
                    value: requestValue,
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
                        requestValue = value!;

                      });
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
          ],
        ) :selectedValue == "Worlds Awareness Day inputs" ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text("Request for" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
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
                    dropdownMaxHeight: 220,
                    hint: const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text("Select Request",
                        style: TextStyle(
                            color: colors.blackTemp,fontWeight: FontWeight.normal
                        ),),
                    ),
                    // dropdownColor: colors.primary,
                    value: awarenessValue,
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
                        awarenessValue = value!;

                      });
                    },

                    items: awarenesslist
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
          ],):SizedBox.shrink(),
        SizedBox(height: 5,),
        selectedValue == "Personalized Awareness" ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Request for Personalized" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
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
                    dropdownMaxHeight: 240,
                    hint: const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text("Select Request",
                        style: TextStyle(
                            color: colors.blackTemp,fontWeight: FontWeight.normal
                        ),),
                    ),
                    // dropdownColor: colors.primary,
                    value: standyValue,
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
                        standyValue = value!;

                      });
                    },

                    items: standyValueList
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
          ],
        ):SizedBox.shrink(),
        selectedValue == "CME Invitation Designs" ? Column(
          children: [
              Row(children: [
                Text("Request for" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
              ],),
              SizedBox(height: 3,),
              SizedBox(
                // height: 45,
                child: TextFormField(
                  readOnly: true,
                  controller: requestCMEController,
                  decoration: InputDecoration(

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),

                ),
              )
            ],) : SizedBox.shrink(),
        selectedValue == "Event Invitation Designs" ? Column(children: [
              Row(children: [
                Text("Request for" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
              ],),
              SizedBox(height: 3,),
              SizedBox(
                // height: 45,
                child: TextFormField(
                  readOnly: true,
                  controller: requestEventController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),

                ),
              )
            ],) : SizedBox.shrink(),
        selectedValue == "Online Webinar Invitation Designs" ? Column(children: [
              Row(children: [
                Text("Request for" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
              ],),
              SizedBox(height: 3,),
              SizedBox(
                // height: 45,
                child: TextFormField(
                  readOnly: true,
                  controller: requestOnlineController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),

                ),
              )
            ],) : SizedBox.shrink(),
        SizedBox(height: 5,),
        selectedValue == "Personalized Awareness" ? SizedBox.shrink():  Column(children: [
          Row(children: [Text("Mobile No(optional)" ,textAlign: TextAlign.start)
          ],),
          SizedBox(height: 2,),
          SizedBox(
            // height: 45,
            child: TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              controller: mobileController,
              decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),

            ),
          ),
        ],),
        SizedBox(height: 3,),
        selectedValue == "Personalized Awareness"  ||  selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs"  ? SizedBox.shrink()  : Column(
          children: [
           Row(children: [
             Text("Doctor Association Name" ,textAlign: TextAlign.start)
           ],),
           SizedBox(height: 3,),
           SizedBox(
             // height: 45,
             child: TextFormField(
               controller: drAssociationController,

               decoration: InputDecoration(
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                   )
               ),

             ),
           ),
         ],),

        selectedValue == "Personalized Awareness"  ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Topic" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: topicController,
                validator: (value) {
                  if ((selectedValue == "Awareness inputs") && value!.isEmpty) {
                    return 'Please Enter a Topic';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "e.g. Arthritis,Psoriasis,Cancer",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ) :SizedBox.shrink(),

        selectedValue == "Awareness inputs"  ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Topic" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: topicController,
                validator: (value) {
                  if ((selectedValue == "Awareness inputs") && value!.isEmpty) {
                    return 'Please Enter a Topic';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "e.g. Arthritis,Psoriasis,Cancer",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ) :SizedBox.shrink(),

        selectedValue == "Personalized Awareness" ?  Column(
          children: [
            Row(children: [
              Text("Doctor Name" ,textAlign: TextAlign.start), Text("*" ,textAlign: TextAlign.start,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: drController,

                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
                validator: (value) {
                  if ((selectedValue == "Personalized Awareness") && value!.isEmpty) {
                    return 'Please Enter a Topic';
                  }
                  return null;
                },

              ),
            ),
          ],):SizedBox.shrink(),

        selectedValue == "Personalized Awareness" ? Column(
          children: [
            Row(children: [
              Text("Degree" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: degreespeakerController,
                validator: (value) {
                  if ((selectedValue == "Personalized Awareness") && value!.isEmpty) {
                    return 'Please Enter a Degree';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ):SizedBox.shrink(),
        selectedValue == "Personalized Awareness" ? Column(children: [
          Row(children: [
            Text("For Clinic or Hospital Name" ,textAlign: TextAlign.start)
          ],),
          SizedBox(height: 3,),
          SizedBox(
            // height: 45,
            child: TextFormField(
              controller: clinicHospitalController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter a Clinic or Hospital';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),

            ),
          ),
        ],):SizedBox.shrink(),
        selectedValue == "Personalized Awareness" ? Column(children: [
          Row(children: [
            Text("Place" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)

          ],),
          // SizedBox(height: 3,),
          SizedBox(
            child: TextFormField(
              controller: placeController,
              validator: (value) {
                if ((selectedValue == "Personalized Awareness") && value!.isEmpty) {
                  return 'Please Enter a Place';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),

            ),
          ),
        ],):SizedBox.shrink(),
        selectedValue == "Personalized Awareness" ? Column(
          children: [
            Row(children: [
              Text("Dr. Contact Email ID" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
           // SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                readOnly: true,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
                validator: (value) {
                  if ((selectedValue == "Personalized Awareness") && value == null || value!.isEmpty) {
                    return 'Please Enter an Email ID';
                  }
                  return null; // Return null if the input is valid
                },
                onSaved: (value) {
                  _email = value;
                },

              ),
            ),
          ],
        ):SizedBox.shrink(),
        selectedValue == "Personalized Awareness" ? Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text("Dr.Photo Require On Input" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
          ],),
          //SizedBox(height: 3,),
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
                  dropdownMaxHeight: 220,
                  hint: const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text("Select Dr.Photo Require On Input",
                      style: TextStyle(
                          color: colors.blackTemp,fontWeight: FontWeight.normal
                      ),),
                  ),
                  // dropdownColor: colors.primary,
                  value: doctorValue,
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
                      doctorValue = value!;

                    });
                  },

                  items: doctorlist
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
        ],):SizedBox.shrink(),
        selectedValue == "Personalized Awareness" ?  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Message for pharma company" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                readOnly: true,
                controller: messagPersonalizedController,
                maxLines: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a pharma company';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ):SizedBox(),



        selectedValue == "Worlds Awareness Day inputs"  ?  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Awareness Day" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),

            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: awarenessController,
                validator: (value) {
                  if ((selectedValue == "Worlds Awareness Day inputs") && value!.isEmpty) {
                    return 'Please Enter a Awareness Day';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "e.g. World Kidney Day, World Heart Day",
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ):SizedBox.shrink(),
        SizedBox(height: 3,),
        selectedValue == "CME Invitation Designs"  ?Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Topic" ,textAlign: TextAlign.start), Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: topicController,
                validator: (value) {
                  if ((selectedValue == "CME Invitation Designs" ) && value!.isEmpty) {
                    return 'Please Enter a Topic';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "e.g. Why Psoriasis",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ) :SizedBox.shrink(),
        SizedBox(height: 3,),
        selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs" ? Column(
          children: [
            Row(children: [
              Text("For Clinic or Hospital Name" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: clinicHospitalController,
                validator: (value) {
                  if ((selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs"  ) && value!.isEmpty) {
                    return 'Please Enter a Clinic or Hospital';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],):SizedBox.shrink(),
        SizedBox(height: 3,),
        selectedValue == "Event Invitation Designs"  ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Event Name" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: eventController,
                validator: (value) {
                  if ((selectedValue == "Event Invitation Designs") && value!.isEmpty) {
                    return 'Please Enter a Event Name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ) :SizedBox.shrink(),
        selectedValue == "Personalized Awareness" ? SizedBox.shrink():  selectedValue == "Online Webinar Invitation Designs" ? Column(children: [
          Row(children: [
            Text("Place" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)

          ],),
          SizedBox(height: 3,),
          SizedBox(
            child: TextFormField(
              controller: placeController,
              validator: (value) {
                if ((selectedValue == "Online Webinar Invitation Designs") && value!.isEmpty) {
                  return 'Please Enter a Place';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),

            ),
          ),
        ],):SizedBox.shrink(),
        selectedValue == "Event Invitation Designs"  || selectedValue ==  "Online Webinar Invitation Designs"? Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Text("Topic" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: topicController,
                validator: (value) {
                  if ((selectedValue == "Event Invitation Designs" && selectedValue ==  "Online Webinar Invitation Designs") && value!.isEmpty) {
                    return 'Please Enter a Topic';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: "e.g. Why Psoriasis",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ) :SizedBox.shrink(),
        SizedBox(height: 3,),
        selectedValue == "Personalized Awareness" ? SizedBox.shrink():  selectedValue == "Online Webinar Invitation Designs" ? Column(children: [
            Row(
              children: [
                Text("Date" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
              ],
            ),
            SizedBox(height: 3,),
            TextFormField(
              readOnly: true,
              onTap: (){
                _selectDateStart();
              },
              controller:dateController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: "",
                  hintText: 'Select Date',
                  contentPadding: EdgeInsets.only(left: 10)
              ),
              validator: (v) {
                if ((selectedValue == "Online Webinar Invitation Designs") && v!.isEmpty) {
                  return "Start Date is required";
                }

              },
            ),
            SizedBox(height: 10,),
            Row(children: [
              Text("Time" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            TextFormField(
              readOnly: true,
              onTap: (){
                chooseTime(context);
              },
              controller:timeController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: "",
                  hintText: 'Select Time',
                  contentPadding: EdgeInsets.only(left: 10)
              ),
              validator: (v) {
                if ((selectedValue == "Online Webinar Invitation Designs") && v!.isEmpty) {
                  return "Time Date is required";
                }

              },
            ),
          ],):SizedBox.shrink(),
        SizedBox(height: 3,),
        selectedValue == "CME Invitation Designs"  || selectedValue == "Online Webinar Invitation Designs" ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text("Speaker Dr. Name" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
                ],),
                SizedBox(height: 3,),
                SizedBox(
                  // height: 45,
                  child: TextFormField(
                    controller: speakerController,
                    validator: (value) {
                      if ((selectedValue == "CME Invitation Designs"  || selectedValue == "Online Webinar Invitation Designs") && value!.isEmpty) {
                        return 'Please Enter a Speaker Dr. Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),

                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(children: [
                  Text("Degree" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
                ],),
                SizedBox(height: 3,),
                SizedBox(
                  // height: 45,
                  child: TextFormField(
                    controller: degreespeakerController,
                    validator: (value) {
                      if ((selectedValue == "CME Invitation Designs"  || selectedValue == "Online Webinar Invitation Designs") && value!.isEmpty) {
                        return 'Please Enter a Degree';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),

                  ),
                ),
              ],
            ),
          ],
        ) :SizedBox.shrink(),
        SizedBox(height: 3,),
        selectedValue == "CME Invitation Designs"  || selectedValue == "Online Webinar Invitation Designs" ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Moderator Name" ,textAlign: TextAlign.start),  Text("" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: moderatorController,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please Enter a Moderator Name';
                //   }
                //   return null;
                // },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),

            Row(children: [
              Text("Degree" ,textAlign: TextAlign.start),
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: moderatorDegreeController,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please Enter a Moderator Name';
                //   }
                //   return null;
                // },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ) :SizedBox.shrink(),
        SizedBox(height: 3,),
        selectedValue == "Personalized Awareness" ? SizedBox.shrink() :  selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs" || selectedValue == "Online Webinar Invitation Designs" ? SizedBox.shrink():Column(
          children: [
          Row(
            children: [
            Text("Date" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
          ],
          ),
          SizedBox(height: 3,),
          TextFormField(
            readOnly: true,
            onTap: (){
              _selectDateStart();
            },
            controller:dateController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                counterText: "",
                hintText: 'Select Date',
                contentPadding: EdgeInsets.only(left: 10)
            ),
            validator: (v) {
              if (v!.isEmpty) {
                return "Start Date is required";
              }

            },
          ),
          SizedBox(height: 10,),
          Row(children: [
            Text("Time" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
          ],),
          SizedBox(height: 3,),
          TextFormField(
            readOnly: true,
            onTap: (){
              chooseTime(context);
            },
            controller:timeController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                counterText: "",
                hintText: 'Select Time',
                contentPadding: EdgeInsets.only(left: 10)
            ),
            validator: (v) {
              if (v!.isEmpty) {
                return "Time Date is required";
              }

            },
          ),
        ],),
        SizedBox(height: 3,),
        selectedValue == "Personalized Awareness" ? SizedBox.shrink():   selectedValue == "Online Webinar Invitation Designs" ? SizedBox.shrink(): Column(children: [
        Row(children: [
          Text("Place" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)

        ],),
        SizedBox(height: 3,),
        SizedBox(
          child: TextFormField(
            controller: placeController,
            validator: (value) {
              if ((selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs"  || selectedValue == "Event Invitation Designs" ||selectedValue == "CME Invitation Designs") && value!.isEmpty) {
                return 'Please Enter a Place';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),

          ),
        ),
        ],),
        SizedBox(height: 3,),
        selectedValue  == "Event Invitation Designs"  ?Column(
          children: [
            Row(children: [
              Text("Conference Secretariat Dr Name" ,textAlign: TextAlign.start),  Text("" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: conferenceController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
             SizedBox(height: 10,),
            Row(children: [
              Text("Degree" ,textAlign: TextAlign.start),
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                controller: conferencedegreeController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ):SizedBox.shrink(),
        SizedBox(height: 3,),
        selectedValue == "Event Invitation Designs"  || selectedValue == "CME Invitation Designs"  || selectedValue == "Online Webinar Invitation Designs" ?
        Column(children: [
          Row(children: [
            Text("For Clinic or Hospital Name" ,textAlign: TextAlign.start)
          ],),
          SizedBox(height: 3,),
          SizedBox(
            // height: 45,
            child: TextFormField(
              controller: clinicHospitalController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter a Clinic or Hospital';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),

            ),
          ),
        ],):SizedBox.shrink(),
        SizedBox(height: 5,),
        selectedValue == "Personalized Awareness" ? SizedBox.shrink():Column(
           children: [
             Row(children: [
               Text("Dr. Contact Email ID" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
             ],),
             SizedBox(height: 3,),
             SizedBox(
               // height: 45,
               child: TextFormField(
                 readOnly: true,
                 controller: emailController,
                 keyboardType: TextInputType.emailAddress,
                 decoration: InputDecoration(

                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                     )
                 ),
                 validator: (value) {
                   if ((selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs"  || selectedValue == "Event Invitation Designs" || selectedValue == "CME Invitation Designs" || selectedValue == "Online Webinar Invitation Designs") && value == null || value!.isEmpty) {
                     return 'Please Enter an Email ID';
                   }
                   return null; // Return null if the input is valid
                 },
                 onSaved: (value) {
                   _email = value;
                 },

               ),
             ),
           ],
         ) ,
        SizedBox(height: 3,),
        selectedValue == "Awareness inputs" ?  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Message for pharma company" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                readOnly: true,
                controller: messageAwereController,
                maxLines: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a pharma company';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ):SizedBox(),
        SizedBox(height: 3,),
        selectedValue == "Worlds Awareness Day inputs" ?  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Message for pharma company" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                readOnly: true,
                controller: messageWorldAwereController,
                maxLines: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a pharma company';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ):SizedBox(),
        SizedBox(height: 3,),
        selectedValue == "CME Invitation Designs" ?  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Message for pharma company" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                readOnly: true,
                controller: messageWorldEmeController,
                maxLines: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a pharma company';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ):SizedBox(),
        SizedBox(height: 3,),
        selectedValue == "Event Invitation Designs" ?  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Message for pharma company" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                readOnly: true,
                controller: messageEventController,
                maxLines: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a pharma company';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ):SizedBox(),
        SizedBox(height: 3,),
        selectedValue == "Online Webinar Invitation Designs" ?  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Message for pharma company" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                readOnly: true,
                controller: messageWebinarController,
                maxLines: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a pharma company';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ):SizedBox(),
        SizedBox(height: 20,),
        InkWell(
          onTap: (){
            if(_formKey.currentState!.validate()){
              addRequestApi();
            }
            else{
              Fluttertoast.showToast(msg: "Please fill all field");
             //
            }
            newData = (jsonEncode({
              "mobile_no":mobileController.text,
              "dr_name":drController.text,
              "dr_association":drAssociationController.text,
              "degree":degreeController.text,
              "place":placeController.text,
              "request":requestValue,
              "awareness_request": selectedValue  == "CME Invitation Designs" ? requestCMEController.text:selectedValue == "Event Invitation Designs" ?requestEventController.text :selectedValue == "Online Webinar Invitation Designs" ? requestOnlineController.text :awarenessValue,
              "topic":topicController.text,
              "clinic_hospital":clinicHospitalController.text,
              "email":emailController.text,
            "message": selectedValue == "Personalized Awareness" ?messagPersonalizedController.text:selectedValue == "Awareness inputs" ?messageAwereController.text:selectedValue == "Worlds Awareness Day inputs" ? messageWorldAwereController.text :
            selectedValue == "Worlds Awareness Day inputs" ? messageWorldAwereController.text :
            selectedValue  == "CME Invitation Designs"? messageWorldEmeController.text :selectedValue == "Event Invitation Designs" ? messageEventController.text
            : messageWebinarController.text,
              "awareness_day":awarenessController.text,
               "moderator":moderatorController.text,
               "degree_moderator":moderatorDegreeController.text,
               "speaker_name":speakerController.text,
               "degree_speaker_name":degreespeakerController.text,
               "degree_conference":conferencedegreeController.text,
               "date":dateController.text,
               "time":timeController.text,
               "event_name":eventController.text,
               "conference":conferenceController.text,
               "dr_photo":doctorValue,
               "dr_personalized":standyValue,


            }));


          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(color: colors.secondary,borderRadius: BorderRadius.circular(10)),
            child:isloader ? Center(child: CircularProgressIndicator()): Center(
              child: Text(
                "Submit Request",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
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

                //return true when click on "Yes"
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
  var imagePathList1;
  bool isImages =  false;
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
  File? imageFile;
  bool isloader = false;
  String _dateValue = '';
  var dateFormate;
  TimeOfDay? _selectedTime;
  String convertDateTimeDisplay(String date)  {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  Future _selectDateStart() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate = DateFormat("yyyy/MM/dd").format(DateTime.parse(_dateValue ?? ""));
        dateController = TextEditingController(text: _dateValue);


      });
  }
  Future<void>  chooseTime(BuildContext context,) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        timeController.text =  _selectedTime!.format(context);
      });
    }
  }
  String? userId;
  addRequestApi() async {
    setState(() {
      isloader = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=4c29058e1f136f7fad52a8564bfecc5f97ff12ea'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addRequestApi}'));
    request.fields.addAll({
      'type': selectedValue.toString(),
      'json': newData.toString(),
      'user_id': userId.toString()
    });
    print('_____request.fields_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult =  jsonDecode(result);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      newData = null;
      selectedValue =  null;
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
}
