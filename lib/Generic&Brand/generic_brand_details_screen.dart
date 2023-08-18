import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:doctorapp/Helper/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Helper/Appbar.dart';
import 'Gereric_Brand_Uplaod_Screen.dart';
import 'genericRx_Dosage_Screen.dart';


class GenericBrandDetailsScreen extends StatefulWidget {
   GenericBrandDetailsScreen({Key? key,this.catId,this.catName}) : super(key: key);
  String ? catId,catName;

  @override
  State<GenericBrandDetailsScreen> createState() => _GenericBrandDetailsScreenState();
}

class _GenericBrandDetailsScreenState extends State<GenericBrandDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GerericBrandUplaodScreen(catName:widget.catName,)));
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: colors.primary,
              borderRadius: BorderRadius.circular(15)
            ),

            child: Center(child: Text("Add Your Brand",style: TextStyle(color: colors.whiteTemp),)),
          ),
        ),
      ),
      appBar: customAppBar(context: context, text:"Generic & Brand", isTrue: true, ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
             Card(
               elevation: 5,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10)
               ),
               child: Padding(
                 padding: const EdgeInsets.all(15.0),
                 child: Center(child: Text("${widget.catName}",style: TextStyle(
                   color: colors.black54
                 ),)),
               ),
             ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                  itemBuilder: (c,i){
                return  Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("Moov",textAlign: TextAlign.center,style: TextStyle(
                          color: colors.secondary,fontSize: 25
                      ),),
                      Text("Surendra singh rajpoot",textAlign: TextAlign.center,style: TextStyle(
                        color: colors.black54,
                      ),),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
                                  color: colors.darkIcon
                              ),
                              child: Center(child: Text("by Sun Pharma Limited",textAlign: TextAlign.center,style: TextStyle(
                                  color: colors.whiteTemp
                              ),)),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>GenericRxDosageScreen(catName: widget.catName,)));
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                    color: colors.red
                                ),
                                child: Center(child:
                                BlinkText(
                                    'Click to add  details of brand',textAlign: TextAlign.center,
                                    style: TextStyle( color: Colors.white),
                                    beginColor: colors.blackTemp,
                                    endColor: colors.whiteTemp,
                                    times: 1000,
                                    duration: Duration(seconds: 1)
                                ),
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),

                    ],
                  ),
                );
              })

          ],
        ),
      ),
    );
  }


}
