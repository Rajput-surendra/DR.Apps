import 'package:doctorapp/Registration/hospital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';import '../Helper/Appbar.dart';


import '../Helper/Color.dart';

class StaticTextScreen extends StatefulWidget {
  String title, name, mobile, email,gender,pass,cPass,cityName,stateID,cityID,placeID,degree,profileImages,roll,categoryId,experience;
   StaticTextScreen({Key? key,required this.title,required this.name,required this.mobile,required this.email,required this.gender,required this.cityName,required this.cityID,required this.cPass,required this.pass,required this.degree,required this
      .placeID,required this.profileImages,required this.stateID,required this.roll,required this.categoryId,required this.experience}) : super(key: key);

  @override
  State<StaticTextScreen> createState() => _StaticTextScreenState();
}

class _StaticTextScreenState extends State<StaticTextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"For Doctor Plus", isTrue: true, ),
      bottomSheet: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Hospital(title: widget.title ?? "",name:widget.name
            ,mobile: widget.mobile,email: widget.email,cityID:widget.cityID ?? "",cityName: widget.cityName,
            cPass: widget.cPass,degree:widget.degree,gender: widget.gender,pass: widget.pass,placeID: widget.placeID,
            profileImages: widget.profileImages ?? '',roll: widget.roll,stateID:widget.stateID ?? "",categoryId:widget.categoryId,experience: widget.experience)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: colors.secondary,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text("Next",style: TextStyle(color: colors.whiteTemp),)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dear Doctor,",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text("You are requested to fill this form for our DR Plus apps which are available on play store as well as apple store. It is  designed for people or patients who are searching specialty doctors by area wise, city wise, state wise in India. Our DR Plus apps and websites show details about Doctors, Clinic name, Day, Time, Appointment Detail and also feature for appointment directly though DR Plus Apps and websites. You can also advertise on our Apps which are in the form of jpg (image) or video. You are requested, Please download our DR Plus apps from play store or apple store  and also check our website www.drplusonline.in Thank you",style: TextStyle(fontSize: 16,),textAlign: TextAlign.justify,),
           )

          ],
        ),
      ),
    );
  }
}
