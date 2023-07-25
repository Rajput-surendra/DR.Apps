import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Helper/Appbar.dart';
import '../Helper/Color.dart';

class AddRequest extends StatefulWidget {
  const AddRequest({Key? key}) : super(key: key);

  @override
  State<AddRequest> createState() => _AddRequestState();
}
String? selectedValue;
class _AddRequestState extends State<AddRequest> {
  final _formKey = GlobalKey<FormState>();
  String? awarenessValue ;
  final List<String> awarenesslist = ['Greeting','Poster', 'Video'];
  String? requestValue ;
  final List<String> items = ['Poster', 'Leaflet', 'Booklet','Video'];
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('_____dddddddddddd_____${selectedValue}_________');
    return Scaffold(
      appBar: customAppBar(context: context, text:"Add Request", isTrue: true, ),

      body: SingleChildScrollView(
        child: Form(
          key:  _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(right: 5, top: 12),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration:
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all( color: colors.black54),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      dropdownMaxHeight: 300,
                      hint: const Padding(
                        padding: EdgeInsets.only(bottom: 12,top: 0),
                        child: Text("Select Your Request to Pharma Company ",
                          style: TextStyle(
                              color: colors.black54,fontWeight: FontWeight.normal,fontSize: 12
                          ),),
                      ),
                      // dropdownColor: colors.primary,
                      value: selectedValue,
                      icon:  const Padding(
                        padding: EdgeInsets.only(bottom: 30,left: 10),
                        child: Icon(Icons.keyboard_arrow_down_rounded,  color: colors.secondary,size: 30,),
                      ),
                      // elevation: 16,
                      style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                      underline: Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Container(
                          // height: 2,
                          color:  colors.whiteTemp,
                        ),
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          selectedValue = value!;

                        });
                      },

                      items: ['Awareness inputs','Worlds Awareness Day inputs','CME Invitation Designs','Event Invitation Designs','Online Webinar Invitation Designs']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,

