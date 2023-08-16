import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetWishListModel.dart';
import '../api/api_services.dart';
import 'package:http/http.dart' as http;

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  void initState() {
    getWishListApi(0);
    // TODO: implement initState
    super.initState();
  }

  int selectedSegmentVal = 1;
  downloadFile(String url, String filename, ) async {
    FileDownloader.downloadFile(
        url:  "${url}",
        //'https://completewomencares.com/public/upload/1686124273.pdf',
        name: "${filename}",
        onDownloadCompleted: (path) {
          print(path);
          String tempPath = path.toString().replaceAll("Download", "DR.Apps");
          final File file = File(tempPath);
          print("path here ${file}");
          //  setSnackbar("File Downloaded successfully!", context);
          var snackBar = SnackBar(
            backgroundColor: colors.secondary,
            content: Text('File Download Successfully'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //This will be the path of the downloaded file
        });
  }
  // downloadFile(String url, String filename) async {
  //   FileDownloader.downloadFile(
  //       url: "${url}",
  //       name: "${filename}",
  //       onDownloadCompleted: (path) {
  //         print(path);
  //         String tempPath = path.toString().replaceAll("Download", "doctorapp");
  //         final File file = File(tempPath);
  //         print("path here ${file}");
  //         var snackBar = SnackBar(
  //           backgroundColor: colors.primary,
  //           content: Row(
  //             children: [
  //               const Text('doctorapp Saved in your storage'),
  //               TextButton(onPressed: (){}, child: Text("View"))
  //
  //             ],
  //           ),
  //         );
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //         //This will be the path of the downloaded file
  //       });
  // }
  Future<String> createFolderInAppDocDir(String folderNames) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.accessMediaLocation,
      // Permission.manageExternalStorage,
      Permission.storage,
    ].request();
    // var manage = await Permission.manageExternalStorage.status;
    var media = await Permission.accessMediaLocation.status;
    if(media==PermissionStatus.granted){

      print(statuses[Permission.location]);
      final folderName = folderNames;
      final path= Directory("storage/emulated/0/$folderName");
      final path1 =  await getExternalStorageDirectory();
      print("ssdsds ${path1}");
      print("11111111111 ${path}");
      var status = await Permission.storage.status;
      print("mmmmmmmmmmm ${status} and ${status.isGranted}");
      if (!status.isGranted) {
        print("chacking status ${status.isGranted}");
        await Permission.storage.request();
      }
      print(" path here ${path} and ${await path.exists()}");
      if ((await path.exists())) {
        print("here path is ${path}");
        // var dir = await DownloadsPathProvider.
        print("ooooooooo and $path/$folderNames");
        return path.path;
      } else {
        print("here path is 1 ${path}");
        path.create();
        return path.path;
      }}else{
      print("permission denied");
    }
    return "";
  }

  Widget _segmentButton() => Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Container(
              //   height: 30,
              //   width: 100,
              //   decoration: ShapeDecoration(
              //       shape: const StadiumBorder(),
              //       gradient: LinearGradient(
              //           begin: Alignment.topCenter,
              //           end: Alignment.bottomCenter,
              //           colors: selectedSegmentVal == 0
              //               ? [colors.primary, colors.primary]
              //               : [Colors.transparent, Colors.transparent])),
              //   child: MaterialButton(
              //     shape: const StadiumBorder(),
              //     onPressed: () => setSegmentValue(0),
              //     child: Text(
              //       'News',
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 14,
              //           color: selectedSegmentVal == 0
              //               ? Colors.white
              //               : Colors.black),
              //     ),
              //   ),
              // ),
              Container(
                height: 30,
                width: 110,
                decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: selectedSegmentVal == 1
                            ? [colors.primary, colors.primary]
                            : [Colors.transparent, Colors.transparent])),
                child: MaterialButton(
                  shape: const StadiumBorder(),
                  onPressed: () => setSegmentValue(1),
                  child: Text(
                    "Dr.Requests",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: selectedSegmentVal == 1
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 100,
                decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: selectedSegmentVal == 2
                            ? [colors.primary, colors.primary]
                            : [Colors.transparent, Colors.transparent])),
                child: MaterialButton(
                  shape: const StadiumBorder(),
                  onPressed: () => setSegmentValue(2),
                  child: Text(
                    'Event',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: selectedSegmentVal == 2
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 95,
                decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: selectedSegmentVal == 3
                            ? [colors.primary, colors.primary]
                            : [Colors.transparent, Colors.transparent])),
                child: MaterialButton(
                  shape: const StadiumBorder(),
                  onPressed: () => setSegmentValue(3),
                  child: Text(
                    'Webinars',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: selectedSegmentVal == 3
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 110,
                decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: selectedSegmentVal == 4
                            ? [colors.primary, colors.primary]
                            : [Colors.transparent, Colors.transparent])),
                child: MaterialButton(
                  shape: const StadiumBorder(),
                  onPressed: () => setSegmentValue(4),
                  child: Text(
                    'Awareness',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: selectedSegmentVal == 4
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),

            ],
          ),
        ),
      );
  setSegmentValue(int i) {
    selectedSegmentVal = i;
    String status;
    if (i == 0) {
      status = 'Ongoing';
    } else if (i == 1) {
      status = 'Complete';
    }
    setState(() {
      getWishListApi(i);
    });
    // getOrderList(status: status);
  }
  int _currentIndex = 1;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
          context: context,
          text: "WishList",
          isTrue: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _segmentButton(),
              SizedBox(
                  // height: MediaQuery.of(context).size.height/1.0,
                  child: getWishListModel?.data == null ||
                          getWishListModel?.data == ""
                      ? Center(child: CircularProgressIndicator())
                      : selectedSegmentVal == 1 ? getWishListModel?.data?.requests?.isEmpty ?? true ? Center(child: Text('Request not available'),) :
                      ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.requests?.length,
                      itemBuilder: (BuildContext context, int index) {
                           return  newCustomCards(getWishListModel, index);
                      })

                      : selectedSegmentVal == 2 ? getWishListModel?.data?.event?.isEmpty ?? true ? Center(child: Text('Event not available'),) :
                  ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.event?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  eventCustomCards(getWishListModel, index);
                      })

                      :  selectedSegmentVal == 3 ? getWishListModel?.data?.webinar?.isEmpty ?? true ? Center(child: Text('Webiner not available'),) :
                  ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.webinar?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  webinarsCustomCards(getWishListModel, index);
                      })

                  //     :  selectedSegmentVal == 3 ? getWishListModel?.data?.editorial?.isEmpty ?? true ? Center(child: Text('Editorial not available'),) :
                  // ListView.builder(
                  //   // scrollDirection: Axis.vertical,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     reverse: true,
                  //     itemCount: getWishListModel?.data?.editorial?.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return   editorialCustomCards();
                  //     })

                      : selectedSegmentVal == 4 ? getWishListModel?.data?.awareness?.isEmpty ?? true ? Center(child: Text('Awareness not available'),) :
                  ListView.builder(
                    // scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: getWishListModel?.data?.awareness?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return awarenessCustomCards(context ,index);
                      }) :SizedBox.shrink()
              )


            ],
          ),
        ));
  }

  requestWishListRemoveApi(String ? requestId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
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
        Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor: colors.secondary);
        getWishListApi(1);
      }
      else {
        print(response.reasonPhrase);
      }

  }
  removeWishListApi(String id, int i) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? Roll = preferences.getString('roll');
    print("getEventUserId--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=9516fbdbc1268c93318355a5c0da4a6841deb646'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getRemoveWishListApi}'));
    request.fields.addAll(
        {
          'user_id': '$userId',
          "prod_id": "$id"
        });
    print("getEventUserId-------1111111-------->${request.fields}");

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final finalResult = json.decode(result);
      print("thi os ojon==========>${finalResult}");
      getWishListApi(i);
      Fluttertoast.showToast(msg: finalResult['message'],backgroundColor: colors.secondary);
    } else {
      print(response.reasonPhrase);
    }
  }
  GetWishListModel? getWishListModel;
  getWishListApi(int i) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? Roll = preferences.getString('roll');
    print("getEventUserId--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=579af58e6f03e48e089abbbe963a0b6ff69888d3'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getNewsWishListApi}'));
    request.fields.addAll({
      'user_id': '$userId',
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final finalResult = GetWishListModel.fromJson(jsonDecode(result));
      setState(() {
        getWishListModel = finalResult;

      });
    } else {
      print(response.reasonPhrase);
    }
  }

  newCustomCards(model, int index) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _currentIndex == 1
                    ? Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                              child:  getWishListModel!.data!.requests![index].userImage == null ? Container(
                                  height: 70,
                                  width: 70  ,
                                  child: CircleAvatar()):ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                    color: colors.blackTemp,

                                    height: 70,
                                    width: 70,
                                    child: Image.network("${getWishListModel!.data!.requests![index].userImage}")),
                              )
                          ),
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Dr.${getWishListModel!.data!.requests![index].name}",style: TextStyle(
                                  color: colors.secondary,fontWeight: FontWeight.bold
                              ),),
                              Text("Degree-${getWishListModel!.data!.requests![index].docDigree}",style: TextStyle(color: colors.blackTemp),),

                            ],
                          ),
                          SizedBox(width: 95,),
                            Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: ListView(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          shrinkWrap: true,
                                          children: ['Remove from wishlist']
                                              .map(
                                                (e) => InkWell(
                                              onTap: () async {
                                                requestWishListRemoveApi(
                                                    getWishListModel
                                                        ?.data?.requests![index].id ??
                                                        "", );
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                  vertical: 12,
                                                  horizontal: 16,
                                                ),
                                                child: Text(e),
                                              ),
                                            ),
                                          )
                                              .toList(),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.more_vert_rounded))
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Request for :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                              getWishListModel!.data!.requests![index].type  == "Awareness inputs" ?Text("${getWishListModel!.data!.requests![index].json!.request}",):Text("${getWishListModel!.data!.requests![index].json!.awarenessRequest}",)
                            ],
                          ),
                          Divider(
                            color: colors.black54,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mobile No :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                              Text("${getWishListModel!.data!.requests![index].json!.mobileNo}",)
                            ],
                          ),
                          Divider(
                            color: colors.black54,
                          ),
                          getWishListModel!.data!.requests![index].type  == "Awareness inputs" ||  getWishListModel!.data!.requests![index].type == "Worlds Awareness Day inputs" ?  SizedBox.shrink(): Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Dr.Association Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.drAssociation}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ) ,
                          getWishListModel!.data!.requests![index].type == "Event Invitation Designs" ?  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Event Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.eventName}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getWishListModel!.data!.requests![index].type == "Online Webinar Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.place}",),
                                ],
                              ),
                              Divider(
                                // indent: 5,
                                // endIndent: 5,
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getWishListModel!.data!.requests![index].type == "Worlds Awareness Day inputs" ?  SizedBox.shrink(): Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Topic :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.topic}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ) ,

                          getWishListModel!.data!.requests![index].type == "Worlds Awareness Day inputs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Awarenes Day:",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.awarenessDay}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getWishListModel!.data!.requests![index].type == "CME Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Speaker Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.speakerName}",),
                                  SizedBox(height: 3,),
                                  Text("${getWishListModel!.data!.requests![index].json!.degreeSpeakerName}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getWishListModel!.data!.requests![index].type == "CME Invitation Designs"  ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Moderator Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.moderator}",),
                                  SizedBox(height: 3,),
                                  Text("${getWishListModel!.data!.requests![index].json!.degreeModerator}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),

                          getWishListModel!.data!.requests![index].type == "CME Invitation Designs" ||getWishListModel!.data!.requests![index].type == "Event Invitation Designs" ||  getWishListModel!.data!.requests![index].type == "Online Webinar Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.date}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getWishListModel!.data!.requests![index].type == "CME Invitation Designs" ||getWishListModel!.data!.requests![index].type == "Event Invitation Designs" ||  getWishListModel!.data!.requests![index].type == "Online Webinar Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Time :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.time}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getWishListModel!.data!.requests![index].type == "CME Invitation Designs" ?  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.place}",),
                                ],
                              ),
                              Divider(
                                // indent: 5,
                                // endIndent: 5,
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getWishListModel!.data!.requests![index].type == "Event Invitation Designs" ?  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.place}",),
                                ],
                              ),
                              Divider(
                                // indent: 5,
                                // endIndent: 5,
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getWishListModel!.data!.requests![index].type == "Online Webinar Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Speaker Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.speakerName}",),
                                  SizedBox(height: 2,),
                                  Text("${getWishListModel!.data!.requests![index].json!.degreeSpeakerName}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getWishListModel!.data!.requests![index].type == "Online Webinar Invitation Designs"   ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Moderator :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.moderator}",),
                                  Text("${getWishListModel!.data!.requests![index].json!.degreeModerator}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getWishListModel!.data!.requests![index].type == "Event Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Conference Secretariat Dr Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.conference}",),
                                  SizedBox.shrink(),
                                  Text("${getWishListModel!.data!.requests![index].json!.degreeConference}",),
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
                                  Text("${getWishListModel!.data!.requests![index].json!.clinicHospital}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ),
                          getWishListModel!.data!.requests![index].type == "Awareness inputs" || getWishListModel!.data!.requests![index].type == "Worlds Awareness Day inputs" ?  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getWishListModel!.data!.requests![index].json!.place}",),
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
                                  Text("${getWishListModel!.data!.requests![index].json!.email}",),
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
                                      Text("${getWishListModel!.data!.requests![index].json!.message}",),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          )

                        ],
                      )

                    ],
                  ),
                )
                    : SizedBox(),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           width: 310,
                //           child: Text('${getWishListModel?.data?.news![i].title}',overflow: TextOverflow.ellipsis,)),
                //         Container(
                //             width: 310,
                //             child: Text('${getWishListModel?.data?.news![i].description}',overflow: TextOverflow.ellipsis,)),
                //       ],
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
    );
  }
  List? strObjWeb;
  eventCustomCards(model, int i) {
    strObjWeb = getWishListModel!.data!.event![i].image?.split(".");
    print('_____saaaaaaaasxsssssadasdadasdadawrwerraaaaaaaa_____${strObjWeb![2]}_________');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _currentIndex == 1
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                         Padding(
                          padding:
                          const EdgeInsets.only(top: 5, bottom: 8),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "${getWishListModel?.data?.event![i].userImage}"),
                            backgroundColor: colors.primary,
                            radius: 25,
                          ),
                        ), //CircleAvatar
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: getWishListModel!.data!.event!.isEmpty
                              ? Center(child: CircularProgressIndicator())
                              : Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getWishListModel?.data?.event![i].userName}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colors.secondary,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "${getWishListModel?.data?.event![i].userDigree}",
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                  child: Text(
                                    "${getWishListModel?.data?.event![i].userAddress}",
                                    style: TextStyle(fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shrinkWrap: true,
                                    children: ['Remove from wishlist']
                                        .map(
                                          (e) => InkWell(
                                        onTap: () async {
                                          removeWishListApi(
                                              getWishListModel
                                                  ?.data?.event![i].id ??
                                                  "", 1);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                            vertical: 12,
                                            horizontal: 16,
                                          ),
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.more_vert_rounded))
                      ],
                    )
                  ],
                )
                    : SizedBox(),
                strObjWeb![2] == "pdf" ? Column(
                  children: [

                    InkWell(
                      onTap: (){
                        downloadFile('${getWishListModel?.data?.event![i].image}', getWishListModel?.data?.event![i].title ?? '');
                      } ,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            width: 55,
                            height: 55 ,
                            child: Column(
                              children: [
                                Icon(Icons.download,size: 35,color: colors.secondary,),
                                Text("pdf")
                              ],
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: (){
                            viewFile(getWishListModel?.data?.event![i].image ??  "", "File");
                          },
                          child: Text("VIEW PDF",style: TextStyle(color: colors.secondary),)),
                    ),
                  ],
                ): Container(
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: getWishListModel?.data?.event![i].image == null ||
                          getWishListModel?.data?.event![i].image == ""
                          ? Image.asset("assets/splash/splashimages.png")
                          : Image.network(
                        "${getWishListModel?.data?.event![i].image}",
                        fit: BoxFit.fill,
                        height: 250,
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 310,
                            child: Text('${getWishListModel?.data?.event![i].title}',overflow: TextOverflow.ellipsis,)),
                        Container(
                            width: 310,
                            child: Text('${getWishListModel?.data?.event![i].description}',overflow: TextOverflow.ellipsis,)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(

                  height: 10,
                )
              ],
            ),
          )),
    );
  }
  Future<void>  displayPDF(String url) async {
    Dio dio = Dio();
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String appDocPath = directory.path;
      String fileName = 'document.pdf';
      String filePath = '$appDocPath/$fileName';
      await dio.download(url, filePath);
      // Open PDF using FlutterPdfView plugin
      if (await File(filePath).exists()) {
        print('This is file path is here------${filePath}');
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: customAppBar(context: context, text: "View Pdf", isTrue: true, ),
              body: PDFView(
                filePath: filePath,
              ),
            ),
          ),
        );
      } else {
        print('Failed to download the PDF file.');
      }
    } catch (e) {
      print('Error occurred while downloading the PDF: $e');
    }
  }

  viewFile(String url, String filename) async {
    FileDownloader.downloadFile(
        url:  "${url}",
        //'https://completewomencares.com/public/upload/1686124273.pdf',
        name: "${filename}",
        onDownloadCompleted: (path) {
          print(path);
          String tempPath = path.toString().replaceAll("Download", "DR.Apps");
          final File file = File(tempPath);
          print("path here ${file}");
          displayPDF(url);
          //  setSnackbar("File Downloaded successfully!", context);
          Fluttertoast.showToast(msg: "File View successfully!",backgroundColor: colors.secondary);
          // var snackBar = SnackBar(
          //   backgroundColor: colors.primary,
          //   // content: Text('File Download Successfully '),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //This will be the path of the downloaded file
        });
  }
  List? strObj;
  // webinarsCustomCards(){
  //   strObj  = getWishListModel!.data!.webinar!.first.image!.split(".");
  //   print('__SASASASASSASAS________${strObj![2]}_________');
  //
  //  return Column(
  //    children: [
  //      SizedBox(
  //        child: getWishListModel?.data == null ? Center(child: CircularProgressIndicator())  : getWishListModel?.data?.webinar!.isEmpty ?? false ? Text("Not Approved by Admin"):
  //        ListView.builder(
  //            scrollDirection: Axis.vertical,
  //            physics: NeverScrollableScrollPhysics(),
  //            shrinkWrap: true,
  //            reverse: true,
  //            itemCount: getWishListModel!.data!.webinar!.length,
  //            itemBuilder: (BuildContext context, int index) {
  //              return  Card(
  //                elevation: 5,
  //                child: Column(
  //                  children: <Widget>[
  //                    Container(
  //                      height: 30,
  //                      width:MediaQuery.of(context).size.width/1.0,
  //                      decoration: BoxDecoration(
  //                          color: Colors.red,
  //                          borderRadius: BorderRadius.only(topLeft: Radius.circular(11),topRight: Radius.circular(11))),
  //                      child: Row(
  //                        mainAxisAlignment: MainAxisAlignment.center,
  //                        children: [
  //                          Text('${getWishListModel?.data!.webinar![index].startDate.toString().substring(0,10)}',style: TextStyle(color: Colors.white,fontSize: 15),),
  //                          SizedBox(width: 20,),
  //                          Padding(
  //                            padding: const EdgeInsets.only(top: 5,bottom: 5),
  //                            child: VerticalDivider(thickness: 1,color: colors.whiteTemp,),
  //                          ),
  //                          SizedBox(width: 20,),
  //                          Text('${getWishListModel?.data!.webinar![index].fromTime}',style: TextStyle(color: Colors.white,fontSize: 15),),
  //                        ],
  //                      ),
  //                    ),
  //                    SizedBox(height: 10,),
  //                    Row(
  //                      mainAxisAlignment: MainAxisAlignment.start,
  //                      crossAxisAlignment: CrossAxisAlignment.start,
  //                      children: [
  //                        // Image.asset("assets/splash/splashimages.png",height: 100,width: 100,),
  //                        strObj![2] == "pdf" ? Column(
  //                          children: [
  //
  //                            InkWell(
  //                              onTap: (){
  //                                downloadFile('${getWishListModel?.data?.webinar?[index].image}', getWishListModel?.data?.webinar?[index].title ?? '');
  //                              } ,
  //                              child: Align(
  //                                alignment: Alignment.center,
  //                                child: Container(
  //                                    width: 90,
  //                                    height: 56 ,
  //                                    child: Column(
  //                                      children: [
  //                                        Icon(Icons.download,size: 35,color: colors.secondary,),
  //                                        Text("pdf")
  //                                      ],
  //                                    )
  //                                ),
  //                              ),
  //                            ),
  //                            SizedBox(height: 10,),
  //                            Align(
  //                              alignment: Alignment.center,
  //                              child: InkWell(
  //                                  onTap: (){
  //                                    viewFile(getWishListModel?.data?.webinar?[index].image  ?? " ", "File");
  //                                  },
  //                                  child: Text("VIEW PDF",style: TextStyle(color: colors.secondary),)),
  //                            ),
  //                          ],
  //                        ):
  //                          Padding(
  //                            padding: const EdgeInsets.all(8.0),
  //                            child: Container(
  //                                width: 80,
  //                                height: 80 ,
  //                              child: Image.network('${getWishListModel!.data!.webinar![index].image},',height: 80,width:80,),
  //                            ),
  //                          ),
  //                        SizedBox(width: 10,),
  //                        Column(
  //                          crossAxisAlignment: CrossAxisAlignment.start,
  //                          children: [
  //                            Row(
  //                              children: [
  //
  //                                Text('${getWishListModel?.data!.webinar![index].title}',style: TextStyle(fontSize: 14,color: colors.secondary),),
  //                                const SizedBox(width: 150,),
  //                                Row(
  //                                  children: [
  //                                    IconButton(
  //                                        onPressed: () {
  //                                          showDialog(
  //                                            context: context,
  //                                            builder: (context) => Dialog(
  //                                              child: ListView(
  //                                                padding: const EdgeInsets.symmetric(
  //                                                  vertical: 16,
  //                                                ),
  //                                                shrinkWrap: true,
  //                                                children: ['Remove from wishlist']
  //                                                    .map(
  //                                                      (e) => InkWell(
  //                                                    onTap: () async {
  //                                                      removeWishListApi(
  //                                                          getWishListModel
  //                                                              ?.data?.webinar![index].id ??
  //                                                              "", 2);
  //                                                      Navigator.of(context).pop();
  //                                                    },
  //                                                    child: Container(
  //                                                      padding: const EdgeInsets
  //                                                          .symmetric(
  //                                                        vertical: 12,
  //                                                        horizontal: 16,
  //                                                      ),
  //                                                      child: Text(e),
  //                                                    ),
  //                                                  ),
  //                                                )
  //                                                    .toList(),
  //                                              ),
  //                                            ),
  //                                          );
  //                                        },
  //                                        icon: Icon(Icons.more_vert_rounded))
  //                                  ],
  //                                ),
  //                              ],
  //                            ),
  //                            SizedBox(height: 3),
  //                            Text('${getWishListModel?.data!.webinar![index].userName}',style: TextStyle(fontSize: 10,),),
  //                            SizedBox(height: 3),
  //                            // Text('${getWishListModel?.data!.webinar![index].userDigree}',style: TextStyle(fontSize: 10,),),
  //                            SizedBox(height: 3),
  //                            Text('${getWishListModel?.data!.webinar![index].userAddress}',style: TextStyle(fontSize: 10,),),
  //                            SizedBox(height: 3),
  //                            Text('${getWishListModel?.data!.webinar![index].description}',style: TextStyle(fontSize: 10,),),
  //                            SizedBox(height: 10,),
  //                            Row(
  //                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                              children: [
  //                                Container(
  //                                  height: 25,
  //                                  child: ElevatedButton(
  //                                      onPressed: (){
  //                                        launch('${getWishListModel?.data!.webinar![index].link}');
  //                                      },
  //                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
  //                                      child: Text('Live link',style: TextStyle(color: Colors.white,fontSize: 10),)),
  //                                ),
  //                                SizedBox(width: 10),
  //                                Container(
  //                                  height: 25,
  //                                  child: ElevatedButton(onPressed: (){
  //                                    downloadFile('${getWishListModel?.data!.webinar![index].image}', getWishListModel?.data!.webinar![index].userName??'');
  //                                  },
  //                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
  //                                      child: Text('Detail PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
  //                                ),
  //                                // Row(
  //                                //   children: [
  //                                //     IconButton(onPressed: (){
  //                                //       setState(() {
  //                                //         getNewWishlistApi(webinarModel?.data[index].id??'');
  //                                //         webinarModel?.data[index].isSelected = !(webinarModel?.data[index].isSelected ?? false );
  //                                //       });
  //                                //     },icon: webinarModel?.data[index].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,))
  //                                //   ],
  //                                // )
  //                              ],
  //                            ),
  //                            SizedBox(height: 20,)
  //
  //                          ],
  //                        ),
  //                      ],
  //                    ),
  //
  //                  ],
  //                ),
  //              );
  //            }),
  //      ),
  //    ],
  //  );
  // }
  webinarsCustomCards(model,int i){
    strObj  = getWishListModel!.data!.webinar![i].image?.split(".");
    print('_____saaaaaaaasxsssssadasdadasdadawrwerraaaaaaaa_____${strObj![2]}_________');
    return Column(
      children: [
        SizedBox(
            child: getWishListModel?.data == null ? Center(child: CircularProgressIndicator()):getWishListModel?.data?.webinar!.isEmpty ?? false ? Text("Not Approved by Admin"):
            Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 30,
                    width:MediaQuery.of(context).size.width/1.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(11),topRight: Radius.circular(11))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${getWishListModel?.data!.webinar![i].startDate.toString().substring(0,10)}',style: TextStyle(color: Colors.white,fontSize: 15),),
                        SizedBox(width: 20,),
                        Padding(
                          padding: const EdgeInsets.only(top: 5,bottom: 5),
                          child: VerticalDivider(thickness: 1,color: colors.whiteTemp,),
                        ),
                        SizedBox(width: 20,),
                        Text('${getWishListModel?.data!.webinar![i].fromTime}',style: TextStyle(color: Colors.white,fontSize: 15),),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                strObj![2] == "pdf" ? Column(
                                  children: [

                                    InkWell(
                                      onTap: (){
                                        downloadFile('${getWishListModel?.data?.webinar![i].image}', getWishListModel?.data?.webinar![i].title ?? '');
                                      } ,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                            width: 55,
                                            height: 55 ,
                                            child: Column(
                                              children: [
                                                Icon(Icons.download,size: 35,color: colors.secondary,),
                                                Text("pdf")
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Align(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                          onTap: (){
                                            viewFile(getWishListModel?.data?.webinar![i].image ??  "", "File");
                                          },
                                          child: Text("VIEW PDF",style: TextStyle(color: colors.secondary),)),
                                    ),
                                  ],
                                )   : Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: ClipRRect(
                                        borderRadius:  BorderRadius.circular(10),
                                        child: Image.network("${getWishListModel!.data!.webinar![i].image}",height: 120,width: 80,))),
                                SizedBox(width: 10,),

                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        Text("${getWishListModel!.data!.webinar![i].title}",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 16),),
                                        SizedBox(height: 3,),
                                        Text("${getWishListModel!.data!.webinar![i].topic}"),
                                        SizedBox(height: 3,),
                                        Text("${getWishListModel!.data!.webinar![i].moderator}"),
                                        SizedBox(height: 3,),
                                        Text("${getWishListModel!.data!.webinar![i].speaker}"),
                                        SizedBox(height: 3,),
                                        Text("${getWishListModel!.data!.webinar![i].title}"),

                                      ],
                                    )
                                )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: ListView(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            shrinkWrap: true,
                                            children: ['Remove from wishlist']
                                                .map(
                                                  (e) => InkWell(
                                                onTap: () async {
                                                  removeWishListApi(
                                                      getWishListModel
                                                          ?.data?.webinar!.first.id ??
                                                          "", 3);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 16,
                                                  ),
                                                  child: Text(e),
                                                ),
                                              ),
                                            )
                                                .toList(),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.more_vert_rounded))
                              ],
                            )

                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              child: ElevatedButton(
                                  onPressed: (){
                                    launch('${getWishListModel?.data!.webinar![i].link}');
                                  },
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                  child: Text('Live link',style: TextStyle(color: Colors.white,fontSize: 10),)),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 25,
                              child: ElevatedButton(onPressed: (){
                                downloadFile('${getWishListModel?.data!.webinar![i].image}', getWishListModel?.data!.webinar![i].userName??'');
                              },
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                  child: Text('Detail PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
                            ),
                            // Row(
                            //   children: [
                            //     IconButton(onPressed: (){
                            //       setState(() {
                            //         getNewWishlistApi(webinarModel?.data[index].id??'');
                            //         webinarModel?.data[index].isSelected = !(webinarModel?.data[index].isSelected ?? false );
                            //       });
                            //     },icon: webinarModel?.data[index].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,))
                            //   ],
                            // )
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,)


                ],
              ),
            )
        ),
      ],
    );
  }
  // editorialCustomCards(){
  //  return Column(
  //    children: [
  //      SizedBox(
  //        child: getWishListModel!.data!.editorial == null ? Center(child: CircularProgressIndicator())  : getWishListModel!.data!.editorial!.isEmpty?? false ? Text("Not Approved by Admin"):
  //        ListView.builder(
  //            scrollDirection: Axis.vertical,
  //            physics: NeverScrollableScrollPhysics(),
  //            shrinkWrap: true,
  //            itemCount: getWishListModel!.data!.editorial!.length,
  //            itemBuilder: (BuildContext context, int index) {
  //              return Card(
  //                  elevation: 5,
  //                  child: Column(
  //                    crossAxisAlignment: CrossAxisAlignment.start,
  //                    children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(left: 15,top: 5),
  //                           child: Text("${getWishListModel!.data!.editorial![index].date?.substring(0,10)}",style: TextStyle(fontSize: 15,color: colors.secondary)),
  //                         ),
  //                         Row(
  //                           children: [
  //                             IconButton(
  //                                 onPressed: () {
  //                                   showDialog(
  //                                     context: context,
  //                                     builder: (context) => Dialog(
  //                                       child: ListView(
  //                                         padding: const EdgeInsets.symmetric(
  //                                           vertical: 16,
  //                                         ),
  //                                         shrinkWrap: true,
  //                                         children: ['Remove from wishlist']
  //                                             .map(
  //                                               (e) => InkWell(
  //                                             onTap: () async {
  //                                               removeWishListApi(
  //                                                   getWishListModel
  //                                                       ?.data?.editorial!.first.id ??
  //                                                       "", 3);
  //                                               Navigator.of(context).pop();
  //                                             },
  //                                             child: Container(
  //                                               padding: const EdgeInsets
  //                                                   .symmetric(
  //                                                 vertical: 12,
  //                                                 horizontal: 16,
  //                                               ),
  //                                               child: Text(e),
  //                                             ),
  //                                           ),
  //                                         )
  //                                             .toList(),
  //                                       ),
  //                                     ),
  //                                   );
  //                                 },
  //                                 icon: Icon(Icons.more_vert_rounded))
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                      Divider(thickness: 1,color: colors.black54.withOpacity(0.2),),
  //                      Row(
  //                        mainAxisAlignment: MainAxisAlignment.start,
  //                        crossAxisAlignment: CrossAxisAlignment.start,
  //                        children: [
  //
  //                          Padding(
  //                            padding: const EdgeInsets.all(8.0),
  //                            child: ClipRRect(
  //                                borderRadius: BorderRadius.circular(20),
  //                                child: Image.network('${getWishListModel!.data!.editorial![index].userImage}',height: 90,width:100,)),
  //                          ),
  //                          Padding(
  //                            padding: const EdgeInsets.only(top: 10),
  //                            child: Column(
  //                              crossAxisAlignment: CrossAxisAlignment.start,
  //                              children: [
  //                                Text('${getWishListModel!.data!.editorial![index].title}',style: TextStyle(fontSize: 14,color: colors.blackTemp,fontWeight: FontWeight.bold),),
  //                                SizedBox(height: 2),
  //                                Text('${getWishListModel!.data!.editorial![index].userDigree}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
  //                                SizedBox(height: 2),
  //                                Text('${getWishListModel!.data!.editorial![index].userAddress}',style: TextStyle(fontSize: 10,color: colors.blackTemp),),
  //                                SizedBox(height: 2),
  //                                SizedBox(height: 15,),
  //
  //                                Row(
  //                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                  children: [
  //                                    Text('Dr. ${getWishListModel!.data!.editorial![index].userName}',style: TextStyle(fontSize: 10,color: colors.secondary),),
  //                                    SizedBox(width: 10,),
  //                                    Container(
  //                                      height: 25,
  //                                      child: ElevatedButton(onPressed: (){
  //                                         downloadFile('${getWishListModel!.data!.editorial![index].image}', getWishListModel!.data!.editorial![index].userName??'');
  //                                      },
  //                                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
  //                                          child: Text('Detail PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
  //                                    ),
  //                                    SizedBox(width: 20,),
  //                                    // IconButton(onPressed: (){
  //                                    //   setState(() {
  //                                    //     isSelected =!isSelected;
  //                                    //   });
  //                                    // },icon: isSelected ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,))
  //                                  ],
  //                                ),
  //                                SizedBox(height: 20,)
  //                              ],
  //                            ),
  //                          ),
  //                        ],
  //                      ),
  //                    ],
  //                  )
  //
  //
  //              );
  //            }),
  //      ),
  //    ],
  //  );
  // }
  // awarenessCustomCards(){
  //  return Column(
  //    children: [
  //      // SizedBox(
  //      //   height: 50,
  //      //   child:  aaaaaModel?.data == null ? Center(child: CircularProgressIndicator())  : aaaaaModel?.data?.isEmpty?? false ? Text("Not Approved by Admin"):
  //      //   ListView.builder(
  //      //       scrollDirection: Axis.horizontal,
  //      //       shrinkWrap: true,
  //      //       itemCount: aaaaaModel!.data!.length,
  //      //       itemBuilder: (BuildContext context, int index) {
  //      //         return
  //      //           Padding(
  //      //             padding: const EdgeInsets.only(left: 8,top: 10,right: 8),
  //      //             child: InkWell(
  //      //               onTap: (){
  //      //                 setState(() {
  //      //                   //getNewListApi();
  //      //                   _currentIndex = index;
  //      //                 });
  //      //                 print("this is curent index ${_currentIndex.toString()}");
  //      //               },
  //      //               child:
  //      //               Container(
  //      //                 padding: EdgeInsets.only(left: 15,right: 15),
  //      //                 height: 50,
  //      //                 width: 85,
  //      //                 //width: MediaQuery.of(context).size.width/3.5,
  //      //                 decoration: BoxDecoration(
  //      //                     color: _currentIndex ==  index ?
  //      //                     colors.secondary
  //      //                         : colors.primary.withOpacity(0.2),
  //      //                     borderRadius: BorderRadius.circular(5)
  //      //                 ),
  //      //                 child: Center(
  //      //                   child: Text("${aaaaaModel!.data![index].title}",style: TextStyle(color: _currentIndex == index ?colors.whiteTemp:colors.blackTemp)),
  //      //                 ),
  //      //               ),
  //      //             ),
  //      //
  //      //           );
  //      //       }),
  //      // ),
  //    ],
  //  );
  // }
  awarenessCustomCards(model, int i){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _currentIndex == 1
                //     ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            //CircleAvatar
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: getWishListModel!.data!.awareness!.isEmpty
                                  ? Center(child: CircularProgressIndicator())
                                  : Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getWishListModel?.data?.awareness![i].title}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: colors.secondary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("${getWishListModel?.data?.awareness![i].awareLanguage}",),


                                ],
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shrinkWrap: true,
                                    children: ['Remove from Awareness']
                                        .map(
                                          (e) => InkWell(
                                        onTap: () async {

                                          removeWishListApi(
                                              getWishListModel
                                                  ?.data?.awareness!.first.id ??
                                                  "", 0);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                            vertical: 12,
                                            horizontal: 16,
                                          ),
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.more_vert_rounded))
                      ],
                    )
                  ],
                ),

                // : SizedBox(),
                Container(
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child:  Image.network(
                        "${getWishListModel?.data?.awareness![i].image}",
                        fit: BoxFit.fill,
                        height: 250,
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${getWishListModel?.data?.awareness![i].awareInput}",),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
    );
  }
  productCustomCards(){
   return Column(
     children: const [
       Text("productCustomCards")
     ],
   );
  }

}
