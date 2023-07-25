import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetSliderModel.dart';
import '../api/api_services.dart';
import '../widgets/widgets/commen_slider.dart';
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomSheet: Padding(
       padding: const EdgeInsets.all(8.0),
       child: InkWell(
         onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddRequest()));
         },
         child: Container(
           height: 50,
           decoration: BoxDecoration(color: colors.secondary,borderRadius: BorderRadius.circular(10)),
           child: Center(
             child: Text(
               "Add Request",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 20),
             ),
           ),
         ),
       ),
     ),

      appBar: customAppBar(context: context, text:" Doctor's Request", isTrue: true, ),
      body: ListView(
         children: [
           getSlider(),
           button(),
           viewCard(),
           SizedBox(height: 70,)

         ],
      ),
    );
  }
  viewCard(){
    return  Container(
      child: ListView.separated(
      physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return   Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        child: Container(
                            height: 70,
                            width: 70  ,
                            child: CircleAvatar()),
                      ),
                      SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Dr.Ajay",style: TextStyle(
                              color: colors.secondary,fontWeight: FontWeight.bold
                          ),),
                          Text("Degree-MBBS"),
                          Text("Hello"),
                        ],
                      ),

                    ],
                  ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            // indent: 5,
                            // endIndent: 5,
                            color: colors.blackTemp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Dr.Ajay",),
                              Text("Degree-MBBS"),
                              Text("Hello"),
                            ],
                          ),
                          Divider(
                            // indent: 10,
                            // endIndent: 10,
                            color: colors.blackTemp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Dr.Ajay",),
                              Text("Degree-MBBS"),
                              Text("Hello"),
                            ],
                          ),
                        ],
                      ),
                    )

                ],
              ),
            ),
          );
        },
      ),
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
    String type = '/doctor_news_slide';
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
}
