import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetSliderModel.dart';
import '../New_model/Get_request_model.dart';
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
    getRequestApi();
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
      body: getRequestModel  ==  null ? Center(child: CircularProgressIndicator(color: colors.primary,)) :  getRequestModel!.data == 0 ? Text("No Doctor Resquest !!"):ListView(
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
    return Container(
      child: ListView.separated(
      physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        reverse: true,
        itemCount: getRequestModel!.data!.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return  Card(
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
                        child:  getRequestModel!.data![index].userImage == null ? Container(
                            height: 70,
                            width: 70  ,
                            child: CircleAvatar()):ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                              child: Container(
                                color: colors.blackTemp,
                                
                          height: 70,
                          width: 70,
                          child: Image.network("${getRequestModel!.data![index].userImage}")),
                            )
                      ),
                      SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Dr.${getRequestModel!.data![index].name}",style: TextStyle(
                              color: colors.secondary,fontWeight: FontWeight.bold
                          ),),
                          Text("Degree-${getRequestModel!.data![index].docDigree}",style: TextStyle(color: colors.blackTemp),),

                        ],
                      ),

                    ],
                  ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${getRequestModel!.data![index].type}",style: TextStyle(color: colors.secondary,fontWeight: FontWeight.bold,fontSize: 20),),

                          Divider(
                            color: colors.black54,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Request for :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                              getRequestModel!.data![index].type  == "Awareness inputs" ?Text("${getRequestModel!.data![index].json!.request}",):Text("${getRequestModel!.data![index].json!.awarenessRequest}",)
                            ],
                          ),
                          Divider(
                            color: colors.black54,
                          ),
                          getRequestModel!.data![index].type  == "Awareness inputs" ||  getRequestModel!.data![index].type == "Worlds Awareness Day inputs" ?  SizedBox.shrink(): Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Dr.Association Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.drAssociation}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ) ,
                          getRequestModel!.data![index].type == "Event Invitation Designs" ?  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Event Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.eventName}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                        getRequestModel!.data![index].type == "Online Webinar Invitation Designs" ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.place}",),
                                ],
                              ),
                              Divider(
                                // indent: 5,
                                // endIndent: 5,
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getRequestModel!.data![index].type == "Worlds Awareness Day inputs" ?  SizedBox.shrink(): Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Topic :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.topic}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ) ,

                          getRequestModel!.data![index].type == "Worlds Awareness Day inputs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Awarenes Day:",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.awarenessDay}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getRequestModel!.data![index].type == "CME Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Speaker Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.speakerName}",),
                                  SizedBox(height: 3,),
                                  Text("${getRequestModel!.data![index].json!.speakerNameDedree}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getRequestModel!.data![index].type == "CME Invitation Designs"  ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Moderator Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.moderator}",),
                                  SizedBox(height: 3,),
                                  Text("${getRequestModel!.data![index].json!.degreeModerator}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),

                          getRequestModel!.data![index].type == "CME Invitation Designs" ||getRequestModel!.data![index].type == "Event Invitation Designs" ||  getRequestModel!.data![index].type == "Online Webinar Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.date}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getRequestModel!.data![index].type == "CME Invitation Designs" ||getRequestModel!.data![index].type == "Event Invitation Designs" ||  getRequestModel!.data![index].type == "Online Webinar Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Time :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.time}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getRequestModel!.data![index].type == "CME Invitation Designs" ?  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.place}",),
                                ],
                              ),
                              Divider(
                                // indent: 5,
                                // endIndent: 5,
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          getRequestModel!.data![index].type == "Event Invitation Designs" ?  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.place}",),
                                ],
                              ),
                              Divider(
                                // indent: 5,
                                // endIndent: 5,
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                           getRequestModel!.data![index].type == "Online Webinar Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Speaker Dr.Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.speakerName}",),
                                 SizedBox(height: 2,),
                                 Text("${getRequestModel!.data![index].json!.speakerNameDedree}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                      getRequestModel!.data![index].type == "Online Webinar Invitation Designs"   ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Moderator :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.moderator}",),
                                  Text("${getRequestModel!.data![index].json!.degreeModerator}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                         getRequestModel!.data![index].type == "Event Invitation Designs" ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Conference Secretariat Dr Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.conference}",),
                                  SizedBox.shrink(),
                                  Text("${getRequestModel!.data![index].json!.degreeConference}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("For Clinic or Hospital Name :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.clinicHospital}",),
                                ],
                              ),
                              Divider(
                                color: colors.black54,
                              ),
                            ],
                          ),
                          getRequestModel!.data![index].type == "Awareness inputs" || getRequestModel!.data![index].type == "Worlds Awareness Day inputs" ?  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Place :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.place}",),
                                ],
                              ),
                              Divider(
                                // indent: 5,
                                // endIndent: 5,
                                color: colors.black54,
                              ),
                            ],
                          ):SizedBox.shrink(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Dr.Contact Email Id  :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                  Text("${getRequestModel!.data![index].json!.email}",),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: colors.blackTemp.withOpacity(0.4))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Message for Pharma Company :",style: TextStyle(color: colors.black54,fontWeight: FontWeight.bold),),
                                      Text("${getRequestModel!.data![index].json!.message}",),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          )

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
  GetRequestModel ? getRequestModel;
  getRequestApi() async {
    var headers = {
      'Cookie': 'ci_session=c09a9cb1d96b25ad537166ce10be5c5b1dfd73b0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getRequestApi}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result = await response.stream.bytesToString();
     var finalResult = GetRequestModel.fromJson(json.decode(result));
     setState(() {
       getRequestModel = finalResult;
       print('__finalResult________${finalResult}_________');
     });
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
