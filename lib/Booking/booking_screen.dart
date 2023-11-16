import 'dart:convert';
import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/New_model/booking_model.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../New_model/cencelBookingapi.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

   String? id;
  int? isSelected=0;


  GetBookingDetailsModel? getBookingDetailsModel;
  getBookingDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=9ce8eb13e8d5c2aa354db633884a5ea99e4f1d6e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getBooking}'));
    request.fields.addAll({
      'user_id': userId.toString()
      //id.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =  await response.stream.bytesToString();
      var finalResult =  GetBookingDetailsModel.fromJson(jsonDecode(result));
      setState(() {
        getBookingDetailsModel = finalResult;
      });

    }
    else {
      print(response.reasonPhrase);
    }

  }
  CencelbookingModel?cencelbookingModel;
  acceptedApi(String id ,String status) async {
    var headers = {
      'Cookie': 'ci_session=5a635878f9da494ef0b40bd7b646d7db01adacf3'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.cancleBooking}'));
    request.fields.addAll({
      'id':id.toString(),
      'status': '${status}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult =CencelbookingModel.fromJson(json.decode(Result));
      Fluttertoast.showToast(msg: "${finalResult.message}");
        getBookingDetails();
    }
    else {
    print(response.reasonPhrase);
    }


  }
  deleteApi() async {
    var headers = {
      'Cookie': 'ci_session=a747c1d1c18333959dd066ea89715ea8b440c263'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.deleteBooking}'));
    request.fields.addAll({
      'id': '2'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result = await response.stream.bytesToString();
     var finalResult =  jsonDecode(result);
     Fluttertoast.showToast(msg: "${finalResult['message']}");
    }
    else {
    print(response.reasonPhrase);
    }

  }


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
   new GlobalKey<RefreshIndicatorState>();
   Future<Null> _refresh() {
     return callApi();
   }
   Future<Null> callApi() async {
     getBookingDetails();
   }

  @override
  void initState() {
    // TODO: implement initState
    getBookingDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Scaffold(
        appBar: customAppBar(context: context, text:"Booking", isTrue: true, ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              getBookingDetailsModel == null  ? Center(child: CircularProgressIndicator(),) : getBookingDetailsModel?.data?.length == 0 ? Center(child: Text("No bookings found show")) :
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: getBookingDetailsModel!.data!.length,
                  itemBuilder:
                      (BuildContext context ,int index){

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(horizontal:10,vertical:5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Name :",style: TextStyle(fontWeight: FontWeight.w600),),
                                        const SizedBox(width: 20,),
                                        Text('${getBookingDetailsModel!.data?[index].name}')
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        const Text('User Number : ',style: TextStyle(fontWeight: FontWeight.w600)),
                                        const SizedBox(width:5,),
                                        Container(
                                            width: 90,
                                            child: Text("${getBookingDetailsModel!.data?[index].userMobile}",overflow: TextOverflow.ellipsis,)),

                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        const Text("Age : ",style: TextStyle(fontWeight: FontWeight.w600)),
                                        const SizedBox(width: 30,),
                                        Text('${getBookingDetailsModel!.data?[index].age}')
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        const Text("Day : ",style: TextStyle(fontWeight: FontWeight.w600)),
                                        const SizedBox(width: 30,),
                                        Text("${getBookingDetailsModel!.data?[index].day}")
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        const Text("Date : ",style: TextStyle(fontWeight: FontWeight.w600)),
                                        const SizedBox(width:25,),
                                        Text('${getBookingDetailsModel!.data?[index].date}'),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        const Text("Time :",style: TextStyle(fontWeight: FontWeight.w600)),
                                        const SizedBox(width: 25,),
                                        Text('${getBookingDetailsModel!.data?[index].timeslotText}')
                                      ],
                                    ),
                                    SizedBox(height: 5,),


                                  ],
                                ),
                                Column(
                                  children: [

                                        getBookingDetailsModel!.data![index].status == "2" ? Container(
                                         height: 35,
                                         width: 60,
                                         decoration: BoxDecoration(
                                          color:colors.yellow,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text("Cancelled",style: TextStyle(color:colors.whiteTemp,fontSize:10),)),
                                    ) : getBookingDetailsModel!.data![index].status == "3" ?
                               Container(
                                   height: 35,
                                   width: 60,
                                   decoration: BoxDecoration(
                                       color:Colors.green,
                                       borderRadius: BorderRadius.circular(10)
                                   ),
                                   child:Center(child:getBookingDetailsModel!.data![index].status=='1'?Text("Accept",style: TextStyle(color:colors.whiteTemp,fontSize:10),):Text("Accepted",style: TextStyle(color:colors.whiteTemp,fontSize:10),))
                               ) : Column(
                                 children: [

                                    InkWell(
                                     onTap: () {
                                       acceptedApi("${getBookingDetailsModel!.data![index].id}","2");
                                     },
                                     child: Container(
                                       height: 35,
                                       width: 60,
                                       decoration: BoxDecoration(
                                           color:Colors.red,
                                           borderRadius: BorderRadius.circular(10)
                                       ),
                                       child: Center(child: Text("Cencel",style: TextStyle(color:colors.whiteTemp,fontSize:10),)),
                                     ),
                                   ),
                                   const SizedBox(height: 10,),
                                   InkWell(
                                     onTap: () {
                                       acceptedApi("${getBookingDetailsModel!.data![index].id}","3");
                                     },
                                     child: Container(
                                         height: 35,
                                         width: 60,
                                         decoration: BoxDecoration(
                                             color:Colors.green,
                                             borderRadius: BorderRadius.circular(10)
                                         ),
                                         child:Center(child:Text("Accept",style: TextStyle(color:colors.whiteTemp,fontSize:10),))
                                     ),
                                   )

                                 ],
                               ),

                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],),
        )
      ),
    );
  }
}
