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
int _total;
String quantity;
//  TextEditingController quantityCtrl = TextEditingController();
//  TextEditingController unitCtrl = TextEditingController();

class DialogBox extends StatefulWidget {
  final String requestDetailsId;
  final String vendorId;

  const DialogBox({Key key, this.requestDetailsId,this.vendorId}) : super(key: key);

  @override
  DialogBoxState createState() => DialogBoxState();
}

class DialogBoxState extends State<DialogBox> {
  String _selectedUnit;
  String _selectedMaterial;
  String _amount;
  String _item_id;
  TextEditingController _unit, _quantity;

  @override
  void dispose() {
    _unit.dispose();
    _quantity.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _unit = TextEditingController();
    _quantity = TextEditingController();
//    quantityCtrl.clear();
    _total = 0;
    BlocProvider.of<RateCardBloc>(context).add(GetRateCard());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Expanded(
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
                validator: (arg) {
                  if (arg == null) {
                    return 'Please select Material.';
                  }
                },
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
//                  print(value.unit);
                  _item_id = value;
                  itemUnit(value);
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
            _total == null
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
                            'Rs. ${_total}',
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
                  onPressed: itemCheck,
//                          onPressed: (){},
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
      if (value == item.id) {
//        print(_quantity.text);
        setState(() {
          _unit.text = item.unit;
        });
      }
    }).toList();
  }

  updateButtonState() {
//    print(_item_id);
    _data.map((item) {
      if (_item_id == item.id) {
        var n = int.parse(_quantity.text);
        var r = int.parse(item.rate);
//        print(_quantity.text);
        setState(() {
          _unit.text = item.unit;
          _total = n * r;
          _amount = _total.toString();
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
        Constants.PARAM_RATE_ID: _item_id,
        Constants.PARAM_AMOUNT: _amount,
      };
//        print(body);
      BlocProvider.of<RequestDetailsBloc>(context)
          .add(UpdateRequestDetails(body: body));
    }
  }

  void _showError(String message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState
        .showSnackBar(AppSingleton.instance.getErrorSnackBar(message));
  }
}
