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
  @override
  Widget build(BuildContext context) {
    print('____childList______${widget.childList}_________');
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

                      // AspectRatio(
                      //   aspectRatio: 1,
                      //   child: PhotoViewGallery.builder(
                      //     backgroundDecoration: BoxDecoration(color: Colors.white),
                      //     scrollPhysics: BouncingScrollPhysics(),
                      //     builder: (BuildContext context, int index) {
                      //       return PhotoViewGalleryPageOptions(
                      //         maxScale: PhotoViewComputedScale.contained,
                      //         minScale: PhotoViewComputedScale.contained,
                      //         imageProvider: NetworkImage(
                      //             "${widget.childList![index].image}",),
                      //         initialScale: PhotoViewComputedScale.contained,
                      //       );
                      //     },
                      //     itemCount: 1,
                      //   ),
                      // )

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
                      // Text("${widget.childList![index].title}")

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
  showDialogBox(int index){
    return showDialog(
      context: context,
      builder: (context) {
       
        return InteractiveViewer(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 2,
                      child: TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Icon(Icons.clear,color: colors.red,)),
                    ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                            child: Center(child: Image.network("${widget.childList![index].image}",fit: BoxFit.fill, height: MediaQuery.of(context).size.height/2.4,width: MediaQuery.of(context).size.height/1.5,))),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
