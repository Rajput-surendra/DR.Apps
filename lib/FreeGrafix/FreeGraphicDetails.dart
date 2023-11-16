import 'dart:io';

import 'package:doctorapp/New_model/Get_graphic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';

class FreeGraphicDetailsScreen extends StatefulWidget {
  const FreeGraphicDetailsScreen({Key? key, this.childList}) : super(key: key);

 final List<Childs>? childList ;

  @override
  State<FreeGraphicDetailsScreen> createState() => _FreeGraphicDetailsScreenState();
}

class _FreeGraphicDetailsScreenState extends State<FreeGraphicDetailsScreen> {

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();

    if (isConfirmed && mounted) {
      _exitSetup();
    }
  }

  Future<bool> _isExitDesired() async {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
                'If you exit device setup, your progress will be lost.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Leave'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Stay'),
              ),
            ],
          );
        }) ??
        false;
  }

  void _exitSetup() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Free Graphic Details", isTrue: true, ),
      body: widget.childList == null
        ? Center(child: CircularProgressIndicator()) : widget.childList!.length == 0 ? Center(child: Text("No Record Found !!! ")): SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 3/3.4

              ),
              itemCount:widget.childList!.length, // Number of items in the grid
              itemBuilder: (BuildContext context, int index) {

                return Card(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10)
                 ),
                  child: Column(
                    children: [

                      InkWell(
                        onTap: (){
                          showDialogBox(index);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 150 ,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network("${widget.childList![index].image}",fit: BoxFit.fill)

                              ),
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.only(left: 5,right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 110,
                                    child: Text("${widget.childList![index].title}",maxLines: 1,style: TextStyle(
                                      color: colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 15,overflow: TextOverflow.ellipsis,
                                    ),),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      downloadFile('${widget.childList![index].image}', widget.childList![index].title ?? '');
                                    },
                                      child: Icon(Icons.download))
                                ],
                              ),
                            )
                          ],
                        )
                      ),


                    ],
                  ),
                );
              },
            ),
          )
        ],
       ),
    ),
    );
  }
  downloadFile(String url, String filename, ) async {
    FileDownloader.downloadFile(
        url:  "${url}",
        name: "${filename}",
        onDownloadCompleted: (path) {
          print(path);
          String tempPath = path.toString().replaceAll("Download", "DR.Apps");
          final File file = File(tempPath);

          var snackBar = SnackBar(
            backgroundColor: colors.secondary,
            content: Text('File Download Successfully'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //This will be the path of the downloaded file
        });
  }
  showDialogBox(int index){
    return showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          body:
         Stack(
            children: [
              InteractiveViewer(
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Center(child: Image.network("${widget.childList![index].image}",fit: BoxFit.fill, height: MediaQuery.of(context).size.height/2.4,width: MediaQuery.of(context).size.height/1.5,))),
                    );
                  },
                ),
              ),
                Positioned(
                  top: 0,
                  left:0,
                  right: 0,
                  bottom:280,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                          color: colors.secondary
                        ),
                          child: Icon(Icons.clear,color: colors.red,)),),
                  )),
            ],
          ),
        );
      },
    );
  }
}
