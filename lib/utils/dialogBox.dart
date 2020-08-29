import 'package:flutter/material.dart';


final List<String> _material = [
    "Iron",
    "Copper",
  ];
final List<String> _unit = [
    "KG"
    // "Copper",
  ];
  int _total;
  String quantity;
  TextEditingController quantityCtrl = TextEditingController(text: '0');
  class DialogBox extends StatefulWidget {
  @override
  DialogBoxState createState() => DialogBoxState();
}
class DialogBoxState extends State<DialogBox>  {
  String _selectedUnit;
String _selectedMaterial;
  
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
                items: _material.map((item) {
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
                  print(value);
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
                  print(value);
                  setState(() {
                    _selectedUnit  = value;
                    print(_selectedUnit);
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
                          // onPressed: loginCheck,
                          onPressed: (){},
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
  updateButtonState(String value){
    
    setState(() {
      _selectedUnit;
      _selectedMaterial;
      var n = int.parse(value);
      if(_selectedMaterial == 'Iron'){
        _total = n*100;
      }
      else if(_selectedMaterial == 'Copper'){
        // var n = int.parse(value);
        _total = n*200;
      }
    });
    
  }
  // static Future<void> showLoadingDialog(
  // BuildContext context, GlobalKey key) async {
    
  // }
  
  checkValidation(value){

  }
}