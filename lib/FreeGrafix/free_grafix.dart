import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/FreeGrafix/FreeGraphicDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetSliderModel.dart';
import '../New_model/Get_graphic_model.dart';
import '../api/api_services.dart';
import '../widgets/widgets/commen_slider.dart';

class FreeGraphicScreen extends StatefulWidget {
  const FreeGraphicScreen({Key? key}) : super(key: key);

  @override
  State<FreeGraphicScreen> createState() => _FreeGraphicScreenState();
}

class _FreeGraphicScreenState extends State<FreeGraphicScreen> {

  @override
  void initState() {
    super.initState();
    getSliderApi();
    getGarphiApi();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: customAppBar(context: context, text:"Free Graphic", isTrue: true, ),
      body:
      getGraphicModel?.data == null
          ? Center(child: CircularProgressIndicator()):getGraphicModel?.data?.length == 0 ? Text("No Record Found !!! "):
      SingleChildScrollView(
        child: Column(
         children: [
           Stack(
             alignment: Alignment.bottomCenter,
             children: [
               SizedBox(
                 height: 200,
                 width: double.maxFinite,
                 child: _sliderModel == null? Center(child: CircularProgressIndicator(
                   color: colors.primary,
                 )):_CarouselSlider1(),
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

           ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 3/3.5

              ),
              itemCount:getGraphicModel!.data!.length, // Number of items in the grid
              itemBuilder: (BuildContext context, int index) {

                return InkWell(
                  onTap: (){

                   Navigator.push(context, MaterialPageRoute(builder: (context)=>FreeGraphicDetailsScreen(childList: getGraphicModel!.data![index].childs,)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network("${getGraphicModel!.data![index].image}",fit: BoxFit.fill)),
                        ),
                        SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${getGraphicModel!.data![index].title}",style: TextStyle(
                                    color: colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 12
                                ),),

                                Text("${getGraphicModel!.data![index].total}")
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
           // gridView(),


         ],
        ),
      ),
    );
  }
  GetGraphicModel? getGraphicModel;
  getGarphiApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    print("getEventUserId--------------->${userId}");
    var headers = {
      'Cookie': 'ci_session=e4dfc99e63f5c529a622db46e6cf829e5af991d9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getGraphicApi}'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    print('__________${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
    var result =   await response.stream.bytesToString();
    var finalResult = GetGraphicModel.fromJson(json.decode(result));
    print('_______ssssssss___${finalResult}_________');
    setState(() {
      getGraphicModel =  finalResult;
    });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  GetSliderModel? _sliderModel ;
  getSliderApi() async {
    String type = '/editorial_slide';
    var headers = {
      'Cookie': 'ci_session=2c9c44fe592a74acad0121151a1d8648d7a78062'
    };
    var request = http.Request('GET', Uri.parse('${ApiService.getSlider}$type'));
    request.headers.addAll(headers);
    print("fieldss===========>${request.url}");
    http.StreamedResponse response = await request.send();
    print("response.statusCode===========>${response.statusCode}");
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========>${result}");
      final finalResult = GetSliderModel.fromJson(json.decode(result));
      print("this is a response===========>${finalResult}");
      setState(() {
        _sliderModel = finalResult;

      });
    } else {
      print(response.reasonPhrase);
    }
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
                : Colors.grey.withOpacity(0.5),
          ),
        ),
      );
    }
    return dots;
  }
  _CarouselSlider1(){
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

          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration:
          const Duration(milliseconds: 500),

          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          height: 200.0),
      items: _sliderModel?.data?.map((item) {
        return CommonSlider(file: item.image ?? '', link: item.link ?? '');
      }).toList(),
    );

  }

  Widget gridView(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
           childAspectRatio: 3/3.5

        ),
        itemCount: getGraphicModel?.data?.length, // Number of items in the grid
        itemBuilder: (BuildContext context, int index) {
          // Build individual grid items here
          return Container(
            decoration: BoxDecoration(
                color: colors.blackTemp.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)
            ),

            child: Column(
              children: [
                Container(
                height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      child: Image.network("${getGraphicModel?.data?[index].image}",fit: BoxFit.fill)),
                ),
                Text("dsfdfdfd"),
                Text("dfdf")
              ],
            ),
          );
        },
      ),
    );

  }
}
