import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';

class GenericRxDosageScreen extends StatefulWidget {
 GenericRxDosageScreen({Key? key, this.catName}) : super(key: key);
 String? catName;

  @override
  State<GenericRxDosageScreen> createState() => _GenericRxDosageScreenState();
}

class _GenericRxDosageScreenState extends State<GenericRxDosageScreen> {
  int curentIndex = 0;
  File? imageFile;
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, text:"Generic & Brand", isTrue: true, ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(child: Text("${widget.catName}",style: TextStyle(
                      color: colors.black54
                  ),)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Logo Upload Area"),
                        Text("*",style: TextStyle(color: colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    InkWell(
                      onTap: () {
                        showExitPopup();
                      },
                      child: Container(
                        height: imageFile == null ? 50:150,
                        child: DottedBorder(
                          
                          borderType: BorderType.RRect,
                          radius: Radius.circular(0),
                          dashPattern: [5, 5],
                          color: Colors.grey,
                          strokeWidth: 2,
                          child: imageFile == null || imageFile == ""
                              ? const Center(
                              child: Icon(
                                Icons.drive_folder_upload_outlined,
                                color: Colors.grey,
                                size: 30,
                              ))
                              : Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.file(
                                  imageFile!,
                                  height: 145,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Indication"),
                        Text("*",style: TextStyle(color: colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Indication';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Dosage"),
                        Text("*",style: TextStyle(color: colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Dosage';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Rx info"),
                        Text("*",style: TextStyle(color: colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Rx info';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Ads upload area"),
                        Text("*",style: TextStyle(color: colors.red),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {

                              showExitPopup();
                            },
                            child: Container(
                              height: imageFile1 == null ? 50:100,
                              child: DottedBorder(

                                borderType: BorderType.RRect,
                                radius: Radius.circular(0),
                                dashPattern: [5, 5],
                                color: Colors.grey,
                                strokeWidth: 2,
                                child: imageFile1 == null || imageFile1 == ""
                                    ? const Center(
                                    child: Icon(
                                      Icons.drive_folder_upload_outlined,
                                      color: Colors.grey,
                                      size: 30,
                                    ))
                                    : Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                        imageFile1!,
                                        height: 95,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showExitPopup();
                            },
                            child: Container(
                              height: imageFile2 == null ? 50:100,
                              child: DottedBorder(

                                borderType: BorderType.RRect,
                                radius: Radius.circular(0),
                                dashPattern: [5, 5],
                                color: Colors.grey,
                                strokeWidth: 2,
                                child: imageFile2 == null || imageFile2 == ""
                                    ? const Center(
                                    child: Icon(
                                      Icons.drive_folder_upload_outlined,
                                      color: Colors.grey,
                                      size: 30,
                                    ))
                                    : Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                        imageFile2!,
                                        height: 95,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showExitPopup();
                            },
                            child: Container(
                              height: imageFile3 == null ? 50:100,
                              child: DottedBorder(

                                borderType: BorderType.RRect,
                                radius: Radius.circular(0),
                                dashPattern: [5, 5],
                                color: Colors.grey,
                                strokeWidth: 2,
                                child: imageFile3 == null || imageFile3 == ""
                                    ? const Center(
                                    child: Icon(
                                      Icons.drive_folder_upload_outlined,
                                      color: Colors.grey,
                                      size: 30,
                                    ))
                                    : Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                        imageFile3!,
                                        height: 95,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
  Future<bool> showExitPopup() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, context, 1);
                },
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageCmera(ImageSource.gallery,context,1);

                },

                //return true when click on "Yes"
                child: Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }
  Future getImage(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(
      source: source,
    );
    getCropImage(context, i, image);
    Navigator.pop(context);
  }
  Future getImageCmera(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(
      source: source,
    );
    getCropImage(context, i, image);
    Navigator.pop(context);
  }
  void getCropImage(BuildContext context, int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    setState(() {
      print('___ffffffffffffff_______${i}_________');
      if (i == 1) {

        if(i == 0) {
          imageFile = File(croppedFile!.path);
        }else if(i == 1){
        imageFile1 = File(croppedFile!.path);
        }else if(i == 2){
          imageFile2 = File(croppedFile!.path);
        }else if(i == 3){
          imageFile3 = File(croppedFile!.path);
        }

      }
    });
  }



}
