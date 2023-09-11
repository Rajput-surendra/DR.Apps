import 'package:dio/dio.dart';
import 'package:doctorapp/New_model/GetAwarenessModel.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

import '../../Helper/Appbar.dart';
import '../../Helper/Color.dart';

class AwarenessListCard extends StatefulWidget {
  const AwarenessListCard({Key? key, required this.index, required this.currentIndex,
    this.getAwareNess, this.isPlayed, required this.vController,required this.onTop}) : super(key: key);
  final VoidCallback onTop;

  final GetAModel? getAwareNess;
  final int currentIndex;
  final int index;
  final List<bool>? isPlayed;
  final List <VideoPlayerController> vController ;



  @override
  State<AwarenessListCard> createState() => _AwarenessState();
}

class _AwarenessState extends State<AwarenessListCard> {
  GlobalKey keyList = GlobalKey() ;
  bool _isReady = true ;
  bool iconVisible = true;
  String newsType =  '' ;

  bool iconVisible1 = true;
  bool iconVisible2 = true;
  bool iconVisible3 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  List? strObjBooklets,strObjLeaflets;

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
        print('This is file path is here------${filePath}');
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: customAppBar(context: context, text: "View Pdf", isTrue: true, ),
              body:  PDFView(
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
  @override
  Widget build(BuildContext context) {
    strObjBooklets = widget.getAwareNess?.data.booklets?[widget.index].image!.split(".");
    strObjLeaflets = widget.getAwareNess?.data.leaflets?[widget.index].image!.split(".");
    print('______ZZZZZZZZZZZZZZ__${strObjLeaflets![2]}__${strObjBooklets![2]}_________');
    if(widget.currentIndex == 1){
      newsType= 'doctor-news';
    }else if(widget.currentIndex == 2){
      newsType= 'pharma-news';
    }else if(widget.currentIndex == 3){
      newsType= 'product-news';
    }


    return widget.currentIndex == 0 ? RepaintBoundary(
      key: keyList,
      child: _isReady ? Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child:  Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 5,bottom: 8),
                      //   child: CircleAvatar(
                      //     backgroundImage: NetworkImage("${ApiService.imageUrl}${newTypeModel?.data?[i].profileImage}"),
                      //     backgroundColor: colors.primary,
                      //     radius: 25,
                      //   ),
                      // ), //CircleAvatar
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.getAwareNess?.data.poster?[widget.index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                            SizedBox(height: 2,),
                            Text(widget.getAwareNess?.data.poster?[widget.index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                            SizedBox(height: 5,)
                          ],
                        ),
                      )
                    ],
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   child:  DecoratedBox(
                  //       decoration:  BoxDecoration(
                  //       ),
                  //       child:widget.getAwareNess?.data.poster?[widget.index].image == null || widget.getAwareNess?.data.poster?[widget.index].image == "" ? Image.asset("assets/splash/splashimages.png"):Image.network("${widget.getAwareNess?.data.poster?[widget.index].image}",fit: BoxFit.cover,)
                  //   ),
                  //
                  // ),

                  Container(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius:  BorderRadius.circular(5),
                        child: Image.network("${widget.getAwareNess?.data.poster?[widget.index].image}",fit: BoxFit.cover,height: 250,)),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Text('${widget.getAwareNess?.data.poster?[widget.index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),
                          Text('${widget.getAwareNess?.data.poster?[widget.index].awareLanguage}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),

                        ],
                      ),

                      iconVisible ?  Row(
                        children: [
                          IconButton(onPressed: (){
                            setState(() {
                              iconVisible = false;
                            });
                            Future.delayed(Duration(seconds: 1), (){
                              _shareQrCode(text: widget.getAwareNess?.data.poster?[widget.index].userName);
                              // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                            });
                          }, icon: Icon(Icons.share)),
                          Container(
                            height: 30,
                            child: ElevatedButton(onPressed: (){
                              downloadFile('${widget.getAwareNess!.data.poster![widget.index].image}', widget.getAwareNess!.data.poster![widget.index].userName ?? '');
                            },
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                child: Text('Poster PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
                          ),
                          IconButton(onPressed: (){
                            setState(() {
                              getNewWishlistApi(widget.getAwareNess?.data.poster?[widget.index].id ??'',widget.getAwareNess?.data.poster?[widget.index].type ?? "");
                              widget.getAwareNess?.data.poster?[widget.index].isSelected = !(widget.getAwareNess?.data.poster?[widget.index].isSelected ?? false );
                            });
                          },icon: widget.getAwareNess?.data.poster?[widget.index].isSelected??
                              false ?Icon(Icons.favorite,color: colors.red,):
                          Icon(Icons.favorite_outline,color: colors.red,)),
                          if(userId ==  widget.getAwareNess?.data.poster?[widget.index].pharmaId)
                          InkWell(
                            onTap: widget.onTop,
                              child: Icon(Icons.delete))
                        ],
                      ):SizedBox.shrink()



                    ],
                  ),

                  SizedBox(height: 10,)

                ],
              ),
            )
        ),
      ) : SizedBox(),
    ) : widget.currentIndex == 1 ? RepaintBoundary(
      key: keyList,
      child: _isReady ? Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child:  Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 5,bottom: 8),
                      //   child: CircleAvatar(
                      //     backgroundImage: NetworkImage("${ApiService.imageUrl}${newTypeModel?.data?[i].profileImage}"),
                      //     backgroundColor: colors.primary,
                      //     radius: 25,
                      //   ),
                      // ), //CircleAvatar
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.getAwareNess?.data.booklets?[widget.index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                            SizedBox(height: 2,),
                            Text(widget.getAwareNess?.data.booklets?[widget.index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                            SizedBox(height: 5,)
                          ],
                        ),
                      )
                    ],
                  ),


                  strObjBooklets![2] == "pdf" ? Column(
                    children: [
                      InkWell(
                        onTap: (){
                          viewFile(widget.getAwareNess?.data.booklets?[widget.index].image! ??  "", "File");
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
                  ):
                  Container(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius:  BorderRadius.circular(5),
                        child:widget.getAwareNess?.data.booklets?[widget.index].image == null || widget.getAwareNess?.data.booklets?[widget.index].image == "" ?Image.asset("assets/splash/splashimages.png"):Image.network("${widget.getAwareNess?.data.booklets?[widget.index].image}",fit: BoxFit.cover,height: 250,)),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         // Text('${widget.getAwareNess?.data.booklets?[widget.index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp),),
                          Text('${widget.getAwareNess?.data.booklets?[widget.index].awareLanguage}'),
                        ],
                      ),
                      // Container(
                      //   height: 30,
                      //   child: ElevatedButton(onPressed: (){
                      //     downloadFile('${widget.getAwareNess!.data.booklets![widget.index].image}', widget.getAwareNess!.data.booklets![widget.index].userName ?? '');
                      //   },
                      //       style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                      //       child: Text('Leaflets PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
                      // ),
                      iconVisible1?  Row(
                        children: [
                          IconButton(onPressed: (){
                            setState(() {
                              iconVisible1 = false;
                            });
                            Future.delayed(Duration(seconds: 1), (){
                              _shareQrCode(text: widget.getAwareNess?.data.booklets?[widget.index].userName);
                              // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                            });
                            // _shareQrCode();
                          }, icon: Icon(Icons.share)),

                          strObjBooklets![2] == "pdf" ? Container(
                            height: 30,
                            child: ElevatedButton(onPressed: (){

                              downloadFile('${widget.getAwareNess!.data.booklets![widget.index].image}', widget.getAwareNess!.data.booklets![widget.index].userName ?? '');
                            },
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                child: Text('Download PDF Leaflets',style: TextStyle(color: Colors.white,fontSize: 10),)),
                          ):SizedBox.shrink(),
                          // Container(
                          //   height: 30,
                          //   child: ElevatedButton(onPressed: (){
                          //     downloadFile('${widget.getAwareNess!.data.booklets![widget.index].image}', widget.getAwareNess!.data.booklets![widget.index].userName ?? '');
                          //   },
                          //       style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                          //       child: Text('Leaflets PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
                          // ),
                          IconButton(onPressed: (){
                            setState(() {
                              getNewWishlistApi(widget.getAwareNess?.data.booklets?[widget.index].id ??'',widget.getAwareNess?.data.booklets?[widget.index].type ?? "");
                              widget.getAwareNess?.data.booklets?[widget.index].isSelected = !(widget.getAwareNess?.data.booklets?[widget.index].isSelected ?? false );
                            });
                          },icon: widget.getAwareNess?.data.booklets?[widget.index].isSelected??
                              false ?Icon(Icons.favorite,color: colors.red,):
                          Icon(Icons.favorite_outline,color: colors.red,)),
                          if(userId ==  widget.getAwareNess?.data.booklets?[widget.index].pharmaId)
                          InkWell(
                              onTap: widget.onTop,
                              child: Icon(Icons.delete))
                        ],
                      ):SizedBox.shrink()
                    ],
                  ),
                  SizedBox(height: 10,)

                ],
              ),
            )
        ),
      ) : SizedBox(),
    ) : widget.currentIndex == 2 ? RepaintBoundary(
      key: keyList,
      child: _isReady ? Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child:  Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 5,bottom: 8),
                      //   child: CircleAvatar(
                      //     backgroundImage: NetworkImage("${ApiService.imageUrl}${newTypeModel?.data?[i].profileImage}"),
                      //     backgroundColor: colors.primary,
                      //     radius: 25,
                      //   ),
                      // ), //CircleAvatar
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.getAwareNess?.data.leaflets?[widget.index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 2,),
                            Text(widget.getAwareNess?.data.leaflets?[widget.index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                            const SizedBox(height: 5,)
                          ],
                        ),
                      )
                    ],
                  ),
                  strObjLeaflets ![2] == "pdf" ? Column(
                    children: [
                      InkWell(
                        onTap: (){
                          viewFile(widget.getAwareNess?.data.booklets?[widget.index].image! ??  "", "File");
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
                  ):Container(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius:  BorderRadius.circular(5),
                        child: Image.network("${widget.getAwareNess?.data.leaflets?[widget.index].image}",fit: BoxFit.cover,height: 250,)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          //Text('${widget.getAwareNess?.data.leaflets?[widget.index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),
                          Text('${widget.getAwareNess?.data.leaflets?[widget.index].awareLanguage}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal)),
                        ],
                      ),

                      iconVisible2 ?  Row(
                        children: [
                          IconButton(onPressed: (){
                            setState(() {
                              iconVisible2 = false;
                            });
                            Future.delayed(Duration(seconds: 1), (){
                              _shareQrCode(text: widget.getAwareNess?.data.leaflets?[widget.index].userName);
                              // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                            });
                          }, icon: Icon(Icons.share)),

                          strObjLeaflets![2] == "pdf" ? Container(
                            height: 30,
                            child: ElevatedButton(onPressed: (){

                              downloadFile('${widget.getAwareNess!.data.leaflets![widget.index].image}', widget.getAwareNess!.data.leaflets![widget.index].userName ?? '');
                            },
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                child: Text('Download PDF Leaflets',style: TextStyle(color: Colors.white,fontSize: 10),)),
                          ):SizedBox.shrink(),
                          IconButton(onPressed: (){
                            setState(() {
                              getNewWishlistApi(widget.getAwareNess?.data.leaflets?[widget.index].id ??'',widget.getAwareNess?.data.leaflets?[widget.index].type ?? "");
                              widget.getAwareNess?.data.leaflets?[widget.index].isSelected = !(widget.getAwareNess?.data.leaflets?[widget.index].isSelected ?? false );
                            });
                          },icon: widget.getAwareNess?.data.leaflets?[widget.index].isSelected??
                              false ?Icon(Icons.favorite,color: colors.red,)
                              :Icon(Icons.favorite_outline,color: colors.red,)),
                          if(userId ==  widget.getAwareNess?.data.leaflets?[widget.index].pharmaId)
                          InkWell(
                              onTap: widget.onTop,
                              child: Icon(Icons.delete))
                        ],
                      ):SizedBox.shrink()
                    ],
                  ),
                  SizedBox(height: 10,)



                ],
              ),
            )
        ),
      ) : SizedBox(),
    ) : widget.currentIndex == 3 ? RepaintBoundary(
      key: keyList,
      child: _isReady ? Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child:  Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.getAwareNess?.data.mPoster?[widget.index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                            SizedBox(height: 2,),
                            Text(widget.getAwareNess?.data.mPoster?[widget.index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                            SizedBox(height: 5,)
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius:  BorderRadius.circular(5),
                        child: Image.network("${widget.getAwareNess?.data.mPoster?[widget.index].image}",fit: BoxFit.cover,height: 250,)),

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          //Text('${widget.getAwareNess?.data.mPoster?[widget.index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),
                          Text('${widget.getAwareNess?.data.mPoster?[widget.index].awareLanguage}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal)),
                        ],
                      ),

                      iconVisible3 ?  Row(
                        children: [
                          IconButton(onPressed: (){
                            setState(() {
                              iconVisible3 = false;
                            });
                            Future.delayed(Duration(seconds: 1), (){
                              _shareQrCode(text: widget.getAwareNess?.data.mPoster?[widget.index].userName );
                              // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                            });
                          }, icon: Icon(Icons.share)),
                          Container(
                            height: 30,
                            child: ElevatedButton(onPressed: (){
                              downloadFile('${widget.getAwareNess!.data.mPoster![widget.index].image}', widget.getAwareNess!.data.mPoster![widget.index].userName ?? '');
                            },
                                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),),
                                child: Text('Postrer PDF/Jpeg',style: TextStyle(color: Colors.white,fontSize: 10),)),
                          ),
                          IconButton(onPressed: (){
                            setState(() {
                              getNewWishlistApi(widget.getAwareNess?.data.mPoster?[widget.index].id ??'',widget.getAwareNess?.data.mPoster?[widget.index].type ?? "");
                              widget.getAwareNess?.data.mPoster?[widget.index].isSelected = !(widget.getAwareNess?.data.mPoster?[widget.index].isSelected ?? false );
                            });
                          },icon: widget.getAwareNess?.data.mPoster?[widget.index].isSelected?? false
                              ?Icon(Icons.favorite,color: colors.red,):
                          Icon(Icons.favorite_outline,color: colors.red,)),
                          if(userId ==  widget.getAwareNess?.data.mPoster?[widget.index].pharmaId)
                          InkWell(
                              onTap: widget.onTop,
                              child: Icon(Icons.delete))
                        ],
                      ):SizedBox.shrink()
                    ],
                  ),
                  SizedBox(height: 10,)

                ],
              ),
            )
        ),
      ) : SizedBox(),
    ) : SizedBox()  ;

  }


  downloadFile(String url, String filename, ) async {
    FileDownloader.downloadFile(
        url:  "${url}",
        name: "${filename}",
        onDownloadCompleted: (path) {
          print(path);
          String tempPath = path.toString().replaceAll("Download", "DR.Apps");
          final File file = File(tempPath);
          print("path here ${file}");

          var snackBar = SnackBar(
            backgroundColor: colors.secondary,
            content: Text('File Download Successfully'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
  }
  _shareQrCode({String? text}) async {
    iconVisible = true ;
    var status =  await Permission.photos.request();
    if ( status.isGranted/*storagePermission == PermissionStatus.denied*/) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await bound.toImage(pixelRatio: 10);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
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
  bool isScreenLoading = false ;
  getNewWishlistApi(String id, String event) async {

    isScreenLoading = true ;
    setState(() {

    });
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
      print("thi os ojon=result=========>${result}");
      Fluttertoast.showToast(msg: finalResult['message']);

      isScreenLoading = false ;
      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
      isScreenLoading = false ;
      setState(() {

      });
    }

  }
}
