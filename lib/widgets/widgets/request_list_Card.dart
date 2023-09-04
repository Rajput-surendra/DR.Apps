import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:doctorapp/New_model/Get_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/Color.dart';
import '../../api/api_services.dart';

class RequestListCard extends StatefulWidget {
  const RequestListCard({Key? key,required this.index, required this.i, this.getRequestModel,required this.onTop }) : super(key: key);

  final int index;
  final int i;
  final RequetDataList? getRequestModel;
  final VoidCallback onTop;


  @override
  State<RequestListCard> createState() => _RequestListCardState();
}

class _RequestListCardState extends State<RequestListCard> {


  GlobalKey keyList =GlobalKey() ;
  bool _isReady = true ;
  bool iconVisible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRole();
  }
  String? role;
  String? userIdNew;
  getRole()async{
    print('______userId_______${userIdNew}___');

    SharedPreferences preferences  = await  SharedPreferences.getInstance();
    role = preferences.getString("roll");
    userIdNew = preferences.getString('userId');
    print('______userId_______${userIdNew}___');
  }
  @override
  Widget build(BuildContext context) {
    print('___ggggggggggggg____________${widget.getRequestModel?.userId}');

    return   RepaintBoundary(
      key: keyList,
      child: _isReady ? Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child:
               Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                          child:  widget.getRequestModel?.userImage == null ? Container(
                              height: 70,
                              width: 70  ,
                              child: CircleAvatar()):ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                                color: colors.blackTemp,

                                height: 70,
                                width: 70,
                                child: Image.network("${widget.getRequestModel?.userImage}")),
                          )
                      ),
                      SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Dr.${widget.getRequestModel?.name}",style: TextStyle(
                              color: colors.secondary,fontWeight: FontWeight.bold
                          ),),
                          Text("Degree-${widget.getRequestModel?.docDigree}",style: TextStyle(color: colors.blackTemp),),
                         Text("${widget.getRequestModel?.cityName}",style: TextStyle(color: colors.blackTemp),),

                        ],
                      ),
                      SizedBox(width: 50,),

                    ],
                  ),
                  iconVisible ? Row(
                    children: [
                      // IconButton(onPressed: (){
                      //
                      //
                      // }, icon:
                      InkWell(onTap: (){
                        setState(() {
                          iconVisible = false;
                        });
                        Future.delayed(Duration(milliseconds: 500), (){
                          _shareQrCode(text : '',context: widget.getRequestModel!.userImage! ?? "" );
                        });
                      },
                          child: Icon(Icons.share)),
                      IconButton(
                          onPressed: (){
                            setState(() {
                              wishListApi(widget.getRequestModel?.id ?? '', );
                              widget.getRequestModel?.isSelected = !(widget.getRequestModel?.isSelected ?? false );
                            });
                          },icon: widget.getRequestModel?.isFavorite ?? false ?
                      Icon(Icons.favorite,color: colors.red,): widget.getRequestModel?.isSelected ?? false
                          ?Icon(Icons.favorite,color: colors.red,) :
                      Icon(Icons.favorite_outline,color: colors.blackTemp,)),
                      if(userIdNew == widget.getRequestModel!.userId)
                        InkWell(
                            onTap: widget.onTop,
                            child: Icon(Icons.delete))
                    ],
                  ):SizedBox.shrink()
                  // SizedBox(width: MediaQuery.of(context).size.width/7.5,),
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
                        widget.getRequestModel?.type == "Personalized Standy, Poster & Video" ?  Text("Request For Personalized :",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),):Text("Request for :",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                        widget.getRequestModel?.type ==  "Personalized Standy, Poster & Video" ? Text("${widget.getRequestModel?.json!.drPersonalized}",): widget.getRequestModel?.type  == "Awareness inputs" ?Text("${widget.getRequestModel?.json!.request}",):Text("${widget.getRequestModel?.json!.awarenessRequest}",)
                      ],
                    ),
                    Divider(
                      color: colors.black54,
                    ),

                    widget.getRequestModel?.type == "Personalized Standy, Poster & Video" ?SizedBox.shrink():  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mobile No :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                        Text("${widget.getRequestModel?.json!.mobileNo}",),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ),

                    widget.getRequestModel?.type  == "Personalized Standy, Poster & Video" ?
                    SizedBox.shrink():widget.getRequestModel?.type  == "Awareness inputs" ||
                        widget.getRequestModel?.type == "Worlds Awareness Day inputs" ?  SizedBox.shrink(): Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dr.Association Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.drAssociation}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ) ,
                    widget.getRequestModel?.type == "Event Invitation Designs" ?  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Event Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.eventName}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type == "Online Webinar Invitation Designs" ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.place}",),
                          ],
                        ),
                        Divider(
                          // indent: 5,
                          // endIndent: 5,
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type == "Worlds Awareness Day inputs" ?  SizedBox.shrink(): Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Topic :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.topic}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ) ,
                    widget.getRequestModel?.type  == "Personalized Standy, Poster & Video" ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dr. Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.drName}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),


                    widget.getRequestModel?.type  == "Personalized Standy, Poster & Video" ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Degree :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.docDigree}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),






                    widget.getRequestModel?.type == "Worlds Awareness Day inputs" ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Awarenes Day:",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.awarenessDay}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type == "CME Invitation Designs" ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Speaker Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.speakerName}",),
                            SizedBox(height: 3,),
                            Text("${widget.getRequestModel?.json!.degreeSpeakerName}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type == "CME Invitation Designs"  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Moderator Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.moderator}",),
                            SizedBox(height: 3,),
                            Text("${widget.getRequestModel?.json!.degreeModerator}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),

                    widget.getRequestModel?.type == "CME Invitation Designs" ||widget.getRequestModel?.type == "Event Invitation Designs" ||  widget.getRequestModel?.type == "Online Webinar Invitation Designs" ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.date}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type == "CME Invitation Designs" ||widget.getRequestModel?.type == "Event Invitation Designs" ||  widget.getRequestModel?.type == "Online Webinar Invitation Designs" ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Time :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.time}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type == "CME Invitation Designs" ?  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.place}",),
                          ],
                        ),
                        Divider(
                          // indent: 5,
                          // endIndent: 5,
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type == "Event Invitation Designs" ?  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.place}",),
                          ],
                        ),
                        Divider(
                          // indent: 5,
                          // endIndent: 5,
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type == "Online Webinar Invitation Designs" ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Speaker Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.speakerName}",),
                            SizedBox(height: 2,),
                            Text("${widget.getRequestModel?.json!.degreeSpeakerName}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type == "Online Webinar Invitation Designs"   ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Moderator :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.moderator}",),
                            Text("${widget.getRequestModel?.json!.degreeModerator}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type == "Event Invitation Designs" ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Conference Secretariat Dr Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.conference}",),
                            SizedBox.shrink(),
                            Text("${widget.getRequestModel?.json!.degreeConference}",),
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
                            Text("${widget.getRequestModel?.json!.clinicHospital}",),
                          ],
                        ),
                        Divider(
                          color: colors.black54,
                        ),
                      ],
                    ),
                    widget.getRequestModel?.type  == "Personalized Standy, Poster & Video" ?  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.place}",),
                          ],
                        ),
                        Divider(
                          // indent: 5,
                          // endIndent: 5,
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type  == "Personalized Standy, Poster & Video" ?  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dr.Photo Require On Input  :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.drPhoto}",),
                          ],
                        ),
                        Divider(
                          // indent: 5,
                          // endIndent: 5,
                          color: colors.black54,
                        ),
                      ],
                    ):SizedBox.shrink(),
                    widget.getRequestModel?.type == "Awareness inputs" || widget.getRequestModel?.type == "Worlds Awareness Day inputs" ?  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                            Text("${widget.getRequestModel?.json!.place}",),
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
                            Text("${widget.getRequestModel?.json!.email}",),
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
                                Text("${widget.getRequestModel?.json!.message}",),
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
      ):SizedBox.shrink()
    );
  }

  _shareQrCode({String? text, context}) async {
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
     Fluttertoast.showToast(msg: "This Permission is recommended",backgroundColor: colors.secondary);
    } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
      openAppSettings().then((value) {

      });
    }
    // ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('This Permission is recommended')));
  }

  wishListApi(String ? requestId) async {
    var headers = {
      'Cookie': 'ci_session=6f1de5370d8c25e7d0c07b421f024a150f5afda9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addWishlistApi}'));
    request.fields.addAll({
      'user_id': userIdNew.toString(),
      'request_id': requestId.toString()
    });
    print('_____request.fields_____${request.fields}_________');

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor: colors.secondary);
    }
    else {
      print(response.reasonPhrase);
    }

  }
}
