import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrapgreen/bloc/rate_card/rate_card_bloc.dart';
import 'package:scrapgreen/bloc/rate_card/rate_card_event.dart';
import 'package:scrapgreen/bloc/rate_card/rate_card_state.dart';
import 'package:scrapgreen/bloc/request_details/request_details_bloc.dart';
import 'package:scrapgreen/bloc/request_details/request_details_event.dart';
import 'package:scrapgreen/models/addItem.dart';
import 'package:scrapgreen/models/material.dart';
import 'package:scrapgreen/models/response/rate_card_response.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/singleton.dart';

List<Data> _data = List();
bool _isLoading = false;
bool _hasMoreItems = true;
bool _throwShotAway = false;
final List<String> _material = [
  "Iron",
  "Copper",
];
final List<MaterialItem> materialList = [
  MaterialItem('1', 'IRON'),
  MaterialItem('2', 'COPPER'),
];
final List<String> _unit = ["KG"];

final List<AddItem> itemList = [];
double _total;
String quantity;
String rate;
//  TextEditingController quantityCtrl = TextEditingController();
//  TextEditingController unitCtrl = TextEditingController();

class DialogBox extends StatefulWidget {
  final String requestDetailsId;
  final String vendorId;

  const DialogBox({Key key, this.requestDetailsId, this.vendorId})
      : super(key: key);

  @override
  DialogBoxState createState() => DialogBoxState();
}

class DialogBoxState extends State<DialogBox> {
  String _selectedUnit;
  String _selectedMaterial;
  String _amount;
  String _item_id;
  TextEditingController _unit, _quantity, _m_price;