                          child:
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(value,style: const TextStyle(color: colors.blackTemp,fontWeight: FontWeight.normal),),
                              ),
                              const Divider(
                                thickness: 0.2,
                                color: colors.black54,
                              )
                            ],
                          ),
                        );

                      }).toList(),

                    ),

                  )

              ),

              SizedBox(height: 10),
           getViewBasedOnSelectedValue(),
            ],
            ),
          ),
        ),
      ),
    );
  }
  Widget getViewBasedOnSelectedValue() {
    switch (selectedValue) {
      case 'Awareness inputs':
        return awareness();
      case 'Worlds Awareness Day inputs':
        return awareness();
      case 'CME Invitation Designs':
        return awareness();
      case 'Event Invitation Designs':
        return awareness();
      case 'Online Webinar Invitation Designs':
        return awareness();
      default:
        return awareness();
    }
  }
  String? _email;
  bool isValidEmail(String value) {
    // Simple email validation using a regular expression
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }
  // String? requestValue ;
  // final List<String> items = ['*Poster', '*Leaflet', '*Booklet','*Video'];
  awareness(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs"  ?
           Column(
             children: [
               Row(children: [
                 Text("Dr.Name" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
               ],),
               SizedBox(height: 3,),
               SizedBox(
                 // height: 45,
                 child: TextFormField(
                   validator: (value) {
                     if (value!.isEmpty) {
                       return 'Please Enter a Dr. Name';
                     }
                     return null;
                   },
                   decoration: InputDecoration(
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                       )
                   ),

                 ),
               ),
             ],
           ):
          Column(
         children: [
           Row(children: [
             Text("Doctor Association Name" ,textAlign: TextAlign.start),  Text("" ,style: TextStyle(color: colors.red),)
           ],),
           SizedBox(height: 3,),
           SizedBox(
             // height: 45,
             child: TextFormField(
               validator: (value) {
                 if (value!.isEmpty) {
                   return 'Please Enter a Doctor Association Name';
                 }
                 return null;
               },
               decoration: InputDecoration(
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                   )
               ),

             ),
           ),
         ],
       ),
        //selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs"  ? SizedBox(height: 10,):SizedBox.shrink(),
        selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs" ? SizedBox(height: 10,):SizedBox.shrink(),
        selectedValue == "CME Invitation Designs" ||
        selectedValue == "Event Invitation Designs" || selectedValue == "Online Webinar Invitation Designs" ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Topic" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a Topic';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ) :SizedBox.shrink(),
        // selectedValue == "CME Invitation Designs" ||
        //     selectedValue == "Event Invitation Designs" ?
        SizedBox(height: 10,),
            // :SizedBox.shrink(),
        selectedValue == "Event Invitation Designs"  ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Event Name" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a Event Name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ) :SizedBox.shrink(),
        selectedValue == "Online Webinar Invitation Designs" ? Column(children: [
          Row(children: [
            Text("Place" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)

          ],),
          SizedBox(height: 3,),
          SizedBox(
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter a Place';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),

            ),
          ),
        ],):SizedBox.shrink(),
        selectedValue == "Online Webinar Invitation Designs" ? SizedBox(height: 10,):SizedBox.shrink(),
        // selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs" ?  SizedBox(height: 10,):SizedBox.shrink(),
    selectedValue == "CME Invitation Designs"  || selectedValue == "Online Webinar Invitation Designs"   ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Speaker Dr. Name" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a Speaker Dr. Name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ) :SizedBox.shrink(),
        selectedValue == "CME Invitation Designs"  || selectedValue == "Online Webinar Invitation Designs"   ?  SizedBox(height: 10,):SizedBox.shrink(),
        Row(children: [
          Text("Degree" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
        ],),
        SizedBox(height: 3,),
        SizedBox(
          // height: 45,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter a Degree';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),

          ),
        ),
        selectedValue == "CME Invitation Designs"  || selectedValue == "Online Webinar Invitation Designs"  ?SizedBox(height: 10,):SizedBox.shrink(),
        selectedValue == "CME Invitation Designs"  || selectedValue == "Online Webinar Invitation Designs"  ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Moderator Name" ,textAlign: TextAlign.start),  Text("" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please Enter a Moderator Name';
                //   }
                //   return null;
                // },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ) :SizedBox.shrink(),
        SizedBox(height: 10,),
        selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs" ?  SizedBox.shrink():Column(
          children: [
          Row(
            children: [
            Text("Date" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
          ],
          ),
          SizedBox(height: 3,),
          TextFormField(
            readOnly: true,
            onTap: (){
              _selectDateStart();
            },
            controller:dateController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                counterText: "",
                hintText: 'Select Date',
                contentPadding: EdgeInsets.only(left: 10)
            ),
            validator: (v) {
              if (v!.isEmpty) {
                return "Start Date is required";
              }

            },
          ),
          SizedBox(height: 10,),
          Row(children: [
            Text("Time" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
          ],),
          SizedBox(height: 3,),
          TextFormField(
            readOnly: true,
            onTap: (){
              _selectTime(context);
            },
            controller:timeController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                counterText: "",
                hintText: 'Select Time',
                contentPadding: EdgeInsets.only(left: 10)
            ),
            validator: (v) {
              if (v!.isEmpty) {
                return "Time Date is required";
              }

            },
          ),
        ],),
        SizedBox(height: 10,),
      selectedValue == "Online Webinar Invitation Designs" ? SizedBox.shrink():Column(children: [
        Row(children: [
          Text("Place" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)

        ],),
        SizedBox(height: 3,),
        SizedBox(
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter a Place';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),

          ),
        ),
        ],),

        SizedBox(height: 10,),
      selectedValue  == "Event Invitation Designs"  ?Column(
          children: [
            Row(children: [
              Text("Conference Secretariat Dr Name" ,textAlign: TextAlign.start),  Text("" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            SizedBox(
              // height: 45,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a Conference Secretariat';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),

              ),
            ),
          ],
        ):SizedBox.shrink(),
        selectedValue  == "Event Invitation Designs"  ?  SizedBox(height: 10,):SizedBox.shrink(),
      selectedValue == "Awareness inputs" ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Request for" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
            ],),
            SizedBox(height: 3,),
            Container(
                padding: EdgeInsets.only(right: 5, top: 12),
                width: MediaQuery.of(context).size.width,
                height: 55,
                decoration:
                BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all( color: colors.black54),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    dropdownMaxHeight: 220,
                    hint: const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text("Select Request",
                        style: TextStyle(
                            color: colors.black54,fontWeight: FontWeight.normal
                        ),),
                    ),
                    // dropdownColor: colors.primary,
                    value: requestValue,
                    icon:  const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Icon(Icons.keyboard_arrow_down_rounded,  color: colors.secondary,size: 30,),
                    ),
                    // elevation: 16,
                    style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                    underline: Padding(
                      padding: const EdgeInsets.only(left: 0,right: 0),
                      child: Container(
                        // height: 2,
                        color:  colors.whiteTemp,
                      ),
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        requestValue = value!;

                      });
                    },

                    items: items
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(value,style: const TextStyle(color: colors.black54,fontWeight: FontWeight.normal),),
                            ),
                            const Divider(
                              thickness: 0.2,
                              color: colors.black54,
                            )
                          ],
                        ),
                      );

                    }).toList(),

                  ),

                )

            ),
          ],
        ):Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text("Request for" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
          ],),
          SizedBox(height: 3,),
          Container(
              padding: EdgeInsets.only(right: 5, top: 12),
              width: MediaQuery.of(context).size.width,
              height: 55,
              decoration:
              BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all( color: colors.black54),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  dropdownMaxHeight: 220,
                  hint: const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text("Select Request",
                      style: TextStyle(
                          color: colors.black54,fontWeight: FontWeight.normal
                      ),),
                  ),
                  // dropdownColor: colors.primary,
                  value: awarenessValue,
                  icon:  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Icon(Icons.keyboard_arrow_down_rounded,  color: colors.secondary,size: 30,),
                  ),
                  // elevation: 16,
                  style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                  underline: Padding(
                    padding: const EdgeInsets.only(left: 0,right: 0),
                    child: Container(
                      // height: 2,
                      color:  colors.whiteTemp,
                    ),
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      awarenessValue = value!;

                    });
                  },

                  items: awarenesslist
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child:
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(value,style: const TextStyle(color: colors.black54,fontWeight: FontWeight.normal),),
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: colors.black54,
                          )
                        ],
                      ),
                    );

                  }).toList(),

                ),

              )

          ),
        ],
      ),

        SizedBox(height: 10,),
        selectedValue == "Awareness inputs"  || selectedValue == "Worlds Awareness Day inputs"  ? selectedValue == "CME Invitation Designs" ? SizedBox.shrink(): selectedValue == "Awareness inputs"  ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text("Topic" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
                ],),
                SizedBox(height: 3,),
                SizedBox(
                  // height: 45,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter a Topic';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),

                  ),
                ),
              ],
            )
          : Column(
           crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(children: [
                 Text("Awareness Day" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
               ],),

           SizedBox(height: 3,),
           SizedBox(
          // height: 45,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter a Topic';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),

          ),
        ),
             ],
           ):SizedBox.shrink(),
        SizedBox(height: 10,),
        Row(children: [
          Text("For Clinic or Hospital Name" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
        ],),
        SizedBox(height: 3,),
        SizedBox(
          // height: 45,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter a Clinic or Hospital';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),

          ),
        ),
        SizedBox(height: 10,),
        Row(children: [
          Text("Dr. Contact Email ID" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
        ],),
        SizedBox(height: 3,),
        SizedBox(
          // height: 45,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter an Email ID';
              }
              if (!isValidEmail(value)) {
                return 'Please Enter a Valid Email ID';
              }
              return null; // Return null if the input is valid
            },
            onSaved: (value) {
              _email = value;
            },

          ),
        ),
        SizedBox(height: 10,),
        Row(children: [
          Text("Message for pharma company" ,textAlign: TextAlign.start),  Text("*" ,style: TextStyle(color: colors.red),)
        ],),
        SizedBox(height: 3,),
        SizedBox(
          // height: 45,
          child: TextFormField(
            maxLines: 5,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter a pharma company';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),

          ),
        ),
        SizedBox(height: 10,),
        InkWell(
          onTap: (){
            if(_formKey.currentState!.validate()){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
            }
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(color: colors.secondary,borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Submit Request",style: TextStyle(color: colors.whiteTemp,fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
          ),
        ),


      ],
    );
  }
  String _dateValue = '';
  var dateFormate;
  TimeOfDay? _selectedTime;
  String convertDateTimeDisplay(String date)  {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  Future _selectDateStart() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate = DateFormat("yyyy/MM/dd").format(DateTime.parse(_dateValue ?? ""));
        dateController = TextEditingController(text: _dateValue);


      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime) {

      setState(() {
        timeController.text =  _selectedTime!.format(context);
      });
      print('_____sfgfdgfdg_____${_selectedTime!.format(context)}_________');
    }

  }
}
