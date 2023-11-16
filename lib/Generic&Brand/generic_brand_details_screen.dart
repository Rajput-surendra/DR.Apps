import 'dart:convert';

import 'package:blinking_text/blinking_text.dart';
import 'package:doctorapp/Generic&Brand/generic_brand_screen.dart';
import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Appbar.dart';
import '../New_model/Get_brand_model.dart';
import 'Gereric_Brand_Uplaod_Screen.dart';
import 'genericRx_Dosage_Details_Screen.dart';
import 'genericRx_Dosage_Screen.dart';
import 'package:http/http.dart' as http;

import 'get_brand_details_plans.dart';
String? cardId,brandName,brandDes;
class GenericBrandDetailsScreen extends StatefulWidget {
  GenericBrandDetailsScreen({Key? key, this.catId, this.catName})
      : super(key: key);
  String? catId, catName;

  @override
  State<GenericBrandDetailsScreen> createState() =>
      _GenericBrandDetailsScreenState();
}

class _GenericBrandDetailsScreenState extends State<GenericBrandDetailsScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =  GlobalKey<RefreshIndicatorState>();

  deleteAccountDailog(String? brandId) async {
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStater) {
                return

                  AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  content: const Text(
                      "Are you sure you want \nto delete Generics & Brands ?",
                      style: TextStyle(color: colors.secondary,fontSize: 16)
                  ),
                  actions: <Widget>[
                    TextButton(
                        child: const Text( "NO",style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        }),
                    TextButton(
                        child:  const Text( "YES",style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          brandDeleteApi(brandId);
                          Navigator.of(context).pop(false);

                        })
                  ],
                );
              });
        }));
  }
  dialogAnimate(BuildContext context, Widget dialge) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(opacity: a1.value, child: dialge),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        // pageBuilder: null
        pageBuilder: (context, animation1, animation2) {
          return Container();
        } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
    );
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
             bottomSheet:   role == "2" ?  Padding(
               padding: const EdgeInsets.only(left: 5,bottom: 5,right: 5),
               child: InkWell(
             onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GerericBrandUplaodScreen(
                  catName: catName,
                  catId: widget.catId,
                ))).then((value) {
                  if(value !=null){
                    callApi();
                  }
              });
               },
              child: Container(
                height: 50,
                   decoration: BoxDecoration(
                color: colors.primary, borderRadius: BorderRadius.circular(15)),
               child: const Center(
              child: Text(
            "Add your brand to promote in Doctor's side in apps",
            style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold),
          )),
         ),
       ),
             ): const SizedBox.shrink(),

         appBar:
        AppBar(
           title: const Text("Generics & Brands"),
           backgroundColor: colors.secondary,
           centerTitle: true,
          leading: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const GenericBrandScreen()));
            },
              child: const Icon(Icons.arrow_back_ios)),
         ),
        //customAppBar (context: context, text: "Generics & Brands", isTrue: true,),
        body: getBrandModel == null || getBrandModel  == "" ?   const Center(child: CircularProgressIndicator()): Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                        child: Text(
                      "${catName}",
                      style: const TextStyle(color: colors.black54),
                    )),
                  ),
                ),
                const SizedBox(height: 8,),
              role == "2" ? const SizedBox.shrink():  searchCard(),
                const SizedBox(height: 8,),
                getBrandModel == null
                    ? const Center(child: CircularProgressIndicator())
                    : getBrandModel?.data?.length == 0
                    ? const Center(child: Padding(
                      padding: EdgeInsets.all(80),
                      child: Text("No brand list ??"),
                    ))
                    :   ListView.builder(
                            shrinkWrap: true,
                            reverse: true ,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: getBrandModel!.data == null ||
                                    getBrandModel!.data == ""
                                ? 0
                                : brandList.length,
                            itemBuilder: (c, i) {
                              var branddata = brandList;
                              if(role == "1") {
                                return branddata[i].isDetailsAdded == true?  Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${branddata[i].name}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: colors.secondary, fontSize: 25),
                                      ),
                                      Text(
                                        "${branddata[i].genericName}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: colors.black54,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 38,
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.only(
                                                      bottomLeft:
                                                      Radius.circular(10)),
                                                  color: colors.darkIcon.withOpacity(0.6)),
                                              child: Center(
                                                  child: Text(
                                                    "By ${branddata[i].companyName}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: colors.whiteTemp,
                                                        fontSize: 12),
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  if(role == "1"){
                                                    setState((){
                                                      cardId = branddata[i].id;
                                                      brandName =  branddata[i].name;
                                                      brandDes =  branddata[i].genericName;
                                                    });
                                                   if(branddata[i].userPlanPurchased == true ){
                                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>GenericRxDosageDetailsScreen(Id:branddata[i].id,isTrueId: true,brand:branddata[i].name,des: branddata[i].genericName,)));
                                                   }

                                                  }else {
                                                    setState((){
                                                      cardId = branddata[i].id;
                                                      brandName =  branddata[i].name;
                                                      brandDes =  branddata[i].genericName;
                                                    });
                                                    if(!(branddata[i].isDetailPlanSubscribed  ?? false)){
                                                      _showAlertDialog(context, branddata[i].id ?? "");
                                                    }else if ((branddata[i].isDetailsAdded  == false )){
                                                      setState((){
                                                        cardId = branddata[i].id;
                                                        brandName =  branddata[i].name;
                                                        brandDes =  branddata[i].genericName;
                                                      });
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GenericRxDosageDetailsScreen(Id:branddata[i].id,isTrueId: true,)));
                                                    }else{
                                                    setState((){
                                                      cardId = branddata[i].id;
                                                      brandName =  branddata[i].name;
                                                      brandDes =  branddata[i].genericName;
                                                    });
                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GenericRxDosageScreen(id:branddata[i].id)));
                                                    }
                                                  }

                                                },
                                                child: branddata[i].isDetailsAdded == true ?  InkWell(
                                                  child: Container(
                                                    height: 38,
                                                    decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            bottomRight:
                                                            Radius.circular(10)),
                                                        color: colors.secondary),
                                                    child: Center(
                                                      child:
                                                       Text(
                                                        '${branddata[i].detailText}',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color:branddata[i].userPlanPurchased == true ? Colors.white:colors.whiteTemp.withOpacity(0.4),
                                                            fontSize: 12),

                                                      ),
                                                    ),
                                                  ),
                                                ) :  Container(
                                                  height: 38,
                                                  decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                          bottomRight:
                                                          Radius.circular(10)),
                                                      color: colors.red ),
                                                  child: Center(
                                                    child:
                                                    BlinkText(
                                                        '${branddata[i].detailText}',
                                                        textAlign: TextAlign.center,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                        beginColor: colors.blackTemp,
                                                        endColor: colors.whiteTemp,
                                                        times: 1000,
                                                        duration: const Duration(seconds: 1)),
                                                  ),
                                                )


                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ): Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${branddata[i].name}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: colors.secondary, fontSize: 25),
                                      ),
                                      Text(
                                        "${branddata[i].genericName}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: colors.black54,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 38,
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.only(
                                                      bottomLeft:
                                                      Radius.circular(10)),
                                                  color: colors.darkIcon.withOpacity(0.6)),
                                              child: Center(
                                                  child: Text(
                                                    "By ${branddata[i].companyName}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: colors.whiteTemp,
                                                        fontSize: 12),
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  if(role == "1"){

                                                  }else {
                                                    setState((){
                                                      cardId = branddata[i].id;
                                                      brandName =  branddata[i].name;
                                                      brandDes =  branddata[i].genericName;
                                                    });
                                                    if(!(branddata[i].isDetailPlanSubscribed  ?? false)){
                                                      _showAlertDialog(context, branddata[i].id ?? "");
                                                    }else if ((branddata[i].isDetailsAdded  == false )){
                                                      setState((){
                                                        cardId = branddata[i].id;
                                                        brandName =  branddata[i].name;
                                                        brandDes =  branddata[i].genericName;
                                                      });
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GenericRxDosageDetailsScreen(Id:branddata[i].id,isTrueId: true,)));
                                                    }else{
                                                      setState((){
                                                        cardId = branddata[i].id;
                                                        brandName =  branddata[i].name;
                                                        brandDes =  branddata[i].genericName;
                                                      });
                                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GenericRxDosageScreen(id:branddata[i].id)));
                                                    }
                                                  }

                                                },
                                                child: /*branddata[i].isDetailsAdded == true ? */ InkWell(
                                                  child: Container(
                                                    height: 38,
                                                    decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            bottomRight:
                                                            Radius.circular(10)),
                                                        color: colors.secondary),
                                                    child: Center(
                                                      child:
                                                      Text(
                                                        '${branddata[i].detailText}',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color:/*branddata[i].userPlanPurchased == true ? Colors.white:*/colors.whiteTemp.withOpacity(0.4),
                                                            fontSize: 12),

                                                      ),
                                                    ),
                                                  ),
                                                )

                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${branddata[i].name}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: colors.secondary, fontSize: 25),
                                                ),
                                                Text(
                                                  "${branddata[i].genericName}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                                onTap: (){
                                                  deleteAccountDailog(branddata[i].id);
                                                },
                                                child: const Icon(Icons.delete))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 38,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(
                                                        bottomLeft:
                                                        Radius.circular(10)),
                                                    color: colors.darkIcon.withOpacity(0.6)),
                                                child: Center(
                                                    child: Text(
                                                      "By ${branddata[i].companyName}",
                                                      textAlign: TextAlign.center,
                                                      style: const TextStyle(
                                                          color: colors.whiteTemp,
                                                          fontSize: 12),
                                                    )),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                  onTap: () {
                                                    if(role == "1"){ setState((){
                                                      cardId = branddata[i].id;
                                                      brandName =  branddata[i].name;
                                                      brandDes =  branddata[i].genericName;
                                                    });
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GenericRxDosageDetailsScreen(Id:branddata[i].id,isTrueId: true,)));
                                                    }else {
                                                      setState((){
                                                        cardId = branddata[i].id;
                                                        brandName =  branddata[i].name;
                                                        brandDes =  branddata[i].genericName;
                                                      });
                                                      if(!(branddata[i].isDetailPlanSubscribed  ?? false)){
                                                        _showAlertDialog(context,branddata[i].id ?? "");
                                                      }else if ((branddata[i].isDetailsAdded  == true )){
                                                        setState((){
                                                          cardId = branddata[i].id;
                                                          brandName =  branddata[i].name;
                                                          brandDes =  branddata[i].genericName;
                                                        });
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GenericRxDosageDetailsScreen(Id:branddata[i].id,isTrueId: true,)));
                                                      }else{
                                                        setState((){
                                                          cardId = branddata[i].id;
                                                          brandName =  branddata[i].name;
                                                          brandDes =  branddata[i].genericName;
                                                        });
                                                       setState(() {
                                                         cardId = branddata[i].id;
                                                         brandName =  branddata[i].name;
                                                         brandDes =  branddata[i].genericName;
                                                       });
                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GenericRxDosageScreen(id:branddata[i].id,isTrueValue: true,)));
                                                      }
                                                    }

                                                  },
                                                  child: branddata[i].isDetailsAdded == true ?  InkWell(
                                                    child: Container(
                                                      height: 38,
                                                      decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                              bottomRight:
                                                              Radius.circular(10)),
                                                          color: colors.secondary),
                                                      child: Center(
                                                        child:
                                                        Text(
                                                          '${branddata[i].detailText}',
                                                          textAlign: TextAlign.center,
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12),

                                                        ),
                                                      ),
                                                    ),
                                                  ) : Container(
                                                    height: 38,
                                                    decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            bottomRight:
                                                            Radius.circular(10)),
                                                        color: colors.red ),
                                                    child: Center(
                                                      child:
                                                      BlinkText(
                                                          '${branddata[i].detailText}',
                                                          textAlign: TextAlign.center,
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12),
                                                          beginColor: colors.blackTemp,
                                                          endColor: colors.whiteTemp,
                                                          times: 1000,
                                                          duration: const Duration(seconds: 1)),
                                                    ),
                                                  )


                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              }

                            }),
                const SizedBox(height: 20,),
                getBrandModel?.data == null ? const SizedBox() :
                role == "1" ? const SizedBox.shrink():getBrandModel?.data?.length == 0 ? const SizedBox.shrink():  const Text(
                  "Thank you,\nYour brand with generic name and\n"
                      "company name uploaded successfully\n"
                      "for Doctor's side in this app for promotion\n"
                      " It is displayed in Generics & Brands and Speciality Brands in dashboard of apps",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/3.5,),

              ],
            ),
          ),
        ),
      ),
    );
  }
  TextEditingController searchController = TextEditingController();
  Future<Null> _refresh() {
    return callApi();
  }
  Future<Null> callApi() async {
    getBrandApi();
  }
  GetBrandModel? getBrandModel;
  List<BrandData> brandList= [];
  searchCard(){
    return  Padding(
      padding: const EdgeInsets.only(left: 2,right: 2),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: colors.blackTemp.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: colors.primary,
                ),
                hintText: 'Search brand'),
            onChanged: (value) {
              setState(() {
                searchProduct(value);
              });
            },
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
  searchProduct(String value) {
    if (value.isEmpty) {
      getBrandApi();
      setState(() {
      });
    } else if(value.length == 3) {
      // getGenericApi();
      final suggestions = brandList.where((element) {
        final productTitle = element.name!.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle.contains(input);
      }).toList();
      brandList = suggestions;
      setState(() {
      });
    }
  }
  getBrandApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId");
    var headers = {
      'Cookie': 'ci_session=87531d167d460becac4ab2de220e6b1aa7a800bd'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${ApiService.getBrandApi}'));
    request.fields.addAll(
        {
          'user_id': role == "2" ? userId.toString() : '',
          'category_id': catId.toString(),
          'type':"0"
        });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetBrandModel.fromJson(jsonDecode(result));
      setState(() {
        getBrandModel = finalResult;
        brandList = finalResult.data ?? [];
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  String? userId,role;
  getRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId");
    role = preferences.getString("roll");
  }
  brandDeleteApi(String? brandId) async {
    var headers = {
      'Cookie': 'ci_session=adb41a117ba8fbbc33351cded960bfbb379d3e71'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.deleteBrandListApi}'));
    request.fields.addAll({
      'brand_id': brandId.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =  await response.stream.bytesToString();
      var finalResult =  jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor: colors.secondary);
      getBrandApi();
    }
    else {
      print(response.reasonPhrase);
    }

  }

  @override
  void initState() {
    super.initState();
    getRole();
    getBrandApi();
    callApi();
  }

  void _showAlertDialog(BuildContext context,String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
              height: MediaQuery.of(context).size.height/1.6,
              width: double.infinity,
              child: Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Detail layout of ',
                      style: TextStyle(fontSize: 13,color: colors.blackTemp),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'BRAND DETAILS AREA',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: colors.blackTemp)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Image.asset("assets/images/generic.png"),
                  const SizedBox(height: 30,),
                  role == "2" ? InkWell(
                    onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BrandDetailsPlansScreen())).then((value) {
                      if(value !=null){
                        callApi();
                      }
                    });
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
                            text: const TextSpan(
                              text: 'Subscribe now to upload ',style: TextStyle(fontSize: 11),
                              children: <TextSpan>[
                                TextSpan(text: 'BRAND MODEL', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                              ],
                            ),
                          ),
                        )

                    ),
                  ):const SizedBox.shrink()
                ],
              )),
          // actions: [],
        );
      },
    );
  }
}
