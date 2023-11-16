import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Helper/Color.dart';
import '../New_model/GetSelectCatModel.dart';

List <String>_selectedUserItems = [];
class MultiSelect1 extends StatefulWidget {
  final List<SpeciplyData> ?speciplyList ;
  MultiSelect1({Key? key, this.speciplyList }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MultiSelect1State();
}
class _MultiSelect1State extends State<MultiSelect1> {

  void _itemChange(SpeciplyData itemValue, bool isSelected) {
    setState(() {
      if (isSelected && _selectedUserItems.length <5) {
        setState(() {
          _selectedUserItems.add(itemValue.name ?? '');
        });
      }else if (isSelected ==  true){
        Fluttertoast.showToast(msg: "Select brand speciality to promote your brand. Select minimum 1 and maximum 5 brand specialties.",backgroundColor: colors.secondary,);
      } else {
        setState(() {
          _selectedUserItems.remove(itemValue.name ?? '');
        });
      }
    });
  }
  void _cancel() {
    //Navigator.pop(context);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  String finalList = '';

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState)
        {
          return
            AlertDialog(
              title: const Text('Select Brand Speciality'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: widget.speciplyList!.map((SpeciplyData data) =>
                      CheckboxListTile(
                        activeColor: colors.primary,
                        value: _selectedUserItems.contains(data.name),
                        title: Text(data.name ?? ''),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (isChecked) {
                            _itemChange(data, isChecked!);
                        }

                      )
                  ).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: (){
                      Navigator.pop(context);
                   },
                  child: const Text('Cancel',
                    style: TextStyle(color: colors.primary),),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: colors.primary
                    ),
                    child: const Text('Submit'),
                    onPressed: () {

                     // _submit();

                      Navigator.pop(context, _selectedUserItems);

                    }
                ),
              ],
            );
        }
    );
  }

}