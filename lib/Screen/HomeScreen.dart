import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/AuthenticationView/LoginScreen.dart';
import 'package:doctorapp/Booking/booking_screen.dart';
import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/Screen/Histroy.dart';
import 'package:doctorapp/Static/privacy_Policy.dart';
import 'package:doctorapp/api/api_services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthenticationView/fogotPass.dart';
import '../Awreness/Awareness_Inputs_screen.dart';
import '../BrandSpecialization/brand_specialization.dart';
import '../DoctorRequest/doctor_request.dart';
import '../Editorial/editorial.dart';
import '../Event/event_and_webiner.dart';
import '../FreeGrafix/free_grafix.dart';
import '../Generic&Brand/advertisement_screen.dart';
import '../Generic&Brand/generic_brand_screen.dart';
import '../Generic&Brand/slider_plan_screen.dart';
import '../New_model/Check_plan_model.dart';
import '../New_model/GetCountingModel.dart';
import '../New_model/GetSelectCatModel.dart';
import '../New_model/GetSliderModel.dart';
import '../New_model/getUserProfileModel.dart';
import '../Profile/UpdateNew.dart';
import '../Profile/Update_password.dart';
import '../Profile/clinic_hospital_update.dart';
import '../Profile/profile_screen.dart';
import '../SubscriptionPlan/AdvertisementListScreen.dart';
import '../SubscriptionPlan/addPosterScreen.dart';
import '../SubscriptionPlan/subscription_plan.dart';
import '../widgets/widgets/commen_slider.dart';
import '../Product/Pharma_product_screen.dart';
import 'NotificationLIst.dart';
import 'WishlistScreen.dart';

import '../Static/terms_condition.dart';
import '../News/update_screen.dart';
import 'filte_speciality.dart';

class HomeScreen extends StatefulWidget {
  final bool? speciality;
  const HomeScreen({
    Key? key, this.speciality
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  SpeciplyData? localFilter;
  int currentindex = 0;

  GetUserProfileModel? getprofile;

  getuserProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=d9075fff59f39b7a82c03ca267be8899c1a9fbf8'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getUserProfile}'));
    request.fields.addAll({'user_id': '$userId'});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse =
          GetUserProfileModel.fromJson(json.decode(finalResult));

