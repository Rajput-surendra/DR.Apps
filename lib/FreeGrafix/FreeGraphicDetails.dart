import 'package:doctorapp/New_model/Get_graphic_model.dart';
import 'package:flutter/material.dart';

import '../Helper/Appbar.dart';

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
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network("${widget.childList![index].image}",fit: BoxFit.fill)),
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
}
