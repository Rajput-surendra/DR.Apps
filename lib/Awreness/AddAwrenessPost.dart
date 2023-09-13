import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctorapp/Helper/Color.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Helper/AppBtn.dart';
import '../Helper/Appbar.dart';
import '../api/api_services.dart';
import 'package:http_parser/http_parser.dart';

List _selectedItems2 = [];

class AddAwanessPost extends StatefulWidget {
  const AddAwanessPost({Key? key}) : super(key: key);

  @override
  State<AddAwanessPost> createState() => _AddAwanessPostState();
}

class _AddAwanessPostState extends State<AddAwanessPost> {
  TextEditingController doctoreController = TextEditingController();

  bool isButtonLoading = false;

  String? dropdownvalue;

  var items1 = [
    'Hindi',
    'English',
    'Assam',
    'Bengali',
    'Oriya',
    'Urdu',
    'Gujrati',
    'Punjabi',
    'Tamil',
    'Telgu',
    'Marathi',
    'Kanada'
  ];

  var dropdownInput;

  // var items1 =  [ 'Patient awareness poster','Patient awareness leaflets','Patient awareness booklets','Patient awareness video', 'Patient awareness m-poster'];
  List<Map<String, dynamic>> list = [
    {'id': 'poster', 'name': 'Patient awareness poster(jpg)'},
    {'id': 'leaflets', 'name': 'Patient awareness leaflets(pdf)'},
    {'id': 'booklets', 'name': 'Patient awareness booklets(pdf)'},
    {'id': 'm-poster', 'name': 'Patient motivational poster(jpg)'},
    {'id': 'video', 'name': 'Patient awareness video(mp4)'},
  ];

  //String? categoryValue;
  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  File? newImageFile;
  bool isloader = false;

  // List<File> files = [];
  String? pickedFiles;
  List<String> thumbnailList = [];
  String? language;

  File? thumbNailImage;



  File? thumbnailFile;
  File? pickedFile;