      setState(() {
        getprofile = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  GetSelectCatModel? selectCatModel;

  getCatApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? Roll = preferences.getString('roll');
    String? userId = preferences.getString('userId');

    var headers = {
      'Cookie': 'ci_session=742f7d5e34b7f410d122da02dbbe7e75f06cadc8'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.selectCategory}'));
    request.fields.addAll({'roll': "1", 'cat_type': "2", 'user_id': '$userId'});

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final finalResult = GetSelectCatModel.fromJson(jsonDecode(result));

      String? speciality;

      finalResult.data?.forEach((element) {
        if(element.isSelected ?? false) {
          speciality = element.id ;
        }
      });
      preferences.setString('specialityId', speciality ?? '');
      setState(() {
        selectCatModel = finalResult;
        getCounting();
      });
    } else {
      print(response.reasonPhrase);
    }
  }
  _CarouselSlider1() {
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
          autoPlayAnimationDuration: Duration(milliseconds: 500),
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          height: 180.0),
         items: _sliderModel?.data?.map((item) {
        return CommonSlider(file: item.image ?? '', link: item.link ?? '');
      }).toList(),
    );
  }
  GetSliderModel? _sliderModel;
  getSliderApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? specialityId = preferences.getString('specialityId');
    String? localId = preferences.getString('LocalId');
    String type = '/main_dashboard';
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
  GetCountingModel? countingModel;
  getCounting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     role = preferences.getString('roll');
    userId = preferences.getString('userId');
    String? specialityId = preferences.getString('specialityId');
    String? localId = preferences.getString('LocalId');
    var headers = {
      'Cookie': 'ci_session=3ea10fa720ffb83b4465c35fc49dc217178fc84a'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getCounting}'));
    request.fields.addAll({
      'user_id': role == "1" ? userId.toString():"",
      'type': role == "1" ? "doctor" : "pharma",
      'speciality_id': localId==null || localId== '' ? specialityId ?? '' : localId
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      final finalResult = GetCountingModel.fromJson(jsonDecode(result));
      setState(() {
        countingModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }

  }

  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      return getuserProfile();
    });
    getSliderApi();
    getCatApi();
    if(widget.speciality == true){
      setState(() {
        getCatApi();
      });
    }
  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }
  Future<Null> callApi() async {
    getuserProfile();
    getSliderApi();
    getCounting();
    getCatApi();

  }
  String? role ;
  String? userId;

  setFilterDataId( String id) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('LocalId', id );
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Exit"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colors.primary),
                    child: Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colors.primary),
                    child: Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        return true;
      },
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Scaffold(
          backgroundColor: colors.whiteScaffold,
          key: _key,
          drawer: getDrawer(),
          //appBar: customAppBar(context: context, text:"My Dashboard", isTrue: true, ),
          body:countingModel == null || countingModel == "" ? Center(child: CircularProgressIndicator()) : countingModel!.data!.length == 0 ? Center(child: Text('No Data Found!!'))
              : SafeArea(
            child: Column(
              children: [
                Container(
                  height: 63,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          colors.primary,
                          colors.secondary,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.02, 1]),

                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(1),
                      //
                      bottomRight: Radius.circular(1),
                    ),
                    //   color: (Theme.of(context).colorScheme.apcolor)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.dehaze_rounded,
                              color: colors.whiteTemp,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15,left: 0),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterSpeciality())).then((value){
                              if(value!=null){
                                localFilter = value ;
                                setFilterDataId(localFilter?.id.toString() ?? '');
                                getCounting();
                                setState(() {});
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                const Text('Select Speciality',style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold),),
                                selectCatModel?.data == null
                                    ? CircularProgressIndicator()
                                    : Container(
                                       height: 29,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: selectCatModel?.data?.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        if (selectCatModel?.data?[index].isSelected ==
                                            true) {
                                          return InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterSpeciality())).then((value){
                                                if(value!=null){
                                                  localFilter = value ;
                                                  setFilterDataId(localFilter?.id.toString() ?? '');
                                                  getCounting();
                                                  setState(() {});
                                                }
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Container(
                                                // width: 250,
                                                child: Center(
                                                  child: localFilter == null ? Text(
                                                    '${selectCatModel?.data?[index].name.toString()}',style: TextStyle(color: colors.whiteTemp,),
                                                    overflow: TextOverflow.ellipsis,
                                                  ) : Text(
                                             '${localFilter?.name.toString()}',style: TextStyle(color: colors.whiteTemp,),
                                            overflow: TextOverflow.ellipsis,

                                                ),
                                              ),
                                            ),
                                          ));
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                         children: [
                           InkWell(
                             onTap: () {
                               // Navigator.pop(context);
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) => NotificationList(),
                                   ));
                             },
                             child: Padding(
                               padding: const EdgeInsets.only(right: 10),
                               child: Image.asset("assets/images/noti.png",height: 22,width: 22,),
                             ),
                           ),
                           InkWell(
                             onTap: () {
                               // Navigator.pop(context);
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) => Wishlist(),
                                   ));
                             },
                             child: Padding(
                               padding: const EdgeInsets.only(right: 10),
                               child: Icon(
                                 Icons.favorite,
                                 color: colors.whiteTemp,
                               ),
                             ),
                           ),
                         ],
                  )

                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      //height: 200,
                      width: double.maxFinite,
                      child: _sliderModel == null
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: colors.primary,
                            ))
                          : _CarouselSlider1(),
                    ),
                    Positioned(
                      bottom: 20,
                      // left: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildDots(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                _NewsUpdatecard(),
                // SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _currentPost = 0;
  List<Widget> _buildDots() {
    List<Widget> dots = [];
    if (_sliderModel == null) {
    } else {
      for (int i = 0; i < _sliderModel!.data!.length; i++) {
        dots.add(
          Container(
            margin: EdgeInsets.all(1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i ? colors.secondary : colors.primary,
            ),
          ),
        );
      }
    }
    return dots;
  }

  newsCard(int i) {

    return InkWell(
      onTap: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
         role = preferences.getString('roll');

        if (i == 0) {
          Navigator.push(
              // context, MaterialPageRoute(builder: (C) => UpdsateScreen()));
             context, MaterialPageRoute(builder: (C) =>DoctorRequest()));
        } else if (i == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (C) => GenericBrandScreen()));
        } else if (i == 2) {
          Navigator.push(context,
              // MaterialPageRoute(builder: (C) => PharmaProductScreen()));
              // MaterialPageRoute(builder: (C) => AwarenessScreen()));
              MaterialPageRoute(builder: (C) => BrandSpecialization()));
        } else if (i == 3) {
          Navigator.push(
             // context, MaterialPageRoute(builder: (C) => Editorial()));
             //   context, MaterialPageRoute(builder: (C) => EventAndWebiner()));
               context, MaterialPageRoute(builder: (C) => AwarenessScreen()));

        } else if (i == 4) {
          Navigator.push(
              // context, MaterialPageRoute(builder: (C) => FreeGraphicScreen()));
              context, MaterialPageRoute(builder: (C) => EventAndWebiner()));
              // context, MaterialPageRoute(builder: (C) => AdvertisementScreen()));

        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (C) => AddPosterScreen()));

        }
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                          colors: [
                            colors.secondary,
                            colors.primary,

                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [.04,.8]),
                      image: DecorationImage(
                          image: NetworkImage('${countingModel?.data?[i].image}', scale: 2),
                      )),

                ),
                countingModel?.data?[i].counter == "0" ||
                        countingModel?.data?[i].counter == ""
                    ? SizedBox()
                    : Positioned(
                        right: 40,
                        top: 10,
                        height: 20,
                        width: 20,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(60)),
                          child: Center(
                              child: Text(
                            "${countingModel?.data?[i].counter}",
                            style: TextStyle(color: Colors.white),
                          )),
                        ))
              ]),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${countingModel?.data?[i].title}",
                style: TextStyle(color: colors.secondary, fontWeight: FontWeight.w600  ),
              ),
              const SizedBox(height: 5,)
            ],
          )),
    );
  }

  _NewsUpdatecard() {
    return Container(
      child:  GridView.builder(
              primary: false,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: countingModel?.data?.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 1,
                  // childAspectRatio: 3/2.5
                  childAspectRatio: 3 / 2.6),
              itemBuilder: (context, index) {
                return newsCard(index);
              },
            ),
    );
  }

  getDrawer() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 1.3,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [colors.primary, colors.secondary],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // main
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    "${getprofile?.user?.profilePic}",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),

                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            getprofile?.user?.userData==null? "not found" : "${getprofile?.user?.userData?.first.title}",
                            style: TextStyle(
                                color: colors.whiteTemp,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${getprofile?.user?.username}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                   role == "1"  ? Text(
                        "Degree - ${getprofile?.user?.degree}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ):
                   Container(
                     width: 150,
                     child: Text(
                       "${getprofile?.user?.userData?.first.categoryId}",overflow: TextOverflow.ellipsis,maxLines: 1,
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 15,
                           fontWeight: FontWeight.w500),
                     ),
                   ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          "${getprofile?.user?.email}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                           getprofile?.user?.userData?.first.cityName == null ? Text("No City Name",style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal),) :Text("${getprofile?.user?.userData?.first.cityName}",style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  colors.white10,
                  colors.primary,
                ],
              ),
            ),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: Image.asset(
                  "assets/images/MY PROFILE.png",
                  // color: colors.black54,
                  scale: 1.3,
                  height: 40,
                  width: 40,
                ),
              ),
              title: Text(
                ' My Profile',
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (Context) => ProfileScreen()));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomeScreen()),
                // );
              },
            ),
          ),

         role == "1"  ? ListTile(
            leading: Image.asset(
              "assets/images/UPDATE.png",
              // color: colors.black54,
              height: 35,
              width: 40,
            ),
            title: Text(
              'Update Clinic/Hospital',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClinicHospitalUpdate()),
              );
            },
          ):SizedBox.shrink(),

          ListTile(
            leading: Image.asset(
              "assets/images/home.png",
              // color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: Text(
              'Home',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),

          role == "1" ?  ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Image.asset(
                "assets/images/BOOKING.png",
                // color: colors.black54,
                height: 23,
                width: 30,
              ),
            ),
            title: Text(
              'Booking',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>BookingScreen()),
              );
            },
          ):SizedBox.shrink(),

          ListTile(
            leading: Image.asset(
              "assets/images/SUBSCRIPTION PLAN.png",
              // color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: Text(
              'Subscription Plan',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubscriptionPlan()),
              );
            },
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Image.asset(
                "assets/images/HISTORY.png",
                // color: colors.black54,
                height: 26,
                width: 30,
              ),
            ),
            title: Text(
              'History',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => History()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/WISHLIST.png",
              // color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: Text(
              'Wishlist',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wishlist()),
              );
            },
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 5,),
              child: Image.asset("assets/images/notification.png",
                color: colors.darkIcon.withOpacity(0.6),
                height: 27,
                width: 30,
              )
            ),


            title: Text(
              'Notification',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationList(),),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/CHANGE PASSWORD.png",
              // color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: Text(
              'Change Password',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateNew()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/advertisement.png",
               color: colors.black54,
              height: 35,
              width: 35,
            ),
            title: Text(
              'Advertisements List',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdvertisementListScreen()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/Term & Conditions.png",
              height: 40,
              width: 40,
              // color: colors.black54,
            ),
            title: Text(
              'Terms &Conditions',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsCondition()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/PRIVACY POLICY.png",
              // color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: Text(
              'Privacy Policy',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicy()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/SHARE APP.png",
              // color: colors.black54,
              height: 40,
              width: 40,
            ),
            title: Text(
              'Share App',
            ),
            onTap: () {
              share();
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => HomeScreen()),
              //   );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/DELETE.png",
              // color: colors.black54,
              height: 25,
              width: 40,
            ),
            title: Text(
              'Delete Account',
            ),
            onTap: () {
              deleteAccountDailog();
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => HomeScreen()),
              //   );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/SIGN OUT.png",
              // color: colors.black54,
              height: 40,
              width: 40,
              //color: Colors.grey.withOpacity(0.8),
            ),
            title: Text(
              'Sign Out',
            ),
            onTap: () async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirm Sign out"),
                      content: Text("Are  sure to sign out from app now?"),
                      actions: <Widget>[
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: colors.primary),
                          child: Text("YES"),
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.clear();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                        ),
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: colors.primary),
                          child: Text("NO"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }


  deleteAccountDailog() async {
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStater) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  content: Text(
                      "Are you sure you want to delete?",
                      style: TextStyle(color: colors.primary)
                  ),
                  actions: <Widget>[
                    TextButton(
                        child: Text( "NO",style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        }),
                    TextButton(
                        child:  Text( "YES",style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          deleteAccount();
                          Navigator.of(context).pop(false);
                          // SettingProvider settingProvider =
                          // Provider.of<SettingProvider>(context, listen: false);
                          // settingProvider.clearUserSession(context);
                          // //favList.clear();
                          // Navigator.of(context).pushNamedAndRemoveUntil(
                          //     '/home', (Route<dynamic> route) => false);
                        })
                  ],
                );
              });
        }));
  }
  dialogAnimate(BuildContext context, Widget dialge) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(opacity: a1.value, child: dialge),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        // pageBuilder: null
        pageBuilder: (context, animation1, animation2) {
          return Container();
        } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
    );
  }
  Future<void> share() async {
    await FlutterShare.share(
        title: 'DR.Apps',
        // text: 'Example share text',
        linkUrl: 'https://developmentalphawizz.com/dr_booking/',
        chooserTitle: 'DR.Apps'
    );
  }
  deleteAccount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     String? userID = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=96944ca78b243ab8f0408ccfec94c5f2d8ca05fc'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.deleteApi}'));
    request.fields.addAll({
      'user_id': userID.toString()
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       var result = await response.stream.bytesToString();
       var finalResult =  jsonDecode(result);
       Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor: colors.secondary);
       Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
