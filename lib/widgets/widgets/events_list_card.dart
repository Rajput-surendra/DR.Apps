import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Event/event_deatils.dart';
import '../../Helper/Appbar.dart';
import '../../Helper/Color.dart';

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

import '../../New_model/GetEventModel.dart';
import '../../api/api_services.dart';

class EventsListCard extends StatefulWidget {
  const EventsListCard({Key? key,required this.index, required this.i, this.getEventModel,required this.onTop }) : super(key: key);

  final int index;
  final int i;
  final EventDataList? getEventModel;
  final VoidCallback onTop;

  @override
  State<EventsListCard> createState() => _EventsListCardState();
}

class _EventsListCardState extends State<EventsListCard> {
  GlobalKey keyList =GlobalKey() ;
  bool _isReady = true ;
  bool iconVisible = true;

  void initState() {
    // TODO: implement initState
    //keyList =  List.generate(1000, (_) => GlobalKey());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isReady = true;
      });
    });
    super.initState();
    getUserId();
  }
  String? userId,role;
  getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
  userId = preferences.getString('userId');
  role =  preferences.getString("roll");

  print('_____role_____${role}_________');
  }


List? strObj;
  @override
  Widget build(BuildContext context) {
    strObj = widget.getEventModel!.image.split(".");
    print('_____saaaaaaaaaaaaaaaa_____${strObj![2]}_________');
    return RepaintBoundary(
      key: keyList,
      child:_isReady ?  Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child:  Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5,bottom: 8),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("${widget.getEventModel?.userImage}"),
                              backgroundColor: colors.primary,
                              radius: 25,
                            ),
                          ), //CircleAvatar
                          Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${widget.getEventModel?.userName}",style: TextStyle(fontSize: 14,color: colors.secondary),),
                                role == "2" ? SizedBox.shrink(): Text("Degree: ${widget.getEventModel?.userDigree}",style: TextStyle(fontSize: 10),),
                                Container(
                                  // width: 250,
                                    child: Text("${widget.getEventModel?.userAddress}",style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis,maxLines: 1,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      iconVisible ? Row(
                        children: [
                          IconButton(onPressed: (){
                            setState(() {
                              iconVisible = false;
                            });
                            Future.delayed(Duration(milliseconds: 500), (){
                              //_CaptureScreenShot(index: index);
                              _shareQrCode(widget.getEventModel?.link ?? '');
                              // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                            });

                          }, icon: Icon(Icons.share)),
                          IconButton(onPressed: (){
                            setState(() {
                              getNewWishlistApi(widget.getEventModel?.id ?? '', widget.getEventModel?.type ?? "");
                              widget.getEventModel?.isSelected = !(widget.getEventModel?.isSelected ?? false );
                            });
                          },icon: widget.getEventModel?.isFav ?? false ?
                          Icon(Icons.favorite,color: colors.red,): widget.getEventModel?.isSelected ?? false
                              ?Icon(Icons.favorite,color: colors.red,) :
                          Icon(Icons.favorite_outline,color: colors.red,)),
                          if(userId == widget.getEventModel!.pharmaId)
                          InkWell(
                            onTap: widget.onTop,
                              child: Icon(Icons.delete)),
                        ],
                      ):SizedBox.shrink()

                    ],
                  ),

                  strObj![2] == "pdf" ? Column(
                    children: [

                      InkWell(
                        onTap: (){
                          downloadFile('${widget.getEventModel!.image}', widget.getEventModel?.title ?? '');
                        } ,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 50,
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
                              viewFile(widget.getEventModel!.image , "File");
                            },
                            child: Text("VIEW PDF",style: TextStyle(color: colors.secondary),)),
                      ),
                    ],
                  )
               :
                  Container(
                    width: double.infinity,
                    child:  DecoratedBox(
                      decoration:  BoxDecoration(
                      ),
                      child: widget.getEventModel?.image == null || widget.getEventModel?.image == ""?Image.asset("assets/splash/splashimages.png"):Image.network("${widget.getEventModel?.image}",fit: BoxFit.fill)
                    ),

                  ),
                  SizedBox(height: 10,),
                  Text("${widget.getEventModel?.address}",),
                  SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text("${widget.getEventModel?.startDate}"),
                        Container(
                         height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.secondary
                          ),
                          child: TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDeatils(getEventModel: widget.getEventModel)));
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDeatils(getEventModel: widget eventDataList[index])));

                          }, child: Text("Click For Details",style: TextStyle(
                            color: colors.whiteTemp
                          ),)),
                        ),

                      ],
                    ),
                    SizedBox(height: 8,),



                    const SizedBox(height: 10,),

                ],
              ),
            )

        ),
      ) : SizedBox(),
    );
  }

  _shareQrCode(String text) async {
    iconVisible = true ;
    var status =  await Permission.photos.request();
    // PermissionStatus storagePermission = await Permission.storage.request();
    if (/*storagePermission == PermissionStatus.granted*/status.isGranted) {
      final directory = (await getApplicationDocumentsDirectory()).path;

      RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      /*if(bound.debugNeedsPaint){
        Timer(Duration(seconds: 1),()=>_shareQrCode(text));
        return null;
      }*/
      ui.Image image = await bound.toImage();
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
        // final resultsave = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),quality: 90,name: 'screenshot-${DateTime.now()}.png');
        //print(resultsave);
      }
    } else if (await status.isDenied/*storagePermission == PermissionStatus.denied*/) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This Permission is recommended')));
    } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
      openAppSettings().then((value) {

      });
    }
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
  //         String tempPath = path.toString().replaceAll("Download", "DR Apps");
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
  getNewWishlistApi(String id, String event) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    String? Roll = preferences.getString('roll');
    print("getEventUserId--------------->${Roll}");
    var headers = {
      'Cookie': 'ci_session=3d55d84af76cc51db413ee4ccdea5fff824134e1'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addNewWishListApi}'));
    request.fields.addAll({
      'roll': '$Roll',
      'user_id': '$userId',
      'prod_id': '$id',
      'status': '1',
      'type': '$event'
    });
    print("this is data------------->${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.decode(result);
      print("thi os ojon==========>${finalResult}");
      Fluttertoast.showToast(msg: finalResult['message'],backgroundColor: colors.secondary);


    }
    else {
      print(response.reasonPhrase);
    }

  }

}
