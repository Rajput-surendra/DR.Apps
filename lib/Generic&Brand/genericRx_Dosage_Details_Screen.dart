import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/Generic&Brand/generic_brand_details_screen.dart';
import 'package:doctorapp/Generic&Brand/slider_plan_screen.dart';
import 'package:doctorapp/SubscriptionPlan/addPosterScreen.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../BrandSpecialization/brand_specilization_upload.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/Get_brands_Rx_dosage_model.dart';
import '../Screen/HomeScreen.dart';
import 'Gereric_Brand_Uplaod_Screen.dart';
import 'advertisement_screen.dart';
import 'genericRx_Dosage_Screen.dart';
import 'generic_brand_screen.dart';
import 'package:http/http.dart' as http;
class GenericRxDosageDetailsScreen extends StatefulWidget {
   GenericRxDosageDetailsScreen({Key? key,this.Id, this.isTrueId,this.brand,this.des,this.planId,this.nameChange,this.spId}) : super(key: key);
   String? Id ,brand,des, planId,spId;
   bool? isTrueId;
   bool? nameChange;
  @override
  State<GenericRxDosageDetailsScreen> createState() => _GenericRxDosageDetailsScreenState();
}

class _GenericRxDosageDetailsScreenState extends State<GenericRxDosageDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    print('____surendra______${widget.nameChange}__${widget.spId}__');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:  colors.secondary,
        leading: InkWell(
          onTap: (){
          //  Navigator.pop(context);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GenericBrandDetailsScreen()));
            if(widget.nameChange ?? false){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BrandSpecilizationUpload()));
            }
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GenericBrandDetailsScreen()));
          },
            child: Icon(Icons.arrow_back_ios_rounded)),
        title:widget.nameChange == true ?Text( "Speciality Brands"): Text( "Generics & Brands"),
      ),
      // customAppBar(context: context, text:"Generic & Brand", isTrue: true, ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child:getBrandsRxDosageModel ==  null ? Center(child: CircularProgressIndicator()): getBrandsRxDosageModel!.data!.length == 0 ? Center(child: Text("No Data Found !!!!")): Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(child: Text("${catName}",style: TextStyle(
                            color: colors.black54
                        ),)),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(

                        child: ClipRRect(
                            child: AspectRatio(
                              aspectRatio: 2/1,
                                child: Image.network("${getBrandsRxDosageModel!.data!.first.logo}",fit: BoxFit.cover,)))),
                    SizedBox(height: 10,),

                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              indicationCard();
                            },
                            child: Container(
                              height: 40,
                              color: colors.primary,
                              child: Center(child: Text("Indication",style: TextStyle(
                                  color: colors.whiteTemp
                              ),)),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              dosageCard();
                            },
                            child: Container(
                              height: 40,
                              color: colors.primary,
                              child: Center(child: Text("Dosage",style: TextStyle(
                                  color: colors.whiteTemp
                              ),)),
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              rxInfoCard();
                            },
                            child: Container(
                              height: 40,
                              color: colors.primary,
                              child: Center(child: Text("Rx info",style: TextStyle(
                                  color: colors.whiteTemp
                              ),)),
                            ),
                          ),
                        ),
                      ],
                    ),

                   SizedBox(height: 20,),
                    sliderCard(),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  _buildDots(),),
                    SizedBox(height: 10,),
                    Text("CONTACT FOR BRAND INQUIRY AND ORDER",textAlign: TextAlign.center,),
                    SizedBox(height: 5,),
                    personAllWidget(),
                    SizedBox(height: 10,),
                    widget.isTrueId == true ? SizedBox.shrink() : Row(
                      children: [
                        role == "1" ? SizedBox.shrink():   InkWell(
                          onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>GenericRxDosageScreen(isTrueValue: true,)));
                           //    Navigator.pop(context,[true]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: colors.secondary,
                                borderRadius: BorderRadius.circular(10)
                            ),

                            height: 50,
                            width: MediaQuery.of(context).size.width/3 ,
                            child: Center(child: Text("Edit Details",style: TextStyle(color: colors.whiteTemp),)),
                          ),
                        ),
                        SizedBox(width: 15,),
                        role == "2"?
                        //getBrandsRxDosageModel?.data?.first.isDetailsAdded == false ?
                        InkWell(
                          onTap: (){
                            if(getBrandsRxDosageModel!.data!.first.isAddPlanSubscribed == false){
                              _showAlertDialog(context);
                            }else{
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPosterScreen()));
                            }

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: colors.secondary,
                                borderRadius: BorderRadius.circular(10)
                            ),

                            height: 50,
                            width: MediaQuery.of(context).size.width/1.8 ,
                            child: Center(child: Text("Link this page to sliding ad",style: TextStyle(color: colors.whiteTemp,fontSize: 15))),
                          ),
                        )
                        //     :InkWell(
                        //   onTap: (){
                        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>AdvertisementScreen()));
                        //     // if(getBrandsRxDosageModel!.data!.first.isDetailsAdded == false){
                        //     //   _showAlertDialog(context);
                        //     // }else{
                        //     //
                        //     // }
                        //
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: colors.secondary,
                        //         borderRadius: BorderRadius.circular(10)
                        //     ),
                        //
                        //     height: 50,
                        //     width: MediaQuery.of(context).size.width/1.8  ,
                        //     child: Center(child: Text("Change sliding ad image",style: TextStyle(color: colors.whiteTemp))),
                        //   ),
                        // )
                            :SizedBox.shrink()
                      ],
                    )

                  ],
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }

  int _currentPost =  0;
  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < (getBrandsRxDosageModel?.data?.first.images?.length ?? 10); i++) {
      dots.add(
        Container(
          margin: EdgeInsets.all(2.5),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPost == i
                ? colors.secondary
                : colors.primary,
          ),
        ),
      );
    }
    return dots;
  }

  sliderCard(){
    return   CarouselSlider(
        options: CarouselOptions(
          onPageChanged: (index, result) {
            setState(() {
              _currentPost = index;
            });
          },
          viewportFraction: 1.0,
          // initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 500),
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          height: 250,
        ),
        items:

        getBrandsRxDosageModel?.data?.first.images?.map((images) {
          return Padding(
              padding: const EdgeInsets.only(left: 0,right: 0),
              child: AspectRatio(
                aspectRatio:16/4,
                child: Image.network("${images}",fit: BoxFit.fill,)

                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   // height: MediaQuery.of(context).size.height /1.9,
                //   decoration: BoxDecoration(borderRadius:BorderRadius.circular(0),image: DecorationImage(image: NetworkImage("${images}"),fit: BoxFit.cover)),
                //
                // ),
              )
          );
        }).toList());
  }
  indicationCard(){
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Indication",style: TextStyle(color: colors.blackTemp,fontSize: 16),),
              content: Text('${getBrandsRxDosageModel?.data?.first.details?.indication}'),
              actions: <Widget>[

              ],
            );
          },
        );
      },
    );
  }
  dosageCard(){
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Dosage",style: TextStyle(color: colors.blackTemp,fontSize: 16),),
              content: Text('${getBrandsRxDosageModel?.data?.first.details?.dosage}'),
              actions: <Widget>[

              ],
            );
          },
        );
      },
    );
  }
  rxInfoCard(){
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Rx info",style: TextStyle(color: colors.blackTemp,fontSize: 16),),
              content: Text('${getBrandsRxDosageModel?.data?.first.details?.rxInfo}'),
              actions: <Widget>[

              ],
            );
          },
        );
      },
    );
  }
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              height: MediaQuery.of(context).size.height/2.0,
              width: double.infinity,
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: ' ',
                      style: TextStyle(fontSize: 13,color: colors.blackTemp),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Sliding ad detail',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: colors.blackTemp)),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Image.asset("assets/images/generic1.png"),
                  // Container(
                  //   height: 50,
                  //  decoration: BoxDecoration(
                  //    border: Border.all(color: colors.blackTemp)
                  //  ),
                  //   child: Center(child: Text("Logo upload area\n image size : 200 pixel * 100 pixed",style: TextStyle(fontSize: 12),)),
                  // ),
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SliderPlanScreen()));

                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: colors.secondary,
                          // border: Border.all(color: colors.primary,width: 4),


                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Subscribe now to upload ',style: TextStyle(fontSize: 11),
                              children: const <TextSpan>[
                                TextSpan(text: 'Sliding ad', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                              ],
                            ),
                          ),
                        )

                    ),
                  )
                ],
              )),
          // actions: [],
        );
      },
    );
  }

  personAllWidget(){
    return Container(
      height: 150,
      child: ListView.
         builder(
        scrollDirection: Axis.horizontal,
        itemCount: getBrandsRxDosageModel?.data?.first.contactDetails?.length,
          itemBuilder: (c,i){
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width/3.5,
                        height: 50,
                      color:colors.primary,
                        child: Center(child: Text("${getBrandsRxDosageModel!.data!.first.contactDetails?[i].name}"))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width/3.5,
                        height: 50,
                        color:colors.blackTemp.withOpacity(0.1),
                        child: Center(child: Text("${getBrandsRxDosageModel!.data!.first.contactDetails?[i].mobile}"))),
                  )
                ],
              )
            ],
          ),
        );
            
        //   Container(
        //   width: 100,
        //   child:
        //   // Row(
        //   //   crossAxisAlignment: CrossAxisAlignment.start,
        //   //   children: [
        //   //     Column(
        //   //       children: [
        //   //         Padding(
        //   //           padding: const EdgeInsets.all(0.0),
        //   //           child: Container(
        //   //             color:  colors.primary,
        //   //             child: Center(child: Padding(
        //   //               padding: const EdgeInsets.symmetric(horizontal: 5),
        //   //               child: Text('${getBrandsRxDosageModel?.data?.first.contactDetails?[i].name}',style: TextStyle(color: colors.whiteTemp),),
        //   //             )),
        //   //           ),
        //   //         ),
        //   //         Padding(
        //   //           padding: const EdgeInsets.all(5.0),
        //   //           child: Container(
        //   //             color:  colors.black54.withOpacity(0.1),
        //   //             child: Center(child: Padding(
        //   //               padding: const EdgeInsets.symmetric(horizontal: 6),
        //   //               child: Text("${getBrandsRxDosageModel?.data?.first.contactDetails?[i].mobile}"),
        //   //             )),
        //   //           ),
        //   //         ),
        //   //       ],
        //   //     ),
        //   //     // SizedBox(width: 5,),
        //   //     // Expanded(
        //   //     //   child: Column(
        //   //     //     children: [
        //   //     //       Container(
        //   //     //         height: 50,
        //   //     //         color:  colors.primary,
        //   //     //         child: Center(child: Text("${getBrandsRxDosageModel?.data?.first.contactDetails?.first.name}",style: TextStyle(color: colors.whiteTemp))),
        //   //     //       ),
        //   //     //       SizedBox(height: 5,),
        //   //     //       Container(
        //   //     //         height: 50,
        //   //     //         color:  colors.black54.withOpacity(0.1),
        //   //     //         child: Center(child: Text("${getBrandsRxDosageModel?.data?.first.contactDetails?.first.mobile}")),
        //   //     //       ),
        //   //     //     ],
        //   //     //   ),
        //   //     // ),
        //   //     // SizedBox(width: 5,),
        //   //     // Expanded(
        //   //     //   child: Column(
        //   //     //     children: [
        //   //     //
        //   //     //       Container(
        //   //     //         height: 50,
        //   //     //         color:  colors.primary,
        //   //     //         child: Center(child: Text("${getBrandsRxDosageModel?.data?.first.contactDetails?.first.name}",style: TextStyle(color: colors.whiteTemp))),
        //   //     //       ),
        //   //     //
        //   //     //       SizedBox(height: 5,),
        //   //     //       Container(
        //   //     //         height: 50,
        //   //     //         color:  colors.black54.withOpacity(0.1),
        //   //     //         child: Center(child: Text('${getBrandsRxDosageModel?.data?.first.contactDetails?.first.mobile}')),
        //   //     //       ),
        //   //     //     ],
        //   //     //   ),
        //   //     // ),
        //   //   ],
        //   // ),
        // );
      }),
    );
  }
  String ?userId;
  GetBrandsRxDosageModel ? getBrandsRxDosageModel;
  renericRxDosageDetailsApi() async {
    SharedPreferences  preferences = await  SharedPreferences.getInstance();
    userId = preferences.getString("userId");
    var headers = {
      'Cookie': 'ci_session=fd48e2b4f3fe06cb3b11d5a806253ec62f6af057'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getBrandApi}'));
    request.fields.addAll({
      'user_id':  role == "1" ? ""  : userId.toString(),
     'id':widget.nameChange ?? false ? widget.spId ?? "" : widget.isTrueId ?? false ? widget.Id.toString():cardId.toString()
    });
    print('____request.fields______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result  = await response.stream.bytesToString();
     var finalResult =  GetBrandsRxDosageModel.fromJson(jsonDecode(result));
     setState(() {
       getBrandsRxDosageModel =  finalResult;
       print('_____finalResult_____${finalResult}_________');
     });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  @override
  void initState() {
    super.initState();
    getRole();
    renericRxDosageDetailsApi();

  }
  String? role;

  getRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    role = preferences.getString("roll");
    print('_____role_____${role}_________');
  }

}
