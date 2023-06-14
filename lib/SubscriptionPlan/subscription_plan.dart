import 'dart:convert';

import 'package:doctorapp/Helper/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Appbar.dart';
import '../New_model/Get_plan.dart';
import '../Screen/HomeScreen.dart';
import '../api/api_services.dart';

class SubscriptionPlan extends StatefulWidget {
  const SubscriptionPlan({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {

  Razorpay? _razorpay;
  int? pricerazorpayy;
  @override
  void initState() {
    // TODO: implement initState
    getSubscriptionPlanApi();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
 // List<DataListPlan>  getPlan = [];
  GetPlan? getPlan;
  getSubscriptionPlanApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? role = preferences.getString('roll');
    var headers = {
      'Cookie': 'ci_session=fd488e599591e4d13d6ae441c1876300c07b77d5'
    };
    var request = http.MultipartRequest('POST', Uri.parse("${ApiService.getSubsriptionApi}"));
    request.fields.addAll({
      'user_id': '$userId',
      'type':role =="1" ?"doctor":'pharma'
    });
    print('_____Surendra_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result = await response.stream.bytesToString();
     print('_____result_____${result}_________');
     var finalResult = GetPlan.fromJson(json.decode(result));
     setState(() {
       getPlan = finalResult;
     });
     for(var i=0;i<getPlan!.data!.length;i++){
       print("ddddddddd${getPlan!.data![i].isPurchased}");
     }
    }
    else {
    print(response.reasonPhrase);
    }

  }
  getplanPurchaseSuccessApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? role = preferences.getString('roll');
    var headers = {
      'Cookie': 'ci_session=ea151b5bcdbac5bedcb5f7c9ab074e9316352d04'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getPlanPurchasApi}'));
    request.fields.addAll({
      'plan_id':id,
      'user_id': '$userId',
      'transaction_id': 'TestingTransactions',
      'type':role =="1" ?"doctor":'pharma'
    });
    print('_____fields_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
   var result =   await response.stream.bytesToString();
   final finalResult = json.decode(result);
   Fluttertoast.showToast(msg: finalResult['message']);

   print('____Sdfdfdfdff______${finalResult}_________');
   setState(() {

   });
   Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
    else {
    print(response.reasonPhrase);
    }
  }
  String id = '';

  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy= int.parse(res.toStringAsFixed(0)) * 100;
    print("checking razorpay price ${pricerazorpayy.toString()}");

    print("checking razorpay price ${pricerazorpayy.toString()}");
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "${pricerazorpayy}",
      'name': 'Dr.Apps',
      'image':'assets/splash/splashimages.png',
      'description': 'Dr.Apps',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }


  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Subscription added successfully");
    getplanPurchaseSuccessApi();
   // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment cancelled by user");
    // setSnackbar("ERROR", context);
    // setSnackbar("Payment cancelled by user", context);
  }
  void _handleExternalWallet(ExternalWalletResponse response) {
  }
// bool isPurchased
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Subscription Plan", isTrue: true, ),
      body: Column(
        children: [
         getPlan == null  || getPlan == ""?Center(child: CircularProgressIndicator()): Container(
           height: MediaQuery.of(context).size.height/1.2,
            width: double.infinity,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: getPlan!.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  print("ccccccccccccccc ${getPlan!.data![index].isPurchased}");
                  return InkWell(
                    onTap: (){
                      // price = int.parse(getPlan!.data![index].amount ?? '') ;
                      // print("checking razorpay price ${price}");
                      if(getPlan!.data![index].isPurchased ?? false){
                        Fluttertoast.showToast(msg: "You all ready purchased plan",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor:colors.secondary,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }else{
                        openCheckout(getPlan!.data![index].amount);
                        id =getPlan!.data![index].id ?? '' ;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            elevation: 5,
                            child: Container(
                              height: MediaQuery.of(context).size.width/1.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/bacImages.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child:  Column(
                                children: [
                                  SizedBox(height: 60,),
                                  Text(
                                    "${getPlan!.data![index].name}",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: colors.whiteTemp),
                                  ),
                                  SizedBox(height: 150,),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("₹ ${getPlan!.data![index].amount}",style: TextStyle(color: colors.secondary,fontWeight: FontWeight.bold,fontSize: 20,decoration: TextDecoration.underline,
                                      decorationThickness: 2, height: 2.5,),),
                                  ),
                                  SizedBox(height: 8),
                                  Text( "${getPlan!.data![index].time}",style: TextStyle(color: colors.blackTemp),),
                                  SizedBox(height: 8),
                                  Text( "${getPlan!.data![index].description}"),
                                  SizedBox(height: 8),

                                  SizedBox(height: 80),
                                  getPlan!.data![index].isPurchased == true ? Padding(
                                    padding: const EdgeInsets.only(left: 20,right: 20),
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            stops: [0.1, 0.7,],
                                            colors: [
                                              colors.secondary,
                                              colors.secondary

                                            ],
                                          ),
                                          //color: colors.secondary,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text("Purchased",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 18),)),
                                    ),
                                  ):Padding(
                                    padding: const EdgeInsets.only(left: 20,right: 20),
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            stops: [0.1, 0.7,],
                                            colors: [
                                              colors.secondary,
                                              colors.secondary

                                            ],
                                          ),
                                          //color: colors.secondary,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text("Buy Now",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 18),)),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),


                        ),
                      )
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
