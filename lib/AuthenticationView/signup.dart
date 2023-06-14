
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/AppBtn.dart';
import '../Helper/Color.dart';
import '../Product/my_speciality.dart';
import '../Registration/doctorResignation.dart';
import 'LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String docterList = 'Doctor';
  var items =  [ 'Doctor','Pharma(PMT Team & Marketing)',];
  int indexSectet = 1;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.primary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.75),
                child: Container(
                    height: MediaQuery.of(context).size.height/2.5,
                    child: Image.asset("assets/splash/splashimages.png",scale: 5.2,)),
              ),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: colors.whiteTemp,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(1),topLeft: Radius.circular(1))
                ),

                height: MediaQuery.of(context).size.height/1.59,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("Signup",style: TextStyle(color: colors.blackTemp,fontSize: 35 ,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15,left: 15,top: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // InkWell(
                              //   onTap: (){
                              //
                              //   },
                              //   child: Card(
                              //     elevation: 5,
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(10.0),
                              //     ),
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(2.0),
                              //       child: DropdownButtonHideUnderline(
                              //         child: DropdownButton(
                              //           hint: Text("Choose gender"),
                              //           isExpanded: true,
                              //           elevation: 0,
                              //           value: docterList,
                              //           icon: Icon(Icons.keyboard_arrow_down,size: 40,color: colors.secondary,),
                              //           items:items.map((String items) {
                              //             return DropdownMenuItem(
                              //                 value: items,
                              //                 child: Padding(
                              //                   padding: const EdgeInsets.all(8.0),
                              //                   child: Text(items,style: TextStyle(color: colors.secondary),),
                              //                 )
                              //             );
                              //           }
                              //           ).toList(),
                              //           onChanged: (String? newValue){
                              //             setState(() {
                              //               docterList = newValue!;
                              //                indexSectet = items.indexOf(newValue);
                              //               indexSectet++;
                              //               print("tttttt--dfdfdsfsf------->${indexSectet}");
                              //             });
                              //           },
                              //
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(left: 5.0, right: 5),
                                child: Container(
                                    padding: EdgeInsets.only(right: 5, top: 14),
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    decoration:
                                    BoxDecoration(
                                      color: colors.blackTemp.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all( color: colors.primary),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        hint: const Text("Select Type",
                                          style: TextStyle(
                                              color: colors.secondary
                                          ),),
                                       // dropdownColor: colors.primary,
                                        value: docterList,
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
                                            docterList = value!;
                                            indexSectet = items.indexOf(value);
                                            indexSectet++;
                                          });
                                        },

                                        items: items
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Text(value,style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.normal),),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: Divider(
                                                    thickness: 0.2,
                                                    color: colors.black54,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );

                                        }).toList(),

                                      ),

                                    )

                                ),
                              ),
                              SizedBox(height: 60,),
                              Btn(
                                color: colors.secondary,
                                  height: 50,
                                  width: 320,
                                  title: 'Submit',
                                  onPress: () {
                                    if (_formKey.currentState!.validate()) {
                                      if(indexSectet == 1 ){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>MySpeciality()));
                                      }else{
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>DoctorResignation(
                                              role: indexSectet,
                                            )));
                                      }
                                      print("thisin is iss indexxxxxxxx=>${indexSectet}");
                                    } else {
                                      const snackBar = SnackBar(
                                        content: Text('All Fields are required!'),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                    }

                                  }
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account?",style: TextStyle(color: colors.blackTemp,fontSize: 14,fontWeight: FontWeight.bold),),
                                  TextButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                  }, child: const Text("Log In",style: TextStyle(color: colors.secondary,fontSize: 16,fontWeight: FontWeight.bold),))
                                ],
                              )
                           
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )

              // Container(
              //   color: colors.primary,
              //   child:
              // )
            ],
          ),
        ),
      ),
    );
  }
}
