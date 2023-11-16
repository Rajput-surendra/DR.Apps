
 import 'dart:convert';
import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/New_model/pharma_products_response.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Appbar.dart';
import 'package:http/http.dart'as http;

import 'Ipca_products2.dart';


 class  PharmaProductsDataScreen extends StatefulWidget {
 const  PharmaProductsDataScreen({Key? key, this.pharmaCategory,this.ProdectName,this.SliderId,this.companyName}) : super(key: key);
final  String? pharmaCategory ,ProdectName ,SliderId, companyName;

  @override
  State<PharmaProductsDataScreen> createState() => _PharmaProductsDataScreenState();
}

 class _PharmaProductsDataScreenState extends State<PharmaProductsDataScreen> {

  GetPharmaProducts? pharmaProducts ;

  List <PharmaProducts> pharmaProductsList = [] ;
  bool isLoading =  false ;

  @override
  void initState() {
    // TODO: implement initState
    getPharmaProducts();
    super.initState();


  }


  getPharmaProducts() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    var headers = {
      'Cookie': 'ci_session=2b4970bf3e00bebbcd43347053dbdd8e75912c54'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiService.getPharmaProducts}'));
    request.fields.addAll({
      'category_id': widget.pharmaCategory.toString(),
      'user_id': userId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      final finalResult = GetPharmaProducts.fromJson(json.decode(result));
      setState(() {
        pharmaProductsList = finalResult.data ?? [];
        isLoading = false;
      });
    } else {
      isLoading = false;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context)  {

    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context: context, text:"${widget.companyName}", isTrue: true, ),
        body: SingleChildScrollView(
          child: Column(


            children:<Widget>[
              const SizedBox(height: 10,),

              const SizedBox(height: 10,),
              pharmaProductsList == null ?  Center(child: CircularProgressIndicator(),) : pharmaProductsList.length == "0" ? Center(child: Text('No Data Found !!'),) :
              ListView.builder(
                shrinkWrap: true,
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pharmaProductsList.length ?? 2,
                itemBuilder: (context, index) {
                 var item =  pharmaProductsList[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>IpcaProductScreen2(PharmaProduct:pharmaProductsList[index].id,companyName: widget.companyName,isTrue1: false,)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(maxRadius:27,child: Text('${item.name?.substring(0,1)}',style:
                          const TextStyle(fontSize: 20,color:colors.lightWhite2),),),
                        ),
                        const SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text('${item.name}',style: const TextStyle(fontWeight: FontWeight.w700),),
                          ),
                          Container(
                              width: 250,
                              child: Text('${item.shortDescription}',maxLines: 4,overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.w700,color: Colors.grey),))

                        ],)                  ],
                    ),
                  ),
                ) ;
              },)

            ],
          ),
        ),

      ),
    );
  }


}
