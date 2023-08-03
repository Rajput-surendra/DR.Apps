import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

import '../../Helper/Appbar.dart';
import '../../Helper/Color.dart';
import '../../New_model/GetEditorialmodel.dart';
import '../../api/api_services.dart';


class EditorialListCard extends StatefulWidget {
  const EditorialListCard({Key? key, required this.index, this.getEdoDataList,required this.onTop}) : super(key: key);

  final int index;
  final GetEdoDataList? getEdoDataList;
  final VoidCallback onTop;

  @override
  State<EditorialListCard> createState() => _EditorialListCardState();
}

class _EditorialListCardState extends State<EditorialListCard> {
  GlobalKey keyList = GlobalKey() ;
  bool _isReady = true ;
  bool iconVisible = true;

  void initState() {
    // TODO: implement initState
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
    print('_____role___vv__${role}_________');
  }
  List? strObj;
  @override
  Widget build(BuildContext context) {
    strObj = widget.getEdoDataList?.image.split('.');
    print('____sasadsadsad______${strObj![2]}_________');
    return RepaintBoundary(
      key: keyList,
      child: _isReady ?   Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child:  Padding(
              padding: const EdgeInsets.only(left: 5,right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5,bottom: 8),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("${widget.getEdoDataList?.userImage}"),
                              backgroundColor: colors.primary,
                              radius: 25,
                            ),
                          ), //CircleAvatar
                          Padding(
                            padding: const EdgeInsets.only(left: 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 180,
                                    child: Text("${widget.getEdoDataList?.userName}",style: TextStyle(fontSize: 14,color: colors.secondary),overflow: TextOverflow.ellipsis,)),
                                role == "2"  ? SizedBox.shrink():Container(
                                  width: 180,
                                    child: Text("Degree: ${widget.getEdoDataList?.userDigree}",style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis,)),
                                Container(
                                  // width: 250,
                                    child: Text("${widget.getEdoDataList?.userAddress}",style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis,maxLines: 1,)),
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
                                    _shareQrCode(text: widget.getEdoDataList?.title ?? '');
                                  });
                                },
                                  child: Icon(Icons.share)),
                          IconButton(onPressed: (){
                            setState(() {
                              getNewWishlistApi(widget.getEdoDataList?.id ?? '',widget.getEdoDataList?.type ?? "");
                              widget.getEdoDataList?.isSelected = !(widget.getEdoDataList?.isSelected ?? false );
                            });
                          },icon: widget.getEdoDataList?.isFav ?? false ?
                          Icon(Icons.favorite,color: colors.red,): widget.getEdoDataList?.isSelected ?? false ?Icon(Icons.favorite,color: colors.red,) :
                          Icon(Icons.favorite_outline,color: colors.red,)),
                          if(userId ==  widget.getEdoDataList?.pharmaId)
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
                          downloadFile('${widget.getEdoDataList!.image}', widget.getEdoDataList?.title ?? '');
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
                              viewFile(widget.getEdoDataList!.image ??  "", "File");
                            },
                            child: Text("VIEW PDF",style: TextStyle(color: colors.secondary),)),
                      ),
                    ],
                  ):
                  Container(
                    width: double.infinity,
                    child:  DecoratedBox(
                        decoration:  BoxDecoration(
                        ),
                        child: widget.getEdoDataList?.image == null || widget.getEdoDataList?.image == "" ? Image.asset("assets/splash/splashimages.png"):Image.network("${widget.getEdoDataList?.image}",fit: BoxFit.cover)
                    ),

                  ),
                  const SizedBox(height: 10,),

                ],
              ),
            )

        ),
      ): SizedBox(),
    );
  }

  _shareQrCode({String? text}) async {
    iconVisible = true ;
    var status =  await Permission.photos.request();
    //Permission.manageExternalStorage.request();

    //PermissionStatus storagePermission = await Permission.storage.request();
    if ( status.isGranted/*storagePermission == PermissionStatus.denied*/) {
      final directory = (await getApplicationDocumentsDirectory()).path;

      RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      /*if(bound.debugNeedsPaint){
        Timer(const Duration(seconds: 2),()=>_shareQrCode());
        return null;
      }*/
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
          Fluttertoast.showToast(msg: "File View successfully!");
          // var snackBar = SnackBar(
          //   backgroundColor: colors.primary,
          //   // content: Text('File Download Successfully '),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //This will be the path of the downloaded file
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
      Fluttertoast.showToast(msg: finalResult['message']);


    }
    else {
      print(response.reasonPhrase);
    }

  }

}
