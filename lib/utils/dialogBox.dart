import 'package:flutter/material.dart';
import 'package:scrapgreen/models/addItem.dart';
import 'package:scrapgreen/bloc/request_details/request_details_bloc.dart';
import 'package:scrapgreen/bloc/request_details/request_details_event.dart';
import 'package:scrapgreen/bloc/request_details/request_details_state.dart';
import 'package:scrapgreen/models/material.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/singleton.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_bloc/flutter_bloc.dart';

final List<String> _material = [
    "Iron",
    "Copper",
  ];
final List<MaterialItem> materialList = [
  MaterialItem('1', 'IRON'),
  MaterialItem('2', 'COPPER'),
];
final List<String> _unit = [
    "KG"
  ];

final List<AddItem> itemList = [];
  int _total;
  String quantity;
  TextEditingController quantityCtrl = TextEditingController();
  class DialogBox extends StatefulWidget {
  @override
  DialogBoxState createState() => DialogBoxState();
}
class DialogBoxState extends State<DialogBox>  {
  String _selectedUnit;
String _selectedMaterial;
String _amount;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
//    itemList.clear();
    quantityCtrl.clear();
    _total = 0;
  }



  @override
  Widget build(BuildContext context) {
    return Dialog(
            child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green,
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(12),
                //   topRight: Radius.circular(12),
                // ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Add Item",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: DropdownButtonFormField (
                value: _selectedMaterial,
                isExpanded: true,
                //decoration: InputDecoration(contentPadding: const EdgeInsets.fromLTRB(10.0, 0.5, 0.0, 0.5),(borderRadius: BorderRadius.circular(5.0),)),
                validator: (arg){
                    if(arg == null){
                      return 'Please select Material.';
                    }
                },
                hint: Text("Select Material", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black), maxLines: 1),
                items: materialList.map((item) {
                  return DropdownMenuItem(
                    value: item.id,
                    child: new Text(item.material,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
//                  print(value);
                  setState(() {
                    _selectedMaterial  = value;
                    print(_selectedMaterial);
                  });
                  
                //getAddressDropdownValue(value);
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: DropdownButtonFormField (
                value: _selectedUnit,
                isExpanded: true,
                //decoration: InputDecoration(contentPadding: const EdgeInsets.fromLTRB(10.0, 0.5, 0.0, 0.5),(borderRadius: BorderRadius.circular(5.0),)),
                validator: (arg){
                    if(arg == null){
                      return 'Please select area.';
                    }
                },
                hint: Text("Select area", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black), maxLines: 1),
                items: _unit.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: new Text(item,
                      //value ?? "",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
//                  print(value);
                  setState(() {
                    _selectedUnit  = value;
//                    print(_selectedUnit);
                  });
                  
                //getAddressDropdownValue(value);
                },
              ),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: new TextFormField(
            onChanged: (value) => updateButtonState(value),
          decoration: const InputDecoration(
                                labelText: 'Quantity',
                                hintText: '',
                                // prefixIcon: Icon(Icons.account_circle),
                                ),
            keyboardType: TextInputType.number,
            
            // textCapitalization: TextCapitalization.sentences,
            controller: quantityCtrl,
            validator: (String arg) {
              if(arg.length == 0){
                return 'Please enter quantity.';
              }else{
                return null;
              }
            
            },
            onSaved: (String val) {
              quantity = val;
            },
            ),
          ),
              _total == null
              ?Container(
                      
              ) 
              :Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          children: <Widget> [
                            Text('Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Rs. ${_total}.00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                           onPressed: itemCheck,
//                          onPressed: (){},
                          padding: EdgeInsets.symmetric(vertical:10.0),
                          color: Colors.blue[300],
                          child: Text('ADD', 
                            style: TextStyle(
                              color: Colors.white, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
          ],
        ),
      ),

          );
    
  }

  // static Future<void> showLoadingDialog(
  // BuildContext context, GlobalKey key) async {
    
  // }
  bool validate() {
    if (_selectedMaterial.isEmpty) {
      _showError('Please select Material.');
      return false;
    } else if (_selectedUnit.isEmpty) {
      _showError('Please select unit.');
      return false;
    } else if (quantityCtrl.text.isEmpty) {
      _showError('Please enter quantity.');
      return false;
    } else {
      return true;
    }
  }

  updateButtonState(String value){
    setState(() {
      _selectedUnit;
      _selectedMaterial;
      var n = int.parse(value);
      if(_selectedMaterial == '1'){
        _total = n*100;
        _amount = _total.toString();
      }
      else if(_selectedMaterial == '2'){
        // var n = int.parse(value);
        _total = n*200;
        _amount = _total.toString();
      }
    });
  }

  itemCheck() async{
    if (validate()) {
        Map<String, String> body = {
          Constants.PARAM_USER_ID: "2",
          Constants.PARAM_MATERIAL: _selectedMaterial,
          Constants.PARAM_UNIT: _selectedUnit,
          Constants.PARAM_QUANTITY: quantityCtrl.text,
          Constants.PARAM_REQUEST_ID: "1",
          Constants.PARAM_RATE_ID: "2",
          Constants.PARAM_AMOUNT: _amount,
        };
      BlocProvider.of<RequestDetailsBloc>(context).add(UpdateRequestDetails(body: body));
    }
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}