import 'package:flutter/material.dart';
final List<String> _bloodValues = [
    "",
    "A+",
    "B+",
    "AB+",
    "O+",
    "A-",
    "B-",
    "AB-",
    "O-",
  ];
class Dialogs {
  String bLOODGRPselected;
  
  static Future<void> showLoadingDialog(
  BuildContext context, GlobalKey key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => true,
          child: SimpleDialog(
            key: key,
            // backgroundColor: Colors.green,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.green,
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                            child: Text("Add Item",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.add_circle,
                              size: 38.0,
                              color: Colors.white,
                              ),
                              tooltip: 'Add items',
                              // onPressed: () {
                                
                              // },
                              onPressed: null,
                            ),
                          )
                        ],
                      )
                      // child: Center(child: Text("Container Top")),
                    ),
                    Container(
                      color: Colors.white,
                      child:Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: DropdownButtonFormField (
                          // value: _selectedArea,
                          isExpanded: true,
                          //decoration: InputDecoration(contentPadding: const EdgeInsets.fromLTRB(10.0, 0.5, 0.0, 0.5),(borderRadius: BorderRadius.circular(5.0),)),
                          validator: (arg){
                              if(arg == null){
                                return 'Please select area.';
                              }
                          },
                          
                          hint: Text("Select material", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black), maxLines: 1),
                          items: _bloodValues.map((item) {
                          return DropdownMenuItem<String>(
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
                            // setState(() {
                            //   _selectedArea  = value;
                            //   print(_selectedArea);
                            // });

                          //getAddressDropdownValue(value);
                          },
                        ),
                        ),
                    ),
                    Container(
                      color: Colors.white,
                      child:Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: DropdownButtonFormField (
                          // value: _selectedArea,
                          isExpanded: true,
                          //decoration: InputDecoration(contentPadding: const EdgeInsets.fromLTRB(10.0, 0.5, 0.0, 0.5),(borderRadius: BorderRadius.circular(5.0),)),
                          validator: (arg){
                              if(arg == null){
                                return 'Please select area.';
                              }
                          },
                          hint: Text("Select unit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black), maxLines: 1),
                          items: _bloodValues.map((item) {
                          return DropdownMenuItem<String>(
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
                            // setState(() {
                            //   _selectedArea  = value;
                            //   print(_selectedArea);
                            // });

                          //getAddressDropdownValue(value);
                          },
                        ),
                        ),
                    ),
                    Container(
                      child:Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),
                        child: TextFormField(
                        autofocus: false,

                            validator: (String arg) {
                              if (arg.length == 0) {
                                return 'Required Field Password';
                              }else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                            hintText: 'Enter Quantity',
                            fillColor: Colors.grey,
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            // errorText: _autoValidate ? 'Value Can\'t Be Empty' : null,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: <Widget> [
                            Text('Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Rs. 0.00',
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
                        padding: EdgeInsets.symmetric(vertical: 0.0),
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
            ],
          ),
        );
      }
    );
  }
}