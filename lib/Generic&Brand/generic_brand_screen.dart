import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetSelectCatModel.dart';
import '../New_model/Get_company_model.dart';
import '../New_model/New_slider_model.dart';
import '../Product/CustomCommanSlider.dart';
import '../api/api_services.dart';
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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: customAppBar(context: context, text:"Generic & Brand", isTrue: true, ),
      body:selectCatModel?.data == null ? Center(child: CircularProgressIndicator()): selectCatModel?.data?.length == 0 ? Center(child: Text("No Category List Found !!!")) : SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                sliderGeneric(),
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
        Text("Add your brand as per below",style: TextStyle(
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GenericBrandDetailsScreen(catId: selectCatModel!.data![index].id,catName: selectCatModel?.data?[index].name,)));
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("${selectCatModel!.data![index].name}",textAlign: TextAlign.center,style: TextStyle(color: colors.black54,fontSize: 11),)),
                ),
              ),
            );
          }),
    );
  }
  /////////// Slider Code///////////
  sliderGeneric(){
    return CarouselSlider(
      options: CarouselOptions(
          viewportFraction: 1.0,
          onPageChanged: (index, result) {
            setState(() {
              _currentPost = index;
            });
          },
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration:
          Duration(milliseconds: 150),
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          height: 200.0),
      items: newSliderModel?.data.map((item) {
        return
          Builder(
            builder: (BuildContext context) {
              return
                CustomCommanSlider(
                    file: item.image ?? '',
                    typeID: item.typeId ?? '');

            },
          );
      }).toList(),
    );
  }
  /////////// Dots Code/////////////
  int _currentPost =  0;
  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < (newSliderModel?.data.length ?? 10); i++) {
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
  /////////// Slider Api Code///////////
  NewSliderModel ? newSliderModel;
  getSliderApi() async {
    String type = '/pharma_product_slide';
    var headers = {
      'Cookie': 'ci_session=2c9c44fe592a74acad0121151a1d8648d7a78062'
    };
    var request =
    http.Request('GET', Uri.parse('${ApiService.getPharmaSlider}$type'));
    // print('__________${}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      final finalResult = NewSliderModel.fromJson(json.decode(result));
      setState(() {
        newSliderModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  /////////// Company Api Code///////////
  GetSelectCatModel? selectCatModel;
  getGenericApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? roll = preferences.getString('roll');
    print("getRoll--------------->${roll}");
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
        print('_____finalResult_____${finalResult}_________');
      });

    }

    else {
      print(response.reasonPhrase);
    }
  }

}
