import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/New_model/GetSliderModel.dart';
import 'package:doctorapp/New_model/Get_search_model.dart';
import 'package:doctorapp/widgets/widgets/awareness_list_card.dart';
import 'package:doctorapp/widgets/widgets/commen_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../Event/event_and_webiner.dart';
import '../FreeGrafix/FreeGraphicDetails.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import 'package:http/http.dart'as http;

import '../New_model/GetAwarenessModel.dart';
import '../New_model/Get_graphic_model.dart';
import '../Screen/video_testing.dart';
import '../api/api_services.dart';
import '../Awreness/AddAwrenessPost.dart';
String? Roll;
String? localId;
String? specialityId;
class AwarenessScreen extends StatefulWidget {
  const AwarenessScreen({Key? key}) : super(key: key);

  @override
  State<AwarenessScreen> createState() => _AwarenessScreenState();
}

class _AwarenessScreenState extends State<AwarenessScreen> {
  late VideoPlayerController _controller;
  List<bool> isPlayed = [];
   final List <VideoPlayerController> _vController = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGarphiApi();
    getSliderApi();
    getAwarenessList();
    String date = dateTime.substring(11,16);
    getrole();
  }
  String dateTime = '2023-03-24 16:09:30';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();


  getrole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Roll = preferences.getString('roll');
    specialityId = preferences.getString('specialityId');
     localId = preferences.getString('LocalId');
  }

  bool isSliderLoading = false ;
  bool isScreenLoading = false ;

  Future<Null> _refresh() {
    return callApi();
  }

  Future<Null> callApi() async {
    getAwarenessList();
  }
  int _currentIndex = 0;
  GetAModel? getAwareNess;
  getAwarenessList() async {
    setState(() {
      isScreenLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    specialityId = preferences.getString('specialityId');
      String? localId = preferences.getString('LocalId');
    var headers = {
      'Cookie': 'ci_session=24cf09ce78eebd805097f2d1bcece02c6e418346'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getAwareness}'));
    request.fields.addAll({
      'user_id': '$userId',
      'speciality_id': localId==null || localId== ''  ?  specialityId ?? '' : localId
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result  = await response.stream.bytesToString();
      final finalResult = GetAModel.fromJson(jsonDecode(result));

      setState(() {
        getAwareNess = finalResult;
        isScreenLoading = false;
      });

      for(var i=0;i<(getAwareNess?.data.video?.length ?? 5);i++){
        // _vController.add(VideoPlayerController.network(jsonResponse.data![i].video.toString()));
          _vController.add(VideoPlayerController.network(getAwareNess!.data.video![i].image.toString())..initialize().then((value){
          setState(() {
          });
        }));
        isPlayed.add(false);
      }
    }
    else {
      print(response.reasonPhrase);
      setState(() {
        isScreenLoading = false;
      });
    }
  }

  getdeleteApi(String idAll,String typeAll) async {
    var headers = {
      'Cookie': 'ci_session=4548ca39e40940b85343dc590f98edbf5418c5a4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getDeleteAwarenessApi}'));
    request.fields.addAll({
      'type': typeAll.toString(),
      'id': idAll.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var  reslut   = await response.stream.bytesToString();
     var finalReslut  =  jsonDecode(reslut);
     setState(() {
       Fluttertoast.showToast(msg: "${finalReslut['message']}",backgroundColor: colors.secondary);
     });
     getAwarenessList();
    }
    else {
    print(response.reasonPhrase);
    }

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
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration:
          Duration(milliseconds: 500),
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          height: 200.0),
      items: _sliderModel!.data!.map((item) {
        return CommonSlider(file: item.image.toString() ?? '', link: item.link ?? '');
      }).toList(),
    );

  }
  GetSliderModel? _sliderModel ;
  getSliderApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? specialityId = preferences.getString('specialityId');
    String? localId = preferences.getString('LocalId');
    isSliderLoading = true;
    setState(() {

    });
    String type = '/awareness';
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

        isSliderLoading = false;

      });
    } else {
      print(response.reasonPhrase);
    }
  }
  TextEditingController searchController = TextEditingController();
  GetSearchModel?  getSearchModel;
  getSearchListApi(String v) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=73057c266192adca72d009505c074949facaf6b7'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getAwareness}'));
    request.fields.addAll({
      'user_id': '$userId',
      'search': v.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      getAwarenessList();
     final result =  await response.stream.bytesToString();
     final finalResult = GetSearchModel.fromJson(jsonDecode(result));
     setState(() {
       getSearchModel = finalResult;
     });

    }
    else {
    print(response.reasonPhrase);
    }

  }
  getNewWishlistApi(String id, String event) async {
    isScreenLoading = true ;
    setState(() {});
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? Roll = preferences.getString('roll');
    specialityId = preferences.getString('specialityId');
    var headers = {
      'Cookie': 'ci_session=3d55d84af76cc51db413ee4ccdea5fff824134e1'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.addNewWishListApi}'));
    request.fields.addAll({
      'roll': '$Roll',
      'user_id': '$userId',
      'prod_id': '$id',
      'status': '1',
      'type': '$event',
      'speciality_id':specialityId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final finalResult = json.decode(result);

      Fluttertoast.showToast(msg: finalResult['message'],backgroundColor: colors.secondary);

      isScreenLoading = false ;
      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
      isScreenLoading = false ;
      setState(() {

      });
    }

  }
  int selectedSegmentVal = 0;
  bool iconVisible = true;
  bool iconVisible1 = true;
  bool iconVisible2 = true;
  bool iconVisible3 = true;
  ScreenshotController screenshotController = ScreenshotController();

  setSegmentValue(int i) {
    selectedSegmentVal = i;
    String status;
    if (i == 0) {
      status = 'Ongoing';
    } else if (i == 1) {
      status = 'Complete';
    }
    setState(() {
      getAwarenessList();
    });
    // getOrderList(status: status);
  }
searchProduct(String value) {
  if (value.isEmpty) {
    getAwarenessList();
    setState(() {
    });
  } else {
    if(selectedSegmentVal == 0){
      final suggestions = getAwareNess?.data.mPoster?.where((element) {
        final productTitle = element.title?.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle!.contains(input);
      }).toList();
      getAwareNess?.data.mPoster= suggestions!;
      setState(() {

      });
    }if(selectedSegmentVal == 1){
      final suggestions = getAwareNess?.data.booklets?.where((element) {
        final productTitle = element.title?.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle!.contains(input);
      }).toList();
      getAwareNess?.data.booklets= suggestions!;
      setState(() {

      });
    }if(selectedSegmentVal == 2){
      final suggestions = getAwareNess?.data.leaflets?.where((element) {
        final productTitle = element.title?.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle!.contains(input);
      }).toList();
      getAwareNess?.data.leaflets= suggestions!;
      setState(() {

      });
    }
    if(selectedSegmentVal == 3){
      final suggestions = getAwareNess?.data.poster?.where((element) {
        final productTitle = element.title?.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle!.contains(input);
      }).toList();
      getAwareNess?.data.poster= suggestions!;
      setState(() {
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: Scaffold(
          floatingActionButton: Roll == "2" ? InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAwanessPost()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Container(
                decoration:  BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.circular(10)
                ),
                height: 50,
                width: MediaQuery.of(context).size.width/1.1,
                  child: Center(child: Text("Add Awareness Inputs",style: TextStyle(color: colors.whiteTemp,fontSize: 18),)),
              ),
            ),
          ):SizedBox.shrink(),
          appBar: AppBar(
            backgroundColor: colors.secondary,
            centerTitle: true,
            leading:InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back_ios_new_outlined,color: colors.whiteTemp,),
                )
            ),
            title: Text("Awareness Inputs"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.maxFinite,
                      child: isSliderLoading ? const Center(child: CircularProgressIndicator(
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
                  child: Container(
                    height: 50,
                    child: TextFormField(
                        controller: searchController,
                        decoration:InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            prefixIcon:  Icon(Icons.search,color: colors.black54,),
                            contentPadding: EdgeInsets.only(top: 5),
                            hintText: "Search...."
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchProduct(value);
                          });
                        }
                    ),
                  ),
                ),
                _segmentButton(),
                SizedBox(
                  // height: MediaQuery.of(context).size.height/1.0,
                    child: isScreenLoading ? const Center(child: CircularProgressIndicator())
                        :
                    selectedSegmentVal == 0 ? getAwareNess?.data.poster?.isEmpty ?? false ? Center(child: Text('Poster not available'),)

                    : ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: getAwareNess!.data.poster?.length ?? 5,
                        itemBuilder: (BuildContext context, int index) {
                          return AwarenessListCard(currentIndex: 0,index: index,getAwareNess: getAwareNess, vController: _vController,onTop: (){
                            getdeleteApi(getAwareNess?.data.poster?[index].id ?? "" ,getAwareNess?.data.poster?[index].type ?? "");
                          },); //getPosterList(getAwareNess?.data.mPoster, index);
                        })
                        :  selectedSegmentVal == 1 ? getAwareNess?.data.booklets?.isEmpty ?? false  ? Center(child: Text('Booklets not available'),)
                        : ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: getAwareNess?.data.booklets?.length ?? 5,
                        itemBuilder: (BuildContext context, int index1) {
                          return AwarenessListCard(currentIndex: 1,index: index1,getAwareNess: getAwareNess,type: "book",vController: _vController,onTop: ()
                            {
                              getdeleteApi(getAwareNess?.data.booklets?[index1].id ?? "" ,getAwareNess?.data.booklets?[index1].type ?? "");
                            },); // bookletsList(getAwareNess?.data.booklets, index);
                        }) :
                         selectedSegmentVal == 2 ? getAwareNess?.data.leaflets?.isEmpty ?? true ? Center(child: Text('Leaflets not available'),)
                       :  ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: getAwareNess?.data.leaflets?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AwarenessListCard(currentIndex: 2,index: index,getAwareNess: getAwareNess,type:"lead",vController: _vController,onTop: (){
                            getdeleteApi(getAwareNess?.data.leaflets?[index].id ?? "" ,getAwareNess?.data.leaflets?[index].type ?? "");
                          },); // getLeafletList(getAwareNess?.data.leaflets, index);
                        })
                        :
                         selectedSegmentVal == 3 ? getAwareNess?.data.mPoster?.isEmpty ?? true ? Center(child: Text('Motivational Poster not available'),) :
                        ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: getAwareNess!.data.mPoster?.length??5,
                        itemBuilder: (BuildContext context, int index) {
                          return AwarenessListCard(currentIndex: 3,index: index,getAwareNess: getAwareNess,vController: _vController,onTop: (){
                            getdeleteApi(getAwareNess?.data.mPoster?[index].id ?? "" ,getAwareNess?.data.mPoster?[index].type ?? "");
                          },); // getMotimationList(getAwareNess?.data.poster, index);
                        })
                        : selectedSegmentVal == 4 ? getAwareNess?.data.video?.isEmpty ?? true ? Center(child: Text('video not available'),):
                    ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: getAwareNess?.data.video?.length ?? 5,
                        itemBuilder: (BuildContext context, int index) {
                          return getVideoList(getAwareNess?.data.video,index);
                        })
                        :
                        ListView.builder(
                      // scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: getGraphicModel!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return freeGraphic(getGraphicModel!.data, index);
                     })
                ),

                SizedBox(height: 70,)

              ],
            )
          ),
        ),
      ),
    );
  }

  Widget _segmentButton() =>
      SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 0
                        ? [colors.primary, colors.primary]
                        : [colors.lightBlue, colors.lightBlue])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(0),
              child: Center(
                child: Text(

                  'Patient Awareness Poster',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: selectedSegmentVal == 0
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 1
                        ? [colors.primary, colors.primary]
                        : [colors.lightBlue, colors.lightBlue])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(1),
              child: Text(
                'Patient Awareness Booklet',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 1
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            height: 60,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 2
                        ? [colors.primary, colors.primary]
                        : [colors.lightBlue, colors.lightBlue])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(2),
              child: Text(
                'Patient Awareness Leaflet',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 2
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            height: 60,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 3
                        ? [colors.primary, colors.primary]
                        : [colors.lightBlue, colors.lightBlue])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(3),
              child: Text(
                'Patient Motivational Poster',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 3
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            height: 60,
            width: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 4
                        ? [colors.primary, colors.primary]
                        : [colors.lightBlue, colors.lightBlue])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(4),
              child: Text(
                'Patient Awareness Video',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 4
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            height: 60,
            width: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 5
                        ? [colors.primary, colors.primary]
                        : [colors.lightBlue, colors.lightBlue])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(5),
              child: Text(
                'Free Graphics',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 5
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ],
      ),
    ),
  );
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

  _shareQrCode() async {
    iconVisible = true;
    iconVisible1 = true;
    iconVisible2 = true;
    iconVisible3 = true;
    PermissionStatus storagePermission = await Permission.storage.request();
    if (storagePermission == PermissionStatus.granted) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      screenshotController.capture().then((Uint8List? image) async {
        if (image != null) {
          try {
            String fileName = DateTime
                .now()
                .microsecondsSinceEpoch
                .toString();
            final imagePath = await File('$directory/$fileName.png').create();
            if (imagePath != null) {
              await imagePath.writeAsBytes(image);
              Share.shareFiles([imagePath.path],);
            }
          } catch (error) {}
        }
      }).catchError((onError) {
      });
    } else if (storagePermission == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This Permission is recommended')));
    } else if (storagePermission == PermissionStatus.permanentlyDenied) {
      openAppSettings().then((value) {

      });
    }
  }
  getPosterList(model, int index){
    return  Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child:  Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5,bottom: 8),
                  //   child: CircleAvatar(
                  //     backgroundImage: NetworkImage("${ApiService.imageUrl}${newTypeModel?.data?[i].profileImage}"),
                  //     backgroundColor: colors.primary,
                  //     radius: 25,
                  //   ),
                  // ), //CircleAvatar
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getAwareNess?.data.mPoster?[index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 2,),
                        Text(getAwareNess?.data.mPoster?[index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                        const SizedBox(height: 5,)
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                child: ClipRRect(
                    borderRadius:  BorderRadius.circular(5),
                    child: Image.network("${getAwareNess?.data.mPoster?[index].image}",fit: BoxFit.fill,height: 250,)),
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${getAwareNess?.data.mPoster?[index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),
                      Text('${getAwareNess?.data.mPoster?[index].awareLanguage}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),

                    ],
                  ),
                  iconVisible ?  Row(
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          iconVisible = false;
                        });
                        Future.delayed(Duration(seconds: 1), (){
                          _shareQrCode();
                          // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                        });
                      }, icon: Icon(Icons.share)),
                      IconButton(onPressed: (){
                        setState(() {
                          getNewWishlistApi(getAwareNess?.data.mPoster?[index].id ??'',getAwareNess?.data.mPoster?[index].type ?? "");
                          getAwareNess?.data.mPoster?[index].isSelected = !(getAwareNess?.data.mPoster?[index].isSelected ?? false );
                        });
                      },icon: getAwareNess?.data.mPoster?[index].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,)),
                    ],
                  ):SizedBox.shrink()


                ],
              ),

              SizedBox(height: 10,)

            ],
          ),
        )
    );
  }
  bookletsList(model, int index){
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child:  Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5,bottom: 8),
                  //   child: CircleAvatar(
                  //     backgroundImage: NetworkImage("${ApiService.imageUrl}${newTypeModel?.data?[i].profileImage}"),
                  //     backgroundColor: colors.primary,
                  //     radius: 25,
                  //   ),
                  // ), //CircleAvatar
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getAwareNess?.data.booklets?[index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                        SizedBox(height: 2,),
                        Text(getAwareNess?.data.booklets?[index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                        SizedBox(height: 5,)
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                child: ClipRRect(
                    borderRadius:  BorderRadius.circular(5),
                    child: Image.network("${getAwareNess?.data.booklets?[index].image}",fit: BoxFit.fill,height: 250,)),
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${getAwareNess?.data.booklets?[index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp),),
                      Text('${getAwareNess?.data.booklets?[index].awareLanguage}'),
                    ],
                  ),
                iconVisible1?  Row(
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          iconVisible1 = false;
                        });
                        Future.delayed(Duration(seconds: 1), (){
                          _shareQrCode();
                          // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                        });
                       // _shareQrCode();
                      }, icon: Icon(Icons.share)),
                      IconButton(onPressed: (){
                        setState(() {
                          getNewWishlistApi(getAwareNess?.data.booklets?[index].id ??'',getAwareNess?.data.booklets?[index].type ?? "");
                          getAwareNess?.data.booklets?[index].isSelected = !(getAwareNess?.data.booklets?[index].isSelected ?? false );
                        });
                      },icon: getAwareNess?.data.booklets?[index].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,)),
                    ],
                  ):SizedBox.shrink()
                ],
              ),
              SizedBox(height: 10,)

            ],
          ),
        )
    );
  }
  getLeafletList(model, int index){
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child:  Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5,bottom: 8),
                  //   child: CircleAvatar(
                  //     backgroundImage: NetworkImage("${ApiService.imageUrl}${newTypeModel?.data?[i].profileImage}"),
                  //     backgroundColor: colors.primary,
                  //     radius: 25,
                  //   ),
                  // ), //CircleAvatar
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getAwareNess?.data.leaflets?[index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 2,),
                        Text(getAwareNess?.data.leaflets?[index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                        const SizedBox(height: 5,)
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                child: ClipRRect(
                    borderRadius:  BorderRadius.circular(5),
                    child: Image.network("${getAwareNess?.data.leaflets?[index].image}",fit: BoxFit.fill,height: 250,)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('${getAwareNess?.data.leaflets?[index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),
                      Text('${getAwareNess?.data.leaflets?[index].awareLanguage}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal)),
                    ],
                  ),
                iconVisible2 ?  Row(
                  children: [
                    IconButton(onPressed: (){
                      setState(() {
                        iconVisible2 = false;
                      });
                      Future.delayed(Duration(seconds: 1), (){
                        _shareQrCode();
                        // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                      });
                    }, icon: Icon(Icons.share)),
                    IconButton(onPressed: (){
                      setState(() {
                        getNewWishlistApi(getAwareNess?.data.leaflets?[index].id ??'',getAwareNess?.data.leaflets?[index].type ?? "");
                        getAwareNess?.data.leaflets?[index].isSelected = !(getAwareNess?.data.leaflets?[index].isSelected ?? false );
                      });
                    },icon: getAwareNess?.data.leaflets?[index].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,)),
                  ],
                ):SizedBox.shrink()
              ],
                )



            ],
          ),
        )
    );
  }
  getMotimationList(model, int index){
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child:  Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5,bottom: 8),
                  //   child: CircleAvatar(
                  //     backgroundImage: NetworkImage("${ApiService.imageUrl}${newTypeModel?.data?[i].profileImage}"),
                  //     backgroundColor: colors.primary,
                  //     radius: 25,
                  //   ),
                  // ), //CircleAvatar
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getAwareNess?.data.poster?[index].title ?? 'Title',style: TextStyle(fontSize: 16,color: colors.secondary,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 2,),
                        Text(getAwareNess?.data.poster?[index].date.toString().substring(0,11)?? 'date',style: TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 1,),
                        const SizedBox(height: 5,)
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                child: ClipRRect(
                    borderRadius:  BorderRadius.circular(5),
                    child: Image.network("${getAwareNess?.data.poster?[index].image}",fit: BoxFit.fill,height: 250,)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('${getAwareNess?.data.poster?[index].awareInput}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal),),
                      Text('${getAwareNess?.data.poster?[index].awareLanguage}',style: TextStyle(fontSize: 16,color: colors.blackTemp,fontWeight: FontWeight.normal)),
                    ],
                  ),
                  iconVisible3 ?  Row(
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          iconVisible3 = false;
                        });
                        Future.delayed(Duration(seconds: 1), (){
                          _shareQrCode();
                          // _shareQrCode(eventModel?.data[index].link ?? '', context, eventModel?.data[index].image ?? '');
                        });
                      }, icon: Icon(Icons.share)),
                      IconButton(onPressed: (){
                        setState(() {
                          getNewWishlistApi(getAwareNess?.data.poster?[index].id ??'',getAwareNess?.data.poster?[index].type ?? "");
                          getAwareNess?.data.poster?[index].isSelected = !(getAwareNess?.data.poster?[index].isSelected ?? false );
                        });
                      },icon: getAwareNess?.data.poster?[index].isSelected?? false ?Icon(Icons.favorite,color: colors.red,):Icon(Icons.favorite_outline,color: colors.red,)),
                    ],
                  ):SizedBox.shrink()
                ],
              ),
              SizedBox(height: 10,)

            ],
          ),
        )
    );
  }
   bool _showThumbnail = true;
  getVideoList(model, int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height:MediaQuery.of(context).size.height/3,
        margin: const EdgeInsets.only(bottom: 10),
        child:
        Stack(
          alignment: Alignment.center,
          children: [
            _showThumbnail
                ? Container(
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(10)
                  ),
                  height:MediaQuery.of(context).size.height/3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                     '${getAwareNess?.data.video?[index].thumbnail}',
              // Replace 'thumbnail_url_here' with the actual URL of the thumbnail image
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
                  ),
                )
                : Container( decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: BorderRadius.circular(10),
               ),
                 height:MediaQuery.of(context).size.height/3,
                  child: Column(
                        children: [
                          Container(
                              height:MediaQuery.of(context).size.height/3.4,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AspectRatio(aspectRatio: _vController[index].value.aspectRatio,child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: VideoPlayer(_vController[index])),)),
                         const SizedBox(height: 10,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("${getAwareNess?.data.video?[index].title}",style: const TextStyle(color: colors.whiteTemp),),


                           ],
                         )

                        ],
                      ),
                ),

            _showThumbnail?
            FloatingActionButton(
              onPressed: () {
                setState(() {
                     _showThumbnail = true;
                     isPlayed[index] = false;
                  _showThumbnail= !_showThumbnail;
                });
              },
              child: Icon(Icons.play_arrow),
            )
              :
                 Positioned(
              left: 1,right: 1,
              top: -10,
              bottom: 1,
              //alignment: Alignment.center,
              child: isPlayed[index] == true ? InkWell(
                  onTap: (){
                    setState(() {
                      isPlayed[index] = false;
                      _vController[index].pause();
                    });
                  },
                  child: Icon(Icons.pause,color: Colors.white,)) : InkWell(
                  onTap: (){
                    setState(() {
                      isPlayed[index] = true;
                      _vController[index].play();
                    });
                  },
                  child: Icon(Icons.play_arrow,color: Colors.white,))),
            // VideoPlayer(_vController[index]),

          ],
        ),

      ),
    );
  }

  freeGraphic(model, int index){
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double aspectRatio = 3/3.3;

            if (constraints.maxWidth > constraints.maxHeight * aspectRatio) {
              // Landscape orientation
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: aspectRatio


                ),
                itemCount:getGraphicModel!.data!.length, // Number of items in the grid
                itemBuilder: (BuildContext context, int index) {

                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FreeGraphicDetailsScreen(childList: getGraphicModel!.data![index].childs,)));
                    },
                    child:
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10)
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 140 ,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network("${getGraphicModel!.data![index].image}",fit: BoxFit.fill)),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 85,

                                  child: Text("${getGraphicModel!.data![index].title}",maxLines: 1,style: TextStyle(
                                    color: colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 12,overflow: TextOverflow.ellipsis,
                                  ),),
                                ),

                                Text("${getGraphicModel!.data![index].total}")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              // Portrait orientation
              return GridView.builder (
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: aspectRatio


                ),
                itemCount:getGraphicModel!.data!.length, // Number of items in the grid
                itemBuilder: (BuildContext context, int index) {

                  return InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FreeGraphicDetailsScreen(childList: getGraphicModel!.data![index].childs,)));
                    },
                    child:
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10)
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 140 ,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network("${getGraphicModel!.data![index].image}",fit: BoxFit.fill)),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 85,

                                  child: Text("${getGraphicModel!.data![index].title}",maxLines: 1,style: TextStyle(
                                    color: colors.blackTemp,fontWeight: FontWeight.bold,fontSize: 12,overflow: TextOverflow.ellipsis,
                                  ),),
                                ),

                                Text("${getGraphicModel!.data![index].total}")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        )


    );
  }

  GetGraphicModel? getGraphicModel;
  getGarphiApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=e4dfc99e63f5c529a622db46e6cf829e5af991d9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getGraphicApi}'));
    request.fields.addAll({
      'user_id': userId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =   await response.stream.bytesToString();
      var finalResult = GetGraphicModel.fromJson(json.decode(result));
      setState(() {
        getGraphicModel =  finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
}
