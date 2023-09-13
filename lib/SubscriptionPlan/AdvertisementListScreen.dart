import 'dart:convert';

import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../New_model/Adversement_List_model.dart';
import 'addPosterScreen.dart';

class AdvertisementListScreen extends StatefulWidget {
  const AdvertisementListScreen({Key? key}) : super(key: key);

  @override
  State<AdvertisementListScreen> createState() => _AdvertisementListScreenState();
}

class _AdvertisementListScreenState extends State<AdvertisementListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdvertisementListApi();
  }

  deleteAccountDailog(String? brandId) async {
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStater) {
                return

                  AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    content: Text(
                        "Are you sure you want \nto delete Generics & Brands ?",
                        style: TextStyle(color: colors.secondary,fontSize: 16)
                    ),
                    actions: <Widget>[
                      TextButton(
                          child: Text( "NO",style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                      TextButton(
                          child:  Text( "YES",style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            deleteAdvertisementApi(brandId);
                            Navigator.of(context).pop(false);
                            // SettingProvider settingProvider =
                            // Provider.of<SettingProvider>(context, listen: false);
                            // settingProvider.clearUserSession(context);
                            // //favList.clear();
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     '/home', (Route<dynamic> route) => false);
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
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        // pageBuilder: null
        pageBuilder: (context, animation1, animation2) {
          return Container();
        } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
    );
  }
  var adv;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Advertisement List", isTrue: true, ),
      body:adversementListModel == null || adversementListModel == "" ?Center(child: CircularProgressIndicator()) : adversementListModel!.data!.length == 0 ? Center(child: Text("no advertisement data !!!")):SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: adversementListModel!.data!.length,
            itemBuilder: (context,i){
             adv = adversementListModel!.data![i];
            print('__________${adv.speciality}_________');
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: colors.whiteTemp,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
                 ),
                child: Column(
                  children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(10),
                       child: Image.network("${adv.image}",fit: BoxFit.fill,height: 150,width: double.infinity,)),
                     SizedBox(height: 20,),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(
                             child: InkWell(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPosterScreen(id: adversementListModel!.data![i].id,isTrue: true,)));
                               },
                               child: Container(
                                   height: 30,
                                   decoration:BoxDecoration(
                                       color: colors.primary,
                                       borderRadius: BorderRadius.circular(10)
                                   ) ,
                                   child: Center(child: Text("Edit Advertisement",style: TextStyle(color: colors.whiteTemp),))),
                             ),
                           ),
                           SizedBox(width: 5),
                           Expanded(
                             child: InkWell(
                               onTap: (){
                                 deleteAccountDailog(adversementListModel!.data![i].id);
                               },
                               child: Container(
                                 height: 30,
                                 decoration:BoxDecoration(
                                   color: colors.primary,
                                   borderRadius: BorderRadius.circular(10)
                                 ) ,
                                   child: Center(child: Text("Delete Advertisement",style: TextStyle(color: colors.whiteTemp),))),
                             ),
                           ),
                         ],
                       ),
                     )
                  ],
                )

          )
          );
        }),
      ),
    );
  }
  AdversementListModel? adversementListModel;
  getAdvertisementListApi() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? userId = prefs.getString("userId");
     print('______userId____${userId}_________');
    var headers = {
      'Cookie': 'ci_session=d23d6cf3108e12a0914f5225c6bbf7c18ac5be52'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.advertisementListApi}'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result =  await response.stream.bytesToString();
     var finalResult = AdversementListModel.fromJson(jsonDecode(result));
     print('_____finalResult_____${finalResult}_________');
     setState(() {
       adversementListModel = finalResult;
     });

    }
    else {
    print(response.reasonPhrase);
    }

  }
  
  deleteAdvertisementApi(String ? advId) async {
    var headers = {
      'Cookie': 'ci_session=4ad5d84675a24446609ba8364edaa851ece314b3'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.deleteAdvertisementListApi}'));
    request.fields.addAll({
      'id': advId.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result =  await response.stream.bytesToString();
     var finalResult =  jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor: colors.secondary);
      getAdvertisementListApi();
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
