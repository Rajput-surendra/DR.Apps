import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetSliderModel.dart';
import '../New_model/Get_request_model.dart';
import '../api/api_services.dart';
import '../widgets/widgets/commen_slider.dart';
import '../widgets/widgets/request_list_Card.dart';
import 'add_request.dart';

class DoctorRequest extends StatefulWidget {
  const DoctorRequest({Key? key}) : super(key: key);

  @override
  State<DoctorRequest> createState() => _DoctorRequestState();
}


class _DoctorRequestState extends State<DoctorRequest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSliderApi();
    getRequestApi();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isReady = true;
      });
    });
    getRole();
  }

  requetDeleteApi(String requestId) async {
    var headers = {
      'Cookie': 'ci_session=00259d6e0a7ec49be6d7b08508c6ef7452486f4f'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.deleteBooking}'));
    request.fields.addAll({
      'id': requestId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
    var result = await response.stream.bytesToString();
    var finalResult =  jsonDecode(result);
    Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor: colors.secondary);
    getRequestApi();
    }
    else {
    print(response.reasonPhrase);
    }

  }
  String? role;
  String? userId;
  getRole()async{
    SharedPreferences preferences  = await  SharedPreferences.getInstance();
    role = preferences.getString("roll");

  }
  bool iconVisible = true;
  bool _isReady = true ;
  GlobalKey keyList = GlobalKey() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomSheet: role == "1" ?Padding(
       padding: const EdgeInsets.all(8.0),
       child: InkWell(
         onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddRequest()));
         },
         child: Container(
           height: 50,
           decoration: BoxDecoration(color: colors.secondary,borderRadius: BorderRadius.circular(10)),
           child: const Center(
             child: Text(
               "Add Request",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 20),
             ),
           ),
         ),
       ),
     ):SizedBox.shrink(),

      appBar: customAppBar(context: context, text:" Doctor's Request", isTrue: true, ),
      body: ListView(
         children: [
           getSlider(),
           button(),
           getRequestModel  ==  null ?
           Center(child: CircularProgressIndicator(color: colors.primary,)) :
           getRequestModel!.data!.length == 0 ? Center(child: Text("No Doctor Request !!")): viewCard(),
           SizedBox(height: 70,)

         ],
      ),
    );
  }

  wishListApi(String ? requestId) async {
    var headers = {
      'Cookie': 'ci_session=6f1de5370d8c25e7d0c07b421f024a150f5afda9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addWishlistApi}'));
    request.fields.addAll({
      'user_id': userId.toString(),
      'request_id': requestId.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor: colors.secondary);
    }
    else {
    print(response.reasonPhrase);
    }

  }

  viewCard(){
    return Container(
      child: ListView.separated(
      physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        reverse: true,
        itemCount: getRequestModel!.data!.length,
        separatorBuilder: (BuildContext context, int index) =>
        const SizedBox(height: 10,),
        itemBuilder: (BuildContext context, int index) {

          return
            RequestListCard(index: requestDataList.length,getRequestModel:
            requestDataList[index] ,i: index,onTop: (){requetDeleteApi(getRequestModel!.data![index].id ??"");},);

        },
      )
    );


  }
  button(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors.primary
        ),
        child: Center(child: Text("Doctor's Request to Pharma Compaines",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 18),)),
      ),
    );
  }
  getSlider(){
    return  Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 200,
          width: double.maxFinite,
          child: _sliderModel == null? const Center(child: CircularProgressIndicator(
            color: colors.primary,
          )):_CarouselSlider(),
        ),
        Positioned(
          bottom: 20,
          // left: 80,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  _buildDots(),),
        ),

      ],

    );
  }
  int _currentPost =  0;
  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < (_sliderModel?.data?.length ?? 10); i++) {
      dots.add(
        Container(
          margin: EdgeInsets.all(1.5),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPost == i
                ? colors.primary
                : colors.secondary.withOpacity(0.4)
            // Colors.grey.withOpacity(0.5),
          ),
        ),
      );
    }
    return dots;
  }
  _CarouselSlider(){
    return CarouselSlider(
      options: CarouselOptions(
          onPageChanged: (index, result) {
            setState(() {
              _currentPost = index;
            });
          },
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,

          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration:
          Duration(milliseconds: 500),
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          height: 200.0),
      items: _sliderModel?.data?.map((item) {
        return CommonSlider(file: item.image ?? '', link: item.link ?? '');
      }).toList(),
    );

  }
  GetSliderModel? _sliderModel ;
  getSliderApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? specialityId = preferences.getString('specialityId');
    String? localId = preferences.getString('LocalId');
    String type = '/Doctor_Request';
    var headers = {
      'Cookie': 'ci_session=2c9c44fe592a74acad0121151a1d8648d7a78062'
    };
    var request = http.Request('GET', Uri.parse('${ApiService.getPharmaSlider}$type?speciality_id=${localId==null || localId== '' ? specialityId ?? '' : localId}'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      final finalResult = GetSliderModel.fromJson(json.decode(result));
      setState(() {
        _sliderModel = finalResult;

      });
    } else {
      print(response.reasonPhrase);
    }
  }
  List <RequetDataList> requestDataList = [] ;
  String? userIdNew;
  GetRequestModel ? getRequestModel;
  getRequestApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userIdNew = preferences.getString('userId');
    role =  preferences.getString('roll');
    String? specialityId = preferences.getString('specialityId');
    String? localId = preferences.getString('LocalId');

    var headers = {
      'Cookie': 'ci_session=c09a9cb1d96b25ad537166ce10be5c5b1dfd73b0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getRequestApi}'));
    request.fields.addAll({
     'user_id': userIdNew.toString(),
      'type': role == "2" ?"pharma": "doctor",
      'speciality_id': localId == null || localId == '' ? specialityId ?? '' : localId.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result = await response.stream.bytesToString();
     var finalResult = GetRequestModel.fromJson(json.decode(result));
     setState(() {
       getRequestModel = finalResult;
       requestDataList = finalResult.data!;

     });
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
