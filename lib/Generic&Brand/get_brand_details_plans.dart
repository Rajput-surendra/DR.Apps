import 'dart:convert';

import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/Get_brand_plan_model.dart';
import 'genericRx_Dosage_Screen.dart';

class BrandDetailsPlansScreen extends StatefulWidget {
  const BrandDetailsPlansScreen({Key? key}) : super(key: key);

  @override
  State<BrandDetailsPlansScreen> createState() => _BrandDetailsPlansScreenState();
}

class _BrandDetailsPlansScreenState extends State<BrandDetailsPlansScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Brand Plans", isTrue: true, ),
      body:getBrandPlanModel == null ? Center(child: CircularProgressIndicator()) : getBrandPlanModel!.data!.length ==0  ? Center(child: Text("No Brand Plan !!")): Column(
        children: [
           Container(
            height: MediaQuery.of(context).size.height/1.4,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: getBrandPlanModel!.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  print("ccccccccccccccc ${getBrandPlanModel!.data![index].isPurchased}");
                  return InkWell(
                    onTap: (){
                      // price = int.parse(getBrandPlanModel!.data![index].amount ?? '') ;
                      // print("checking razorpay price ${price}");
                      if(getBrandPlanModel!.data![index].isPurchased ?? false){
                        Fluttertoast.showToast(msg: "You all ready purchased plan",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor:colors.secondary,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }else{
                        openCheckout(getBrandPlanModel!.data![index].amount);
                        id = getBrandPlanModel!.data![index].id ?? '' ;
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
                                      "${getBrandPlanModel!.data![index].name}",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: colors.whiteTemp),
                                    ),
                                    SizedBox(height: 150,),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("₹ ${getBrandPlanModel!.data![index].amount}",style: TextStyle(color: colors.secondary,fontWeight: FontWeight.bold,fontSize: 20,decoration: TextDecoration.underline,
                                        decorationThickness: 2, height: 2.5,),),
                                    ),
                                    SizedBox(height: 8),
                                    Text( "${getBrandPlanModel!.data![index].time}",style: TextStyle(color: colors.blackTemp),),
                                    SizedBox(height: 8),
                                    Text( "${getBrandPlanModel!.data![index].description}"),
                                    SizedBox(height: 8),

                                    SizedBox(height: 80),
                                    getBrandPlanModel!.data![index].isPurchased == true ? Padding(
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
  GetBrandPlanModel ? getBrandPlanModel;
  String? userId;
  getBrandPlanModelApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId");
    var headers = {
      'Cookie': 'ci_session=8adadafc30f808d5fdbbf9f73cd30f51941ac5bc'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getBrandDetailsPlansApi}'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    print('______finalResult____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       var result = await response.stream.bytesToString();
       var finalResult = GetBrandPlanModel.fromJson(jsonDecode(result));
       setState(() {
         getBrandPlanModel =  finalResult ;
         print('______finalResult____${finalResult}_________');
       });
    }
    else {
    print(response.reasonPhrase);
    }

  }

  getplanPurchaseSuccessApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=ea151b5bcdbac5bedcb5f7c9ab074e9316352d04'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getPlanPurchasApi}'));
    request.fields.addAll({
      'plan_id':id,
      'user_id': '$userId',
      'transaction_id': 'TestingTransactions',
    });
    print('_____fields_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =   await response.stream.bytesToString();
      final finalResult = json.decode(result);
      Fluttertoast.showToast(msg: finalResult['message'],backgroundColor: colors.secondary);

      print('____Sdfdfdfdff______${finalResult}_________');
      setState(() {

      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>GenericRxDosageScreen()));
    }
    else {
      print(response.reasonPhrase);
    }
  }
  @override
  void initState() {
    super.initState();
    getBrandPlanModelApi();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  Razorpay? _razorpay;
  int? priceRazorpay;
  String id = '';
  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    priceRazorpay= int.parse(res.toStringAsFixed(0)) * 100;
    print("checking razorpay price ${priceRazorpay.toString()}");

    print("checking razorpay price ${priceRazorpay.toString()}");
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "${priceRazorpay}",
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
}
