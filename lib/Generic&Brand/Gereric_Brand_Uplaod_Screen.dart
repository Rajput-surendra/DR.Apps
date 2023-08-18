import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';

class GerericBrandUplaodScreen extends StatefulWidget {
   GerericBrandUplaodScreen({Key? key,this.catName}) : super(key: key);
   String ? catName;

  @override
  State<GerericBrandUplaodScreen> createState() => _GerericBrandUplaodScreenState();
}

class _GerericBrandUplaodScreenState extends State<GerericBrandUplaodScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            if(_formKey.currentState!.validate()){
              Fluttertoast.showToast(msg: "All field are required");
            }
           // Navigator.push(context, MaterialPageRoute(builder: (context)=>GerericBrandUplaodScreen(catName:widget.catName,)));
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(15)
            ),

            child: Center(child: Text("Upload",style: TextStyle(color: colors.whiteTemp),)),
          ),
        ),
      ),
      appBar: customAppBar(context: context, text:"Generic & Brand", isTrue: true, ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key:_formKey ,
          child: Column(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: SizedBox(
                  height: 50,
                  child: Center(child: Text("${widget.catName}",style: TextStyle(
                      color: colors.black54
                  ),)),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Brand Name"),
                        Text("*",style: TextStyle(color: colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Brand Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Generic Name"),
                        Text("*",style: TextStyle(color: colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Generic Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),

                    Row(
                      children: [
                        Text("Company Name"),
                        Text("*",style: TextStyle(color: colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Company Name';
                        }
                        return null;
                      },
                    ),


                  ],
                ),
              ),

            ],
          ),
        ),
      ) ,
    );
  }
}
