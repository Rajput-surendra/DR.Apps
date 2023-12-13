
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../New_model/Get_notification_model.dart';



class NotificationList extends StatefulWidget {

   NotificationList({Key? key,  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => StateNoti();
}



class StateNoti extends State<NotificationList> with TickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController controller = new ScrollController();

  @override
  void initState() {
    getNotificationApi();
    super.initState();
  }

  GetNotificationModel? getNotificationModel;
  getNotificationApi() async {
    SharedPreferences  preferences = await  SharedPreferences.getInstance();
    String ? userId =  preferences.getString("userId");
    var headers = {
      'Cookie': 'ci_session=df5d2c0086921174ef313c606ea7aa6bc52cc05f'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://drplusapp.in/app/v1/api/get_notification'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult =  GetNotificationModel.fromJson(jsonDecode(result));
      setState(() {
        getNotificationModel = finalResult;
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:customAppBar(text: "Notification List", isTrue: true, context: context),
      body: SingleChildScrollView(
        child:getNotificationModel?.data == null ? Center( child: CircularProgressIndicator()):getNotificationModel!.data!.length == 0 ? Center(child: Text("No Notification Kist")) :Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: getNotificationModel!.data!.length,
                itemBuilder: (context,i){
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${getNotificationModel!.data![i].title}"),
                        SizedBox(height: 10,),
                        Text("${getNotificationModel!.data![i].message}"),
                      ],
                    ),
                  )
                ),
              );
            })

          ],
        ),
      ),
    );
  }

}
