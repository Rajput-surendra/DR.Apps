import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';

class SponsoredListPost extends StatefulWidget {
  const SponsoredListPost({Key? key}) : super(key: key);

  @override
  State<SponsoredListPost> createState() => _SponsoredListPostState();
}

class _SponsoredListPostState extends State<SponsoredListPost> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController decController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool isloader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Sponsored", isTrue: true, ),
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 45,
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5,left: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Name '
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Name";
                    }

                  },
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 45,
                child: TextFormField(
                  controller: decController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5,left: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Designation'
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Designation";
                    }

                  },
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 45,
                child: TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5,left: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Mobile'
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Mobile";
                    }

                  },
                ),
              ),
              SizedBox(height: 10,),

              SizedBox(height: 20,),
              Btn(
                height: 50,
                width: 320,
                title: isloader == true ? "Please wait......" : 'Add ',
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    //getPostNew();
                  } else {
                    setState(() {
                      isloader = false;
                    });
                    Fluttertoast.showToast(
                        msg:
                        "All Field Are required!!");
                  }
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
