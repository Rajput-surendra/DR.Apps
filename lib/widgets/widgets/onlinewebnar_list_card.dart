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
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Helper/Appbar.dart';
import '../../Helper/Color.dart';
import '../../New_model/GetWebinarModel.dart';
import 'package:http/http.dart'as http;

import '../../api/api_services.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

class OnlineWebinarListCard extends StatefulWidget {
  const OnlineWebinarListCard({Key? key, required this.index, this.getWebinarDataList,required this.onTap}) : super(key: key);

  final int index;
  final GetWebnDataList? getWebinarDataList;
  final VoidCallback  onTap;

  @override
  State<OnlineWebinarListCard> createState() => _OnlineWebinarListCardState();
}


class _OnlineWebinarListCardState extends State<OnlineWebinarListCard> {

  GlobalKey keyList = GlobalKey() ;
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
  String? userId;
  getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userId');
  }
  List? strObj;
  @override
  Widget build(BuildContext context) {
    strObj = widget.getWebinarDataList!.image!.split(".");
    return  RepaintBoundary(
      key: keyList,
      child: _isReady ? Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 30,
                    width:MediaQuery.of(context).size.width/1.0,
                    decoration: BoxDecoration(
                        color: colors.secondary,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(11),topRight: Radius.circular(11))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${widget.getWebinarDataList?.date.toString().substring(0,10)}',style: TextStyle(color: Colors.white,fontSize: 15),),
                        SizedBox(width: 20,),
                        Padding(
                          padding: const EdgeInsets.only(top: 5,bottom: 5),
                          child: VerticalDivider(thickness: 1,color: colors.whiteTemp,),
                        ),
                        SizedBox(width: 20,),
                        Text('${widget.getWebinarDataList?.fromTime.toString()}',style: TextStyle(color: Colors.white,fontSize: 15),),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0,bottom: 8,left: 5),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage("${widget.getWebinarDataList?.userImage}"),
                                  backgroundColor: colors.primary,
                                  radius: 25,
                                ),
                              ), //CircleAvatar
                              Padding(
                                padding: const EdgeInsets.only(left: 5,bottom: 10),
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Title: ${widget.getWebinarDataList?.title}",style: TextStyle(fontSize: 14,color: colors.secondary),),
                                    SizedBox(height: 3,),
                                    Text("Topic: ${widget.getWebinarDataList?.topic}",style: TextStyle(fontSize: 10),),
                                    SizedBox(height: 3,),
                                    Text("${widget.getWebinarDataList?.userAddress}",style: TextStyle(fontSize: 10),),

                                  ],
                                ),
                              ),
                            ],
                          ),
                          iconVisible ? Row(
                            children: [
                               InkWell(
                                 onTap: (){
                                   setState(() {
                                     iconVisible = false;
                                   });
                                   Future.delayed(Duration(seconds: 1), (){

                                     _shareQrCode(widget.getWebinarDataList?.link ?? '');

                                   });

                                 },
                                   child: Icon(Icons.share)),
                              IconButton(onPressed: (){
                                setState(() {
                                  getNewWishlistApi(widget.getWebinarDataList?.id ?? '', widget.getWebinarDataList?.type ?? "");
                                  widget.getWebinarDataList?.isSelected = !(widget.getWebinarDataList?.isSelected ?? false );
                                });
                              },icon: widget.getWebinarDataList?.isFav ?? false ?
                              Icon(Icons.favorite,color: colors.red,): widget.getWebinarDataList?.isSelected ?? false
                                  ?Icon(Icons.favorite,color: colors.red,) :
                              Icon(Icons.favorite_outline,color: colors.red,)),
                              if(userId == widget.getWebinarDataList?.pharmaId)
                              InkWell(
                                  onTap: widget.onTap,
                                  child: Icon(Icons.delete)),
                            ],
                          ):SizedBox.shrink()

                        ],
                      ),
                     strObj![2] == "pdf" ? Column(
                        children: [
                          InkWell(
                            onTap: (){
                              viewFile(widget.getWebinarDataList!.image ??  "", "File");
                            } ,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                  width: 80,
                                  height: 80 ,
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/pdf.png")
                                    ],
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text("View Pdf",style: TextStyle(color: colors.secondary),)
                        ],
                      )
                          :
                      Container(
                        width: double.infinity,
                        child:  DecoratedBox(
                            decoration:  BoxDecoration(
                            ),
                            child: Image.network("${widget.getWebinarDataList?.image}",fit: BoxFit.cover)
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 140,
                                    child: Text("Speaker: ${widget.getWebinarDataList?.speaker}",overflow: TextOverflow.ellipsis,)),
                                SizedBox(
                                  width: 150,
                                    child: Text("Moderator: ${widget.getWebinarDataList?.moderator}",overflow: TextOverflow.ellipsis,)),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 30,
                                  child: ElevatedButton(onPressed: (){
                                    launch("${widget.getWebinarDataList?.link}");
                                  },
                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                      child: Text('Link',style: TextStyle(color: Colors.white,fontSize: 10),)),
                                ),
                                SizedBox(width: 5,),
                                 strObj![2] == "pdf" ? Container(
                                  height: 30,
                                  child: ElevatedButton(onPressed: (){

                                    downloadFile('${widget.getWebinarDataList?.image}', widget.getWebinarDataList?.userName ?? '');
                                  },
                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                      child: Text('Download PDF',style: TextStyle(color: Colors.white,fontSize: 8),)),
                                ):SizedBox.shrink()

                              ],
                            ),
                        ],
                        ),
                      )

                    ],
                  )
                ],
              ),
            ),
          ),

        ],
      ) : SizedBox(),
    );
  }
  viewFile(String url, String filename) async {
    FileDownloader.downloadFile(
        url:  "${url}",
        name: "${filename}",
        onDownloadCompleted: (path) {
          print(path);
          String tempPath = path.toString().replaceAll("Download", "DR.Apps");
          final File file = File(tempPath);
          print("path here ${file}");
          displayPDF(url);

          Fluttertoast.showToast(msg: "File View successfully!",backgroundColor: colors.secondary);

        });
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
  _shareQrCode(String text) async {
    iconVisible = true ;
    var status =  await Permission.photos.request();

    if (/*storagePermission == PermissionStatus.granted*/status.isGranted) {
      final directory = (await getApplicationDocumentsDirectory()).path;

      RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await bound.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      print('${byteData?.buffer.lengthInBytes}___________');

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
          SnackBar(content: Text('This Permission is recommended')));
    } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
      openAppSettings().then((value) {

      });
    }
  }
  getNewWishlistApi(String id ,event) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');

    String? Roll = preferences.getString('roll');

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
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.decode(result);
      Fluttertoast.showToast(msg: finalResult['message'],backgroundColor: colors.secondary);
    }
    else {
      print(response.reasonPhrase);
    }

  }


}
