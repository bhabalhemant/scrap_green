import 'package:flutter/material.dart';
import 'package:dana/utils/singleton.dart';
import 'package:dana/utils/constants.dart' as Constants;

class SelectLanguage extends StatefulWidget {
  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<String> items = <String>['English', 'Marathi', 'Hindi'];
  String selectedItem = 'English';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: buildSelectLanguageScreen(),
      ),
    );
  }
  
  Widget buildSelectLanguageScreen() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          SizedBox(
              height: AppSingleton.instance.getHeight(100),
            ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Center(
              child: Image.asset(
                'assets/scrap_green_logo.png',
                scale: 2.0,
              ),
            ),
          ),
          SizedBox(
              height: AppSingleton.instance.getHeight(100),
            ),
          Text(
            'Choose Language',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
            SizedBox(
              height: AppSingleton.instance.getHeight(20),
            ),
          Container(
            width: 100.0,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  // decoration:
                  style: TextStyle(
                    color: Colors.green
                  ),
                  value: selectedItem,
                  onChanged: (String string) => setState(() => selectedItem = string),
                  selectedItemBuilder: (BuildContext context) {
                    return items.map<Widget>((String item) {
                      return Text(item);
                    }).toList();
                  },
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          
          SizedBox(
              height: AppSingleton.instance.getHeight(100),
            ),
          Center(
            child:RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                  onPressed: () {  
                    Navigator.pushNamed(context, Constants.ROUTE_CAROUSEL_DEMO);
                  },
                  color: Colors.green,
                  textColor: Colors.black,
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
          )
        ],
      ),
      
      );   
  }
}