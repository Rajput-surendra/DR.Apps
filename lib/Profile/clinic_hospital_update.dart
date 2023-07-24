import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
import '../New_model/getUserProfileModel.dart';
import '../api/api_services.dart';
import 'package:http/http.dart'as http;
List <String>_selectedItems2 = [];
class ClinicHospitalUpdate extends StatefulWidget {
   ClinicHospitalUpdate({Key? key,}) : super(key: key);



  @override
  State<ClinicHospitalUpdate> createState() => _ClinicHospitalUpdateState();
}

class _ClinicHospitalUpdateState extends State<ClinicHospitalUpdate> {
bool isLoder = false;
List<TextEditingController> dayConatroller = [];
List<TextEditingController> morningTimeController = [];
List<TextEditingController> morningTimeEndController = [];
List<TextEditingController> eveingTimeController = [];
List<TextEditingController> eveingTimeEndController = [];
List<TextEditingController> appointNOController = [];
List<TextEditingController> clinicController = [];
List<TextEditingController> hospitalController = [];
List<String> daysLists = [];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserProfile();

  }
  
  updatedDataApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=7defbd920541b86a7a1531a4e7de2e4779440cbe'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getUpdateClinicDetailsApi}'));
    request.fields.addAll({
      'user_id': userId.toString(),
      'json':newList.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResul = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResul['message']}");
    }
    else {
    print(response.reasonPhrase);
    }

  }
  GetUserProfileModel? getprofile;
  getuserProfile() async {
    setState(() {
      isLoder == true ? const Center(child: CircularProgressIndicator()):SizedBox();
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');

    var headers = {
      'Cookie': 'ci_session=9aba5e78ffa799cbe054723c796d2bd8f2f7d120'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getUserProfile}'));
    request.fields.addAll({'user_id': "${userId}"});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = GetUserProfileModel.fromJson(json.decode(finalResult));
      setState(() {
        getprofile = jsonResponse;
      });
         getprofile!.user!.userData!.first.clinics!.forEach((element) {
          // dayConatroller.add(getprofile!.user!.userData.clinics.first.day.split(pattern))
          // dayConatroller.add(TextEditingController(text:element.day!.split(',').first));
           results = element.day?.split(",");
        grandResults.add(results ?? []);

        morningTimeController.add(TextEditingController(text:element.morningShift!.split('-').first));
        morningTimeEndController.add(TextEditingController(text:element.morningShift!.split('-')[1]));
        eveingTimeController.add(TextEditingController(text:element.eveningShift!.split('-').first));
        eveingTimeEndController.add(TextEditingController(text:element.eveningShift!.split('-')[1]));
        appointNOController.add(TextEditingController(text:element.appointNumber!));
        clinicController.add(TextEditingController(text:element.clinicName!));
        hospitalController.add(TextEditingController(text:element.addresses!));

      });
    } else {
      print(response.reasonPhrase);
    }
  }
   List newList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Update Clinic/Hospital", isTrue: true, ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getprofile?.user?.userData?.isEmpty ?? false ?
            Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("No Clinic/Hospital Data!!"),
            )):
            getprofile?.user?.userData?.first.clinics == 0  ?
            Text("No Clinic?Hospital Data!!") : SizedBox(
              // height: MediaQuery.of(context).size.height/1.1,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:getprofile?.user?.userData?.first.clinics?.length ?? 0 ,
                itemBuilder: (context, index) {
                  return
                    getData(index);
                }
                ,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  for(int i = 0; i< getprofile!.user!.userData![0].clinics!.length; i++){
                    newList.add(jsonEncode({
                      "id":getprofile!.user!.userData![0].clinics![i].id,
                        "day":grandResults[i].toString(),
                      "morning_shift":morningTimeController[i].text + "-"+ morningTimeEndController[i].text,
                      "evening_shift":eveingTimeController[i].text + "-" + eveingTimeEndController[i].text,
                      "addresses":hospitalController[i].text,
                      "appoint_number":appointNOController[i].text,
                      "clinic_name": clinicController[i].text
                    }));
                   print('______ddd____${newList}_________');

                  }
                 if(newList.isEmpty){
                  Fluttertoast.showToast(msg: "jksbdfcbsdf;dsfn");
                 }else{
                   // updatedDataApi();
                 }
                  print('__sadsadsds________${newList}_________');

                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: colors.secondary),
                  child: Center(child: Text("Update ",style: TextStyle(color: colors.whiteTemp),)),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTime1;
  TimeOfDay? _selectedTimeNew;
  TimeOfDay? _selectedTimeOld;
  List<String>? results;
  List<List<String>> grandResults = [];

  List? results1;
  void _showMultiSelect(int i) async {
    grandResults[i] = await showDialog(
        context: context,
        builder: (BuildContext context) {
          // dayConatroller[i].text = _selectedItems2.toString();
          return StatefulBuilder(
              builder: (context, setState)
              {
                return
                  MultiSelect();
              }
          );
        }
    );
    setState(() {

    });

    print("checking result here ${results.runtimeType}");



  }
  Future<void> _selectTime(BuildContext context,int i) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime) {

      setState(() {
        _selectedTime = pickedTime;
        morningTimeController[i].text = _selectedTime!.format(context);
      });
      print('_____sfgfdgfdg_____${_selectedTime!.format(context)}_________');
    }

  }
  Future<void>  chooseTime(BuildContext context, int i) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime1 ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime1) {
      setState(() {
        _selectedTime1 = pickedTime;
        morningTimeEndController[i].text =  _selectedTime1!.format(context);
      });
    }
  }
  Future<void> eveningTimeStart(BuildContext context,int i) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTimeNew ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTimeNew) {

      setState(() {
        _selectedTimeNew = pickedTime;
        eveingTimeController[i].text = _selectedTimeNew!.format(context);

      });
      print('_____sfgfdgfdg_____${_selectedTimeNew!.format(context)}_________');
    }

  }
  Future<void> eveningTimeEnd(BuildContext context ,int i) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTimeOld ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTimeOld) {
      setState(() {
        _selectedTimeOld = pickedTime;
        eveingTimeEndController[i].text = _selectedTimeOld!.format(context);
      });
    }
  }
  Widget select(int i) {
    return InkWell(
      onTap:
      _selectedItems2 == null ? (){
        Fluttertoast.showToast(msg: 'Please Select Days',backgroundColor: colors.secondary);
      }: () {
        setState(() {
          _showMultiSelect(i);
        });
      },
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: colors.white10,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black.withOpacity(0.7))),
          child: results == null
              ? const Padding(
            padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
            child: Text(
              'Select Days',
              style: TextStyle(
                fontSize: 16,
                color: colors.black54,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
              :
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: grandResults[i].map((e){
              return Padding(
                padding: const EdgeInsets.only(top: 10,left: 1,right: 1),
                child: Container(
                    width:45,
                    height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: colors.secondary),
                    child: Center(child: Text("${e}",style: TextStyle(color: colors.whiteTemp),))),
              );
            }).toList(),
          )

      ),
    );
  }
   getData(int i){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15,),
          const Text("Clinic/Hospital Days",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
          const SizedBox(height:15,),
           select(i),
          // TextFormField(
          //   onTap: (){
          //     _showMultiSelect();
          //   },
          //   readOnly: true,
          //   controller: dayConatroller[i],
          //   keyboardType: TextInputType.text,
          //   decoration: InputDecoration(
          //       hintText: 'Day',
          //       hintStyle: TextStyle(
          //           fontSize: 15.0, color: colors.blackTemp),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(10)),
          //       contentPadding: EdgeInsets.only(left: 10, top: 10)
          //   ),
          // ),
          const SizedBox(height:15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(" Morning Shift Start ",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    SizedBox(height: 10,),
                    TextFormField(
                      onTap: (){
                        _selectTime(context,i);
                      },
                      readOnly: true,
                       controller: morningTimeController[i],
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'MorningShift',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.blackTemp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(" Morning Shift End",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    SizedBox(height: 10,),
                    TextFormField(
                      onTap: (){
                        chooseTime(context,i);
                      },
                      readOnly: true,
                      controller: morningTimeEndController[i],
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Morning Shift End',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.blackTemp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
          const SizedBox(height:15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(" Evening Shift Start ",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    SizedBox(height: 10,),
                    TextFormField(
                      onTap: (){
                        eveningTimeStart(context ,i);
                      },
                      readOnly: true,
                      controller: eveingTimeController[i],
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Evening Shift Start',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.blackTemp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(" Evening Shift End",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    SizedBox(height: 10,),
                    TextFormField(
                      onTap: (){
                        eveningTimeEnd(context ,i);
                      },
                      readOnly: true,
                      controller: eveingTimeEndController[i],
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Evening Shift End',
                          hintStyle: TextStyle(
                              fontSize: 15.0, color: colors.blackTemp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10, top: 10)
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
          const SizedBox(height:15,),
          const Text("Clinic/Hospital Name",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
          const SizedBox(height:5,),
          Container(
            child: TextFormField(
              controller: hospitalController[i],
              decoration: InputDecoration(
                  hintText:"Clinic Name",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return "Clinic/Hospital is required";
                }
              },
            ),
          ),
          const SizedBox(height:15,),
          const Text("Clinic/Hospital Address",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
          const SizedBox(height:5,),
          Container(
            child: TextFormField(
              controller: clinicController[i],
              decoration: InputDecoration(
                  hintText:"Address",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return "Clinic/Hospital Address is required";
                }
              },
            ),
          ),
          SizedBox(height:15,),
          const Text("Clinic/Hospital Appointment Number",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
          SizedBox(height:5,),
          Container(
            child: TextFormField(
              controller: appointNOController[i],
              maxLines: 1,
              //maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: "",
                  hintText:"Appointment Number ",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return "Appointment Number is required";
                }
              },

            ),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
class MultiSelect extends StatefulWidget {
  // String type;
  // required this.type
  MultiSelect({Key? key, }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}
class _MultiSelectState extends State<MultiSelect> {
  List selectedItems = [];
  List<String> eventCat = [];
  bool isChecked = false;
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        setState(() {
          _selectedItems2.add(itemValue);
        });
      } else {
        setState(() {
          _selectedItems2.remove(itemValue);
        });
      }
    });
    print("this is selected values ${_selectedItems2.toString()}");
  }
  void _cancel() {
    Navigator.pop(context);
  }
  void _submit() {
    List selectedItem = _selectedItems2.map((item) => item).toList();
    //Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_selectedItems2.clear();
  }
  String finalList = '';
  var dayList = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState)
        {
          return
            AlertDialog(
              title: const Text('Select Days'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: dayList
                      .map((data) =>
                      CheckboxListTile(
                        activeColor: colors.primary,
                        value: _selectedItems2.contains(data),
                        title: Text(data),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) => _itemChange(data, isChecked!),

                      )
                  ).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancel',
                    style: TextStyle(color: colors.primary),),
                  onPressed: _cancel,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: colors.primary
                    ),
                    child: Text('Submit'),
                    onPressed: () {

                      print("selected values are here ${_selectedItems2}");
                      //_submit();

                      Navigator.pop(context, _selectedItems2);

                    }
                ),
              ],
            );
        }
    );
  }

}
