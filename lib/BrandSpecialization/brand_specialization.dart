import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Generic&Brand/generic_brand_details_screen.dart';
import '../Generic&Brand/generic_brand_screen.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/GetSelectCatModel.dart';
import '../New_model/New_slider_model.dart';
import '../Product/CustomCommanSlider.dart';
import 'package:http/http.dart'as http;
import '../api/api_services.dart';
import 'brand_specilization_list_first.dart';

class BrandSpecialization extends StatefulWidget {
  const BrandSpecialization({Key? key}) : super(key: key);

  @override
  State<BrandSpecialization> createState() => _BrandSpecializationState();
}

class _BrandSpecializationState extends State<BrandSpecialization> {

  @override
  void initState() {
    super.initState();
    getSliderApi();
    getGenericApi();
  }
  TextEditingController searchController = TextEditingController();
  String ?role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Speciality Brand", isTrue: true, ),
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
            SizedBox(height: 10,),
            searchCard(),
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

  searchCard(){
    return  Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: colors.blackTemp.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                hintText: 'Search Speciality'),
            onChanged: (value) {
              setState(() {
                searchProduct(value);
              });
            },
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
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
          itemCount: specList.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: (){
                catName =  selectCatModel?.data?[index].name;
                catId =  selectCatModel?.data?[index].id;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BrandSpecilizationList(catId: selectCatModel!.data![index].id,catName: selectCatModel?.data?[index].name,)));
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("${specList[index].name}",textAlign: TextAlign.center,style: TextStyle(color: colors.blackTemp,fontSize: 11),)),
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
  List<SpeciplyData> specList= [];
  getGenericApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    role = preferences.getString('roll');
    print("getRoll--------------->${role}");
    var headers = {
      'Cookie': 'ci_session=742f7d5e34b7f410d122da02dbbe7e75f06cadc8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.selectCategory}'));
    request.fields.addAll({
      'roll': '1',
      'cat_type':"5"
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = GetSelectCatModel.fromJson(jsonDecode(result));
      setState(() {
        selectCatModel = finalResult;
        specList = finalResult.data ?? [];
        print('_____finalResult_____${specList}_________');
      });

    }

    else {
      print(response.reasonPhrase);
    }
  }
  searchProduct(String value) {
    if (value.isEmpty) {
      getGenericApi();
      setState(() {
      });
    } else if(value.length == 3) {
     // getGenericApi();
      final suggestions = specList.where((element) {
        final productTitle = element.name!.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle.contains(input);
      }).toList();
      specList = suggestions;
      setState(() {
      });
    }
  }
}
// searchProduct(String value) {
//   if (value.isEmpty) {
//     busSearchApi(value);
//     setState(() {});
//   } else if(value.length==4){
//     busSearchApi(value);
//     final suggestions = busCity.where((element) {
//       final productTitle = element.title!.toLowerCase();
//       final input = value.toLowerCase();
//       return productTitle.contains(input);
//     }).toList();
//     busCity = suggestions;
//     setState(() {
//
//     });
//   }
//   else{
//     final suggestions = busCity.where((element) {
//       final productTitle = element.title!.toLowerCase();
//       final input = value.toLowerCase();
//       return productTitle.contains(input);
//     }).toList();
//     busCity = suggestions;
//     setState(() {
//
//     });
//   }
// }