  _getFromGallery(bool type) async {
    FilePickerResult? result;
    List<File> files = [];

    if (dropdownInput == 'video' && !type) {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp4'],
      );
    } else if(dropdownInput == 'leaflets'  || dropdownInput == 'booklets' ) {
      result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    }else{
      result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['jpg']);
    }
    if (result != null) {
      if (type) {
        File videoFile = File(result.files.single.path!);
        thumbnailFile = File(result.files.single.path!);
        thumbnailList.add(result.files.single.path!);
      }
      setState(() {
        pickedFile = File(result?.files.single.path ?? '');
        files = result!.paths.map((path) => File(path!)).toList();
        imgList.add(files.first.path);
        if(thumbnailFile == null) {
          pickedFiles = files.first.path;
        }
      });
    } else {
      // User canceled the picker
    }
  }

  addDoctorWebinarApi() async {
    isButtonLoading = true;
    setState(() {});
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? Roll = preferences.getString('roll');

    var headers = {
      'Cookie': 'ci_session=f5c119f5040eaef28e6a4c420b14b794a449a6c4'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiService.addDoctorAwreness));
    request.fields.addAll({
      'user_id': '$userId',
      'roll': '$Roll',
      'title': doctoreController.text,
      'aware_input': dropdownInput ?? '',
      'language': langList.join(','),
    });
  print('_______request.fields___${request.fields}_________');
    // if(videoList.isNotEmpty) {
    //   print('__________${videoList.first}_________');
    //   videoList.forEach((element) async {
    //     request.files.add(
    //         await http.MultipartFile.fromPath('image[]', element.path ?? ''));
    //   });
    //   print('_____fgdgfdgdggdfg_____${videoList.first.path.toString()}_________');
    //
    // }
    if (imgList.isNotEmpty) {
      for (var i = 0; i < imgList.length; i++) {
        imgList.length == 0 || imgList == null
            ? null
            : request.files
                .add(await http.MultipartFile.fromPath('image[]', imgList[i]));
      }
    }

    if (thumbNailImage != null) {
      request.files.add(
          await http.MultipartFile.fromPath('thumbnail[]', thumbNailImage!.path));
    }
    if (imgList.isEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('image[]', pickedFiles ?? ''));
    }
    print('filessssssss${request.files}');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final result = await response.stream.bytesToString();
    log(result);

    if (response.statusCode == 200) {
      final finalResult = json.decode(result);
      print("thi os ojon==========>${finalResult}");
      isButtonLoading = false;
      setState(() {});
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Your input will be displayed in a few times after verification',backgroundColor: colors.secondary);
      // Fluttertoast.showToast(msg: finalResult['message'],backgroundColor: colors.secondary);
      doctoreController.clear();
      pickedFiles = null;
      setState(() {
        isloader = false;
      });
    } else {
      setState(() {
        isButtonLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  bool isChecked = false;
  List<String> eventCat = [];
  List? results;
  List<dynamic> dataList = [];
  List<String> langList = [];
  List<String> imgList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedItems2.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          text: "Awareness Input",
          isTrue: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: doctoreController,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 5, left: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Awareness Input Title',
                          hintStyle: TextStyle(color: colors.black54)),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return " Doctor Awareness  is required ";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.only(right: 5, top: 5),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.black54),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          hint: const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "Awareness Input Upload",
                              style: TextStyle(
                                  color: colors.black54,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          // dropdownColor: colors.primary,
                          value: dropdownInput,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: colors.secondary,
                            size: 30,
                          ),
                          // elevation: 16,
                          style: const TextStyle(
                              color: colors.secondary,
                              fontWeight: FontWeight.bold),
                          underline: Container(
                            // height: 2,
                            color: colors.whiteTemp,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownInput = value!;
                              imgList.clear();
                              thumbnailFile = null ;
                              dataList.clear() ;
                              pickedFiles = null ;

                            });
                          },
                          items: list.map((items) {
                            return DropdownMenuItem(
                              value: items['id'].toString(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                        width: 250,
                                        child: Text(
                                          items['name'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: colors.black54,
                                              fontWeight: FontWeight.normal),
                                        )),
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
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(right: 5, top: 5),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: colors.black54),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  hint: const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "Awareness Language Upload",
                                      style: TextStyle(
                                          color: colors.black54,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  // dropdownColor: colors.primary,
                                  value: dropdownvalue,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: colors.secondary,
                                      size: 30,
                                    ),
                                  ),
                                  // elevation: 16,
                                  style: const TextStyle(
                                      color: colors.secondary,
                                      fontWeight: FontWeight.bold),
                                  underline: Container(
                                    // height: 2,
                                    color: colors.whiteTemp,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      dropdownvalue = value!;
                                    });
                                  },
                                  items: items1.map((items) {
                                    return DropdownMenuItem(
                                      value: items.toString(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: SizedBox(
                                                width: 250,
                                                child: Text(
                                                  items.toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: colors.black54,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                )),
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
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _getFromGallery(false);
                                },
                                child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(5),
                                    dashPattern: [5, 5],
                                    color: Colors.grey,
                                    strokeWidth: 2,
                                    child: pickedFiles != null
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(
                                                    "${pickedFiles}")),
                                          )
                                        : Center(
                                            child: Column(
                                            children: const [
                                              Icon(
                                                Icons
                                                    .drive_folder_upload_outlined,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                              Text(
                                                'Awareness Input file format',
                                                style: TextStyle(
                                                    color: colors.red,
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ))),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Text(
                                'file:less then 20 MB file size acceptable',
                                style:
                                    TextStyle(color: colors.red, fontSize: 12),
                              ),
                            ],
                          ),
                          /*Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  _getFromGallery(false);
                                },

                                child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(5),
                                    dashPattern: [5, 5],
                                    color: Colors.grey,
                                    strokeWidth: 2,
                                    child:  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Text("${videoList[index]}")),
                                    )
                                ),
                              ),
                              const SizedBox(height: 2,),
                              const Text('fili:less then 20 MB file size acceptable', style: TextStyle(color: colors.red,fontSize: 12),),
                            ],
                          ),*/
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),

                  dropdownInput == "video"
                      ? InkWell(
                          onTap: () {
                            _getFromGallery(true);
                          },
                          child: SizedBox(
                            height: 50,
                            child: thumbnailFile != null ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                      "${thumbnailFile?.path}")),
                            ) : DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(5),
                                dashPattern: [5, 5],
                                color: Colors.grey,
                                strokeWidth: 2,
                                child: /*files != null  ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("${files}")),
                          ) :*/
                                    Center(
                                        child: Column(
                                  children: const [
                                    Icon(
                                      Icons.drive_folder_upload_outlined,
                                      color: Colors.grey,
                                      size: 25,
                                    ),
                                    Text(
                                      'video pdf jpg thumbnail',
                                      style: TextStyle(
                                          color: colors.red, fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ))),
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (dropdownvalue != null &&
                            pickedFiles != null &&
                            dropdownInput != null) {
                          dataList.add({
                            "language": dropdownvalue.toString(),
                            "img": pickedFiles,
                            "thumbnail": thumbnailFile?.path ?? '',
                          });
                          langList.add(dropdownvalue.toString());
                          imgList.add(pickedFiles!);
                          pickedFiles = null;
                          dropdownvalue = null;
                          thumbnailFile = null ;
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Select file and language',backgroundColor: colors.secondary);
                        }
                      });
                      // }
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.primary,
                          ),
                          child:  Center(
                              child:dataList.length ==  0 ? Text(
                                "Add",
                                style: TextStyle(color: Colors.white),
                              ) : Text(
                                "Add more",
                                style: TextStyle(color: Colors.white),
                              ) )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  dataList.length == 0
                      ? SizedBox()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: dataList.length,
                          itemBuilder: (c, i) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: colors.black54)),
                              child: ListTile(
                                title: Text("${dataList[i]['language']}",style: TextStyle(fontWeight: FontWeight.bold,color: colors.blackTemp),),
                                subtitle: Column(
                                  children: [

                                    Text("${dataList[i]['img']}",style: TextStyle(color: colors.blackTemp,),),
                                    dataList[i]['thumbnail'] != ''
                                        ? Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                          Text("Thumbnail",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 5,),
                                          Text("${dataList[i]['thumbnail']}")
                                      ],
                                    ),
                                        )
                                        : const SizedBox(),
                                  ],
                                ),
                                trailing: InkWell(
                                    onTap: () {
                                      setState(() {
                                        dataList.remove(dataList[i]);
                                        langList.remove(i);
                                        imgList.remove(i);
                                      });
                                      print(
                                          "here are values ${dataList} and ${langList}  and ${imgList}");
                                    },
                                    child: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    )),
                              ),
                            );
                          }),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Add patients awareness inputs language wise, It will display on the Doctor's side speciality wise for download and to use for clinic and social media of Doctors. This will promote your brand also.",textAlign: TextAlign.justify,style: TextStyle(color: colors.blackTemp,fontSize: 16),),
                  const SizedBox(
                    height: 30,
                  ),
                  dataList.length == 0 ?SizedBox.shrink():
                  Btn(
                    height: 50,
                    width: 320,
                    title: isButtonLoading == true
                        ? "Please wait......"
                        : 'Add Post Awareness',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        addDoctorWebinarApi();
                      } else {
                        setState(() {
                          isloader = false;
                        });
                        Fluttertoast.showToast(msg: "All Field required",backgroundColor: colors.secondary);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _showMultiSelect() async {
  //    results = await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(
  //             builder: (context, setState)
  //             {
  //               return
  //                 MultiSelect();
  //             }
  //         );
  //       }
  //   );
  //
  // }
  getDialogBox() {
    return showDialog(
      context: context,
      builder: (context) {
        // String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Column(
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        elevation: 0,
                        underline: Container(),
                        value: dropdownvalue,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 40,
                        ),
                        hint: Text(
                          "Awareness Language Upload",
                          style: TextStyle(color: colors.black54),
                        ),
                        items: items1.map((String items) {
                          return DropdownMenuItem(
                              value: items, child: Text(items));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      await _getFromGallery(false);
                    },
                    child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(5),
                        dashPattern: [5, 5],
                        color: Colors.grey,
                        strokeWidth: 2,
                        child: pickedFiles != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("${pickedFiles}")),
                              )
                            : Center(
                                child: Column(
                                children: [
                                  Icon(
                                    Icons.drive_folder_upload_outlined,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                  Text(
                                    'Awareness Input file format(video,pdf,jpg)',
                                    style: TextStyle(
                                        color: colors.red, fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        dataList.add({
                          "language": dropdownvalue.toString(),
                          "image": imageFile!.path.toString(),
                        });

                        langList.add(dropdownvalue.toString());
                        imgList.add(imageFile!.path.toString());
                        print("pppppp ${langList} and ${imgList}");
                        Navigator.pop(context, true);
                        imageFile = null;
                        dropdownvalue = null;
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: colors.secondary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        "Submit",
                        style: TextStyle(color: colors.whiteTemp),
                      )),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// class MultiSelect extends StatefulWidget {
//   // String type;
//   // required this.type
//   MultiSelect({Key? key, }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _MultiSelectState();
//
// }
//
// class _MultiSelectState extends State<MultiSelect> {
//   List selectedItems = [];
//   List<String> eventCat = [];
//   bool isChecked = false;
//
//   void _itemChange(String itemValue, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         _selectedItems2.add(itemValue);
//       } else {
//         _selectedItems2.remove(itemValue);
//       }
//     });
//     print("this is selected values ${_selectedItems2.toString()}");
//   }
//
//   void _cancel() {
//     Navigator.pop(context);
//   }
//
//   void _submit() {
//     List selectedItem = _selectedItems2.map((item) => item).toList();
//     //Navigator.pop(context);
//   }
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//   }
//   String finalList = '';
//   var languageList =  [ 'Hindi',
//     'English',
//     'Assam',
//     'Bengali',
//     'Oriya',
//     'Urdu',
//     'Gujrati',
//     'Punjabi',
//     'Tamil',
//     'Telgu',
//     'Marathi',
//     'Kanada'
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(
//         builder: (context, setState)
//         {
//           return
//             AlertDialog(
//               title: const Text('Awareness Language Upload'),
//               content: SingleChildScrollView(
//                 child: ListBody(
//                   children: languageList
//                       .map((data) =>
//                   CheckboxListTile(
//                     activeColor: colors.primary,
//                     value: _selectedItems2.contains(data),
//                     title: Text(data),
//                     controlAffinity: ListTileControlAffinity.leading,
//                     onChanged: (isChecked) => _itemChange(data, isChecked!),
//
//                   )
//                   ).toList(),
//                 ),
//               ),
//
//               actions: [
//                 TextButton(
//                   child: Text('Cancel',
//                     style: TextStyle(color: colors.primary),),
//                   onPressed: _cancel,
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       primary: colors.primary
//                   ),
//                   child: Text('Submit'),
//                   onPressed: () {
//                     setState((){
//                     });
//                     _submit();
//                     Navigator.pop(context, _selectedItems2);
//                   }
//
//                   ,
//                 ),
//               ],
//             );
//         }
//     );
//   }
//
// }
