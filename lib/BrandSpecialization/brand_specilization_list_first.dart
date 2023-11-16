import 'dart:convert';

import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Generic&Brand/generic_brand_screen.dart';

import '../Helper/Color.dart';
import '../New_model/Get_brand_model.dart';
import 'package:http/http.dart'as http;

import '../api/api_services.dart';
import 'brand_specialization.dart';

String? cardId,brandName,brandDes;
class BrandSpecilizationList extends StatefulWidget {
    BrandSpecilizationList({Key? key,this.catId, this.catName}) : super(key: key,);
  String? catId, catName;
  @override
  State<BrandSpecilizationList> createState() => _BrandSpecilizationListState();
}

class _BrandSpecilizationListState extends State<BrandSpecilizationList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =  GlobalKey<RefreshIndicatorState>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
  return RefreshIndicator(
    key: _refreshIndicatorKey,
    onRefresh: _refresh,
    child: Scaffold(

      appBar: AppBar(
          title: const Text("Speciality Brands"),
          backgroundColor: colors.secondary,
          centerTitle: true,
          leading: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const BrandSpecialization()));
              },
              child: const Icon(Icons.arrow_back_ios))),
      body: getBrandModel == null || getBrandModel  == "" ?   const Center(child: CircularProgressIndicator()):Padding(
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
             role == "2"?const SizedBox(): searchCard(),
              const SizedBox(height: 8,),
              getBrandModel == null? const Center(child: CircularProgressIndicator()): getBrandModel?.data?.length == 0? const Center(child: Padding(
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
                                         /// Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandSpecializationDetails(Id:branddata[i].id,isTrueId: true,brand:branddata[i].name,des: branddata[i].genericName,)));
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
                                          ///  Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandSpecializationDetails(Id:branddata[i].id,isTrueId: true,)));
                                          }else{
                                            setState((){
                                              cardId = branddata[i].id;
                                              brandName =  branddata[i].name;
                                              brandDes =  branddata[i].genericName;
                                            });
                                         ///  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BrandSpecilizationUpload(id:branddata[i].id)));
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
                                       //Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandSpecializationDetails(Id:branddata[i].id,isTrueId: true,)));
                                          }else{
                                            setState((){
                                              cardId = branddata[i].id;
                                              brandName =  branddata[i].name;
                                              brandDes =  branddata[i].genericName;
                                            });
                                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BrandSpecilizationUpload(id:branddata[i].id)));
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
                        color: colors.whiteTemp,
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
                                     ///  Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandSpecializationDetails(Id:branddata[i].id,isTrueId: true,)));
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
                                       ///  Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandSpecializationDetails(Id:branddata[i].id,isTrueId: true,)));
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
                                        ///   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BrandSpecilizationUpload(id:branddata[i].id,isTrueValue: true,)));
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

              SizedBox(height: MediaQuery.of(context).size.height/3.5,),

            ],
          ),
        ),
      ),
    ),
  );

  }

  Future<Null> _refresh() {
    return callApi();
  }
  Future<Null> callApi() async {
    getBrandApi();
  }

  GetBrandModel? getBrandModel;
  List<BrandData> brandList= [];
  getBrandApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId");
    var headers = {
      'Cookie': 'ci_session=87531d167d460becac4ab2de220e6b1aa7a800bd'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${ApiService.getBrandApi}'));
    request.fields.addAll(
        {'user_id': role == "2" ? userId.toString() : '', 'category_id': catName.toString(),});
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
                hintText: 'Search company'),
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
        final productTitle = element.companyName!.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle.contains(input);
      }).toList();
      brandList = suggestions;
      setState(() {
      });
    }
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
                  // Container(
                  //   height: 50,
                  //  decoration: BoxDecoration(
                  //    border: Border.all(color: colors.blackTemp)
                  //  ),
                  //   child: Center(child: Text("Logo upload area\n image size : 200 pixel * 100 pixed",style: TextStyle(fontSize: 12),)),
                  // ),

                  const SizedBox(height: 30,),
                  role == "2" ? InkWell(
                    onTap: (){
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BrandDetailsPlansScreen())).then((value) {
                      //   if(value !=null){
                      //     callApi();
                      //   }
                      // });
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
