import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetSliderModel.dart';
import '../New_model/Get_request_model.dart';
import '../api/api_services.dart';
import '../widgets/widgets/commen_slider.dart';
import 'add_request.dart';

class DoctorRequest extends StatefulWidget {
  const DoctorRequest({Key? key}) : super(key: key);

  @override
  State<DoctorRequest> createState() => _DoctorRequestState();
}


class _DoctorRequestState extends State<DoctorRequest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderApi();
    getRequestApi();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isReady = true;
      });
    });
    getRole();
  }
  String? role;
  getRole()async{
    SharedPreferences preferences  = await  SharedPreferences.getInstance();
    role = preferences.getString("roll");
    print('_____role_____${role}_________');
  }
  bool iconVisible = true;
  bool _isReady = true ;
  GlobalKey keyList = GlobalKey() ;
  String? userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomSheet: role == "1" ?Padding(
       padding: const EdgeInsets.all(8.0),
       child: InkWell(
         onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddRequest()));
         },
         child: Container(
           height: 50,
           decoration: BoxDecoration(color: colors.secondary,borderRadius: BorderRadius.circular(10)),
           child: Center(
             child: Text(
               "Add Request",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 20),
             ),
           ),
         ),
       ),
     ):SizedBox.shrink(),

      appBar: customAppBar(context: context, text:" Doctor's Request", isTrue: true, ),
      body: ListView(
         children: [
           getSlider(),
           button(),
           getRequestModel  ==  null ? Center(child: CircularProgressIndicator(color: colors.primary,)) :  getRequestModel!.data!.length == 0 ? Center(child: Text("No Doctor Resquest !!")): viewCard(),
           SizedBox(height: 70,)

         ],
      ),
    );
  }

  _shareQrCode({String? text}) async {
    iconVisible = true ;
    var status =  await Permission.photos.request();

    if ( status.isGranted/*storagePermission == PermissionStatus.denied*/) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await bound.toImage(pixelRatio: 10);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      print('${byteData?.buffer.lengthInBytes}___________');
      // this will save image screenshot in gallery
      if(byteData != null ){
        Uint8List pngBytes = byteData.buffer.asUint8List();
        String fileName = DateTime
            .now()
            .microsecondsSinceEpoch
            .toString();
        final imagePath = await File('$directory/$fileName.png').create();
        await imagePath.writeAsBytes(pngBytes);
        Share.shareFiles([imagePath.path],text: text);
      }
    } else if (await status.isDenied/*storagePermission == PermissionStatus.denied*/) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This Permission is recommended')));
    } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
      openAppSettings().then((value) {

      });
    }
  }
  wishListApi(String ? requestId) async {
    var headers = {
      'Cookie': 'ci_session=6f1de5370d8c25e7d0c07b421f024a150f5afda9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addWishlistApi}'));
    request.fields.addAll({
      'user_id': userId.toString(),
      'request_id': requestId.toString()
    });
    print('_____request.fields_____${request.fields}_________');

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
    }
    else {
    print(response.reasonPhrase);
    }

  }

  viewCard(){
    return Container(
      child: ListView.separated(
      physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        reverse: true,
        itemCount: getRequestModel!.data!.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return  RepaintBoundary(
            key: keyList,
            child: _isReady ? Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          child:  getRequestModel!.data![index].userImage == null ? Container(
                              height: 70,
                              width: 70  ,
                              child: CircleAvatar()):ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  color: colors.blackTemp,

                            height: 70,
                            width: 70,
                            child: Image.network("${getRequestModel!.data![index].userImage}")),
                              )
                        ),
                       SizedBox(width: 5,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text("Dr.${getRequestModel!.data![index].name}",style: TextStyle(
                               color: colors.secondary,fontWeight: FontWeight.bold
                           ),),
                           Text("Degree-${getRequestModel!.data![index].docDigree}",style: TextStyle(color: colors.blackTemp),),

                         ],
                       ),
                       SizedBox(width: MediaQuery.of(context).size.width/4.5,),
                       iconVisible ? Row(
                         children: [
                           InkWell(
                               onTap: (){
                                 setState(() {
                                   iconVisible = false;
                                 });
                                 Future.delayed(Duration(seconds: 1), (){
                                   _shareQrCode(text: getRequestModel!.data![index].json!.message ?? '');
                                 });
                               },
                               child: Icon(Icons.share)),
                           IconButton(onPressed: (){
                             setState(() {
                               wishListApi(getRequestModel!.data![index].id  ?? '',);
                               getRequestModel!.data![index].isSelected  = !(getRequestModel!.data![index].isSelected ?? false );
                             });
                           },
                               icon: getRequestModel!.data![index].isFavorite  ?? false ?
                               Icon(Icons.favorite,color: colors.red,): getRequestModel!.data![index].isSelected ?? false ? Icon(Icons.favorite,color: colors.red,) :
                               Icon(Icons.favorite_outline,color: colors.red,)),

                         ],
                       ):SizedBox.shrink()

                      ],
                    ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getRequestModel!.data![index].type == "Personalized Awareness" ?  Text("Standy for Personalized :",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),):Text("Request for :",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                                getRequestModel!.data![index].type ==  "Personalized Awareness" ? Text("${getRequestModel!.data![index].json!.drPersonalized}",): getRequestModel!.data![index].type  == "Awareness inputs" ?Text("${getRequestModel!.data![index].json!.request}",):Text("${getRequestModel!.data![index].json!.awarenessRequest}",)
                              ],
                            ),
                            Divider(
                              color: colors.black54,
                            ),

                            getRequestModel!.data![index].type == "Personalized Awareness" ?SizedBox.shrink():  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Mobile No :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                              Text("${getRequestModel!.data![index].json!.mobileNo}",),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ),

                            getRequestModel!.data![index].type  == "Personalized Awareness" ?
                            SizedBox.shrink():getRequestModel!.data![index].type  == "Awareness inputs" ||
                                getRequestModel!.data![index].type == "Worlds Awareness Day inputs" ?  SizedBox.shrink(): Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Dr.Association Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.drAssociation}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ) ,
                            getRequestModel!.data![index].type == "Event Invitation Designs" ?  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Event Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.eventName}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                          getRequestModel!.data![index].type == "Online Webinar Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.place}",),
                                  ],
                                ),
                                Divider(
                                  // indent: 5,
                                  // endIndent: 5,
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                            getRequestModel!.data![index].type == "Worlds Awareness Day inputs" ?  SizedBox.shrink(): Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Topic :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.topic}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ) ,
                            getRequestModel!.data![index].type  == "Personalized Awareness" ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Dr. Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.drName}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),


                            getRequestModel!.data![index].type  == "Personalized Awareness" ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Degree :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.degreeSpeakerName}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),






                            getRequestModel!.data![index].type == "Worlds Awareness Day inputs" ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Awarenes Day:",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.awarenessDay}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                            getRequestModel!.data![index].type == "CME Invitation Designs" ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Speaker Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.speakerName}",),
                                    SizedBox(height: 3,),
                                    Text("${getRequestModel!.data![index].json!.degreeSpeakerName}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                            getRequestModel!.data![index].type == "CME Invitation Designs"  ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Moderator Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.moderator}",),
                                    SizedBox(height: 3,),
                                    Text("${getRequestModel!.data![index].json!.degreeModerator}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),

                            getRequestModel!.data![index].type == "CME Invitation Designs" ||getRequestModel!.data![index].type == "Event Invitation Designs" ||  getRequestModel!.data![index].type == "Online Webinar Invitation Designs" ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Date :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.date}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                            getRequestModel!.data![index].type == "CME Invitation Designs" ||getRequestModel!.data![index].type == "Event Invitation Designs" ||  getRequestModel!.data![index].type == "Online Webinar Invitation Designs" ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Time :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.time}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                            getRequestModel!.data![index].type == "CME Invitation Designs" ?  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.place}",),
                                  ],
                                ),
                                Divider(
                                  // indent: 5,
                                  // endIndent: 5,
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                            getRequestModel!.data![index].type == "Event Invitation Designs" ?  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.place}",),
                                  ],
                                ),
                                Divider(
                                  // indent: 5,
                                  // endIndent: 5,
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                             getRequestModel!.data![index].type == "Online Webinar Invitation Designs" ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Speaker Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.speakerName}",),
                                   SizedBox(height: 2,),
                                   Text("${getRequestModel!.data![index].json!.degreeSpeakerName}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                        getRequestModel!.data![index].type == "Online Webinar Invitation Designs"   ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Moderator :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.moderator}",),
                                    Text("${getRequestModel!.data![index].json!.degreeModerator}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                           getRequestModel!.data![index].type == "Event Invitation Designs" ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Conference Secretariat Dr Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.conference}",),
                                    SizedBox.shrink(),
                                    Text("${getRequestModel!.data![index].json!.degreeConference}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("For Clinic or Hospital Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.clinicHospital}",),
                                  ],
                                ),
                                Divider(
                                  color: colors.black54,
                                ),
                              ],
                            ),
                            getRequestModel!.data![index].type  == "Personalized Awareness" ?  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.place}",),
                                  ],
                                ),
                                Divider(
                                  // indent: 5,
                                  // endIndent: 5,
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                            getRequestModel!.data![index].type  == "Personalized Awareness" ?  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Dr.Photo Require On Input  :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.drPhoto}",),
                                  ],
                                ),
                                Divider(
                                  // indent: 5,
                                  // endIndent: 5,
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                            getRequestModel!.data![index].type == "Awareness inputs" || getRequestModel!.data![index].type == "Worlds Awareness Day inputs" ?  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.place}",),
                                  ],
                                ),
                                Divider(
                                  // indent: 5,
                                  // endIndent: 5,
                                  color: colors.black54,
                                ),
                              ],
                            ):SizedBox.shrink(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Dr.Contact Email Id  :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                    Text("${getRequestModel!.data![index].json!.email}",),
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: colors.blackTemp.withOpacity(0.4))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Message for Pharma Company :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                        Text("${getRequestModel!.data![index].json!.message}",),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                      )

                  ],
                ),
              ),
            ):SizedBox.shrink(),
          );
        },
      ),
    );


  }
  button(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors.primary
        ),
        child: Center(child: Text("Doctor's Request to Pharma Compaines",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 18),)),
      ),
    );
  }
  getSlider(){
    return  Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 200,
          width: double.maxFinite,
          child: _sliderModel == null? const Center(child: CircularProgressIndicator(
            color: colors.primary,
          )):_CarouselSlider(),
        ),
        Positioned(
          bottom: 20,
          // left: 80,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  _buildDots(),),
        ),

      ],

    );
  }
  int _currentPost =  0;
  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < (_sliderModel?.data?.length ?? 10); i++) {
      dots.add(
        Container(
          margin: EdgeInsets.all(1.5),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPost == i
                ? colors.primary
                : colors.secondary.withOpacity(0.4)
            // Colors.grey.withOpacity(0.5),
          ),
        ),
      );
    }
    return dots;
  }
  _CarouselSlider(){
    return CarouselSlider(
      options: CarouselOptions(
          onPageChanged: (index, result) {
            setState(() {
              _currentPost = index;
            });
          },
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,

          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration:
          Duration(milliseconds: 500),
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          height: 200.0),
      items: _sliderModel?.data?.map((item) {
        return CommonSlider(file: item.image ?? '', link: item.link ?? '');
      }).toList(),
    );

  }
  GetSliderModel? _sliderModel ;
  getSliderApi() async {
    String type = '/doctor_news_slide';
    var headers = {
      'Cookie': 'ci_session=2c9c44fe592a74acad0121151a1d8648d7a78062'
    };
    var request = http.Request('GET', Uri.parse('${ApiService.getSlider}$type'));
    request.headers.addAll(headers);
    print("fieldss===========>${request.url}");
    http.StreamedResponse response = await request.send();
    print("response.statusCode===========>${response.statusCode}");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========>${result}");
      final finalResult = GetSliderModel.fromJson(json.decode(result));
      print("this is a response===========>${finalResult}");
      setState(() {
        _sliderModel = finalResult;

      });
    } else {
      print(response.reasonPhrase);
    }
  }
  GetRequestModel ? getRequestModel;
  getRequestApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userId');
    String? specialityId = preferences.getString('specialityId');
    String? localId = preferences.getString('LocalId');
    var headers = {
      'Cookie': 'ci_session=c09a9cb1d96b25ad537166ce10be5c5b1dfd73b0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getRequestApi}'));
    request.fields.addAll({
      'user_id': userId.toString(),
      'speciality_id': localId == null || localId == '' ? specialityId ?? '' : localId.toString()
    });
    print('____request.fields______${request.fields}_________');

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result = await response.stream.bytesToString();
     var finalResult = GetRequestModel.fromJson(json.decode(result));
     setState(() {
       getRequestModel = finalResult;
       print('__finalResult________${finalResult}_________');
     });
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
