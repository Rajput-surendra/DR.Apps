import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetEventModel.dart';

class EventDeatils extends StatefulWidget {
  final EventDataList? getEventModel;
  const EventDeatils({Key? key,this.getEventModel}) : super(key: key);

  @override
  State<EventDeatils> createState() => _EventDeatilsState();
}

class _EventDeatilsState extends State<EventDeatils> {

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
     // getProoductListDetails();
    });

  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }

  Future<Null> callApi() async {
    //getProoductListDetails();
  }

  downloadFile(String url, String filename) async {
    FileDownloader.downloadFile(
        url: "${url}",
        name: "${filename}",
        onDownloadCompleted: (path) {
          print(path);
          String tempPath = path.toString().replaceAll("Download", "doctorapp");
          final File file = File(tempPath);
          print("path here ${file}");
          var snackBar = SnackBar(
            backgroundColor: colors.primary,
            content: Row(
              children: [
                const Text('doctorapp Saved in your storage'),
                TextButton(onPressed: (){}, child: Text("View"))

              ],
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //This will be the path of the downloaded file
        });
  }
  @override
  Widget build(BuildContext context) {
    return  RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        backgroundColor: colors.whiteTemp,
        appBar: customAppBar(context: context, text:"Event Details", isTrue: true, ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 235,
                color: colors.primary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.getEventModel!.name}",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 20),),

                      Row(
                        children: [
                          Text("${widget.getEventModel!.address}",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 16),),
                          Row(
                            children: [



                          ],)

                        ],
                      ),
                      Text("${widget.getEventModel!.startDate}",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 16 ),),
                      SizedBox(height: 5,),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 35,
                          width: 163,
                          child: ElevatedButton(onPressed: (){
                            showModalBottomSheet(
                                context: context,
                                builder: (context)
                                {
                                  return Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text("${widget.getEventModel!.designation}",
                                                  style: TextStyle(color: colors.blackTemp,fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 3,)),
                                            Text("${widget.getEventModel!.name}",style: TextStyle(color: colors.blackTemp,fontSize: 16,fontWeight: FontWeight.bold),),
                                            Text("${widget.getEventModel!.mobile}",style: TextStyle(color: colors.blackTemp,fontSize: 16),),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }
                            );
                          },
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),),
                              child: Text('Contact for Sponsorship',style: TextStyle(color: Colors.white,fontSize: 12),)),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 60,
                              child: ElevatedButton(onPressed: (){
                                downloadFile('${widget.getEventModel?.image}', widget.getEventModel?.userName ?? '');
                              },
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(colors.darkYellow),),
                                  child: Text('Download PDF/Jpg file',style: TextStyle(color: Colors.white,fontSize: 15),)),
                            ),
                          ),
                          SizedBox(width: 2,),
                          Expanded(
                            child:Container(
                              height: 60,

                              child: ElevatedButton(onPressed: (){
                                launch("${widget.getEventModel?.link}");

                              },
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink),),
                                  child: Center(child: Text('Click Here For Registration ',style: TextStyle(color: Colors.white,fontSize: 15),))),
                            )
                          )
                        ],
                      ),


                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(child: Image.network("${widget.getEventModel?.image}",fit: BoxFit.fill,))

            ],
          ),
        ),

      ),
    );
  }

}
