import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Color.dart';
import '../New_model/GetSelectCatModel.dart';
import '../New_model/GetSliderModel.dart';
import '../api/api_services.dart';
import '../widgets/widgets/commen_slider.dart';
import 'generic_brand_details_screen.dart';

String? catName,catId;

class GenericBrandScreen extends StatefulWidget {
  const GenericBrandScreen({Key? key}) : super(key: key);

  @override
  State<GenericBrandScreen> createState() => _GenericBrandScreenState();
}

class _GenericBrandScreenState extends State<GenericBrandScreen> {
  @override
  void initState() {
    super.initState();
    getSliderApi();
    getGenericApi();
  }
  String ?role;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title: Text("Generics & Brands"),
          backgroundColor: colors.secondary,
          centerTitle: true,
          leading: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              },
              child: Icon(Icons.arrow_back_ios))),
      // appBar: customAppBar(context: context, text:"Generics & Brands", isTrue: true, ),
      body:selectCatModel?.data == null ? Center(child: CircularProgressIndicator()): selectCatModel?.data?.length == 0 ? Center(child: Text("No Category List Found !!!")) : SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _CarouselSlider(),
                Positioned(
                  top: 130,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  _buildDots(),),

                ),


              ],
            ),
            SizedBox(height: 15,),
            staticText(),
            categoryListCard()

          ],
        ),
      ),
    );
  }
  staticText(){
    return Column(
      children: [
        role == "1"? SizedBox.shrink():  Text("Add your brand as per below",style: TextStyle(
          color: colors.blackTemp
        ),),
        Text("GENERIC MEDICINE CATEGORY",style: TextStyle(
            color: colors.secondary,fontWeight: FontWeight.bold,fontSize: 17
        ),)
      ],
    );
  }
  categoryListCard(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 5 /1.8,
              // crossAxisSpacing: 3,
              // mainAxisSpacing: 5
          ),
          itemCount: selectCatModel!.data!.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: (){
                catName =  selectCatModel?.data?[index].name;
                catId =  selectCatModel?.data?[index].id;
              Navigator.push(context, MaterialPageRoute(builder: (context)=>GenericBrandDetailsScreen(catId: selectCatModel!.data![index].id,catName: selectCatModel?.data?[index].name,)));
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("${selectCatModel!.data![index].name}",textAlign: TextAlign.center,style: TextStyle(color: colors.blackTemp,fontSize: 11),)),
                ),
              ),
            );
          }),
    );
  }
  /////////// Slider Code///////////


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
    String type = '/generic_brand_slide';
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
  /////////// Company Api Code///////////
  GetSelectCatModel? selectCatModel;
  getGenericApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     role = preferences.getString('roll');
    var headers = {
      'Cookie': 'ci_session=742f7d5e34b7f410d122da02dbbe7e75f06cadc8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.selectCategory}'));
    request.fields.addAll({
      'roll': '1',
       'cat_type':"4"
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = GetSelectCatModel.fromJson(jsonDecode(result));
      setState(() {
        selectCatModel = finalResult;
      });

    }

    else {
      print(response.reasonPhrase);
    }
  }

}
