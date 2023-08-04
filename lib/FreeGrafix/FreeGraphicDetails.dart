import 'package:doctorapp/New_model/Get_graphic_model.dart';
import 'package:flutter/material.dart';
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
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 3/3.5

              ),
              itemCount:widget.childList!.length, // Number of items in the grid
              itemBuilder: (BuildContext context, int index) {

                return Container(
                  decoration: BoxDecoration(
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
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network("${widget.childList![index].image}",fit: BoxFit.fill)



                          ),
                        ),
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
                            child: Image.network("${widget.childList![index].image}",fit: BoxFit.fill, height: MediaQuery.of(context).size.height/1.4,width: MediaQuery.of(context).size.height/1.5,)),
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
