import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';
List <String>_selectedItems2 = [];
class ClinicHospitalUpdate extends StatefulWidget {
  const ClinicHospitalUpdate({Key? key}) : super(key: key);

  @override
  State<ClinicHospitalUpdate> createState() => _ClinicHospitalUpdateState();
}

class _ClinicHospitalUpdateState extends State<ClinicHospitalUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Update Clinic/Hospital", isTrue: true, ),
      body: Column(
        children: [
          ListView.builder(
            itemCount:5 ,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  getData()
                ],
              );
            }
            ,)

        ],
      ),
    );
  }

  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTime1;
  TimeOfDay? _selectedTimeNew;
  TimeOfDay? _selectedTimeOld;
  List<String>? results;
  List? results1;
  void _showMultiSelect() async {
    results = await showDialog(
        context: context,
        builder: (BuildContext context) {
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
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime) {

      setState(() {
        _selectedTime = pickedTime;
      });
      print('_____sfgfdgfdg_____${_selectedTime!.format(context)}_________');
    }

  }
  Future<void> chooseTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime1 ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime1) {
      setState(() {
        _selectedTime1 = pickedTime;
      });
    }
  }
  Future<void> selectTimeStart(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTimeNew ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTimeNew) {

      setState(() {
        _selectedTimeNew = pickedTime;
      });
      print('_____sfgfdgfdg_____${_selectedTimeNew!.format(context)}_________');
    }

  }
  Future<void> chooseTimeEnd(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTimeOld ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTimeOld) {
      setState(() {
        _selectedTimeOld = pickedTime;
      });
    }
  }
  Widget select() {
    return InkWell(
      onTap:
      _selectedItems2 == null ? (){
        Fluttertoast.showToast(msg: 'Please Select Days',backgroundColor: colors.secondary);
      }: () {
        setState(() {
          _showMultiSelect();
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
            children: results!.map((e){
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

  Widget MorningShift() {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTime != null
                  ? '${_selectedTime!.format(context)}'
                  : 'Morning Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  Widget EveningShift() {
    return  InkWell(
      onTap: () {
        chooseTime(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTime1 != null
                  ? '${_selectedTime1!.format(context)}'
                  : 'Evening Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  Widget MorningShiftStart() {
    return InkWell(
      onTap: () {
        selectTimeStart(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTimeNew != null
                  ? '${_selectedTimeNew!.format(context)}'
                  : 'Morning Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  Widget EveningShiftEnd() {
    return  InkWell(
      onTap: () {
        chooseTimeEnd(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTimeOld != null
                  ? '${_selectedTimeOld!.format(context)}'
                  : 'Evening Shift Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  TextEditingController clinicNameC = TextEditingController();
  TextEditingController addressC = TextEditingController();

  getData(){
    return Column(
      children: [
        const SizedBox(height: 15,),
        const Text("Clinic/Hospital Days",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
        const SizedBox(height:15,),
        select(),
        const SizedBox(height:15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(" Morning Shift Start ",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
                MorningShift(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(" Morning Shift End ",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
                EveningShift(),
              ],
            )

          ],
        ),
        const SizedBox(height:15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(" Evening Shift Start",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                SizedBox(height:5,),
                MorningShiftStart(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(" Evening Shift End ",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                const SizedBox(height:5,),
                EveningShiftEnd(),
              ],
            )


          ],
        ),
        const SizedBox(height:15,),
        const Text("Clinic/Hospital Name",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
        const SizedBox(height:5,),
        Container(
          child: TextFormField(
            controller: clinicNameC,
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
            controller: addressC,
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
            controller: addressC,
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