  @override
  void dispose() {
    _unit.dispose();
    _quantity.dispose();
    _m_price.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _unit = TextEditingController();
    _quantity = TextEditingController();
    _m_price = TextEditingController();
    _quantity.clear();
    _data.clear();
    _total = 0.00;
    BlocProvider.of<RateCardBloc>(context).add(GetRateCard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer(
                bloc: BlocProvider.of<RateCardBloc>(context),
                listener: (context, state) {
                  if (state is RateCardLoaded) {
                    _isLoading = false;
                    if (state.response.data.isEmpty) {
                      _hasMoreItems = false;
                    }
                    _data.addAll(state.response.data);
                  }
                },
                builder: (context, state) {
                  if (state is RateCardLoading) {
                    return AppSingleton.instance.buildCenterSizedProgressBar();
                  }
                  if (state is RateCardError) {
                    return Center(
                      child: Text(state.msg),
                    );
                  }
                  if (state is RateCardLoaded) {
                    return dialogScreen();
                  }
                  return dialogScreen();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dialogScreen() {
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
              child: DropdownButtonFormField(
                value: _selectedMaterial,
                isExpanded: true,
                //decoration: InputDecoration(contentPadding: const EdgeInsets.fromLTRB(10.0, 0.5, 0.0, 0.5),(borderRadius: BorderRadius.circular(5.0),)),
                hint: Text("Select Material",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                    maxLines: 1),
                items: _data.map((item) {
                  return DropdownMenuItem(
                    value: item.id,
                    child: new Text(
                      item.material,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  _item_id = value;
                  itemUnit(_item_id);
                  setState(() {
                    _selectedMaterial = value;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: new TextFormField(
                onChanged: (value) => updateButtonState(),
                decoration: const InputDecoration(
                  labelText: 'Unit',
                ),
                enabled: false,
//                keyboardType: TextInputType.number,
                controller: _unit,
                validator: (String arg) {
                  if (arg.length == 0) {
                    return 'Please enter Unit.';
                  } else {
                    return null;
                  }
                },
                onSaved: (String val) {
                  quantity = val;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: new TextFormField(
                onChanged: (value) => updateButtonState(),
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  hintText: '',
                ),
                keyboardType: TextInputType.number,
                controller: _quantity,
                validator: (String arg) {
                  if (arg.length == 0) {
                    return 'Please enter quantity.';
                  } else {
                    return null;
                  }
                },
                onSaved: (String val) {
                  quantity = val;
                },
              ),
            ),
            AppSingleton.instance.getSpacer(),
                Row(
                  children: <Widget>[
                    Checkbox(
                      checkColor: Colors.green,
                      activeColor: Colors.white,
                      value: _throwShotAway,
                      onChanged: (bool newValue) {
                        setState(() {
                          _throwShotAway = newValue;
                          print(_throwShotAway);
                        });
                      },
                    ),
                    Text(
                      'Enter Price manually',
                      style: TextStyle(
                        fontSize: 12,
                        
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                _throwShotAway == true
                ? Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: new TextFormField(
                    onChanged: (value) => updateButtonState(),
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                    enabled: true,
                  keyboardType: TextInputType.number,
                  controller: _m_price,
                  validator: (String arg) {
                    if (arg.length == 0) {
                      return 'Please enter Price.';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String val) {
                    quantity = val;
                  },
              ),
            )
            : _amount == null
                ? Container()
                : Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rs. ${_amount}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24.0),
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
//                  onPressed: itemCheck,
                  onPressed: () {
                    if (validate()) {
                      Map<String, String> body = {
                        Constants.PARAM_VENDOR_ID: widget.vendorId,
                        Constants.PARAM_MATERIAL: _selectedMaterial,
                        Constants.PARAM_UNIT: _unit.text,
                        Constants.PARAM_QUANTITY: _quantity.text,
                        Constants.PARAM_REQUEST_ID: widget.requestDetailsId,
                        Constants.PARAM_RATE_ID: rate,
                        Constants.PARAM_AMOUNT: _amount,
                      };
                    //  print(body);
                      BlocProvider.of<RequestDetailsBloc>(context)
                          .add(UpdateRequestDetails(body: body));
                    }
                    Navigator.pop(context);
                    Navigator.pushNamed(
                        context, Constants.ROUTE_REQUEST_DETAILS);
                  },
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  color: Colors.blue[300],
                  child: Text(
                    'ADD',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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

  itemUnit(value) {

    _data.map((item) {
//      print(value +'='+ item.id);
      if (value == item.id) {
        setState(() {
          _unit.text = item.unit;
        });
      }
    }).toList();
  }

  updateButtonState() {

    _data.map((item) {
//      print(item.rate);
      if (_item_id == item.id) {
        var n = int.parse(_quantity.text);
        assert(n is int);
        var r = double.parse(item.rate);
        assert(r is double);
        setState(() {
          rate = item.rate.toString();
          _unit.text = item.unit;
          _total = n * r;
          if(_m_price.text.isEmpty){
            _amount = _total.toString();
          } else {
            _amount = _m_price.text;
          }
        });
      }
    }).toList();
  }

  bool validate() {
    if (_selectedMaterial.isEmpty) {
      _showError('Please select Material.');
      return false;
    } else if (_unit.text.isEmpty) {
      _showError('Please select unit.');
      return false;
    } else if (_quantity.text.isEmpty) {
      _showError('Please enter quantity.');
      return false;
    } else {
      return true;
    }
  }

//  updateButtonState(){
//    print(_item_id);
//  }

  itemCheck() async {
    if (validate()) {
      Map<String, String> body = {
        Constants.PARAM_VENDOR_ID: widget.vendorId,
        Constants.PARAM_MATERIAL: _selectedMaterial,
        Constants.PARAM_UNIT: _unit.text,
        Constants.PARAM_QUANTITY: _quantity.text,
        Constants.PARAM_REQUEST_ID: widget.requestDetailsId,
        Constants.PARAM_RATE_ID: rate,
        Constants.PARAM_AMOUNT: _amount,
      };
//        print(body);
//      Navigator.pop(context)
      BlocProvider.of<RequestDetailsBloc>(context)
          .add(UpdateRequestDetails(body: body));
    }
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }

  void _showSuccessMessage(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getSuccessSnackBar(message));
  }
}
