import 'package:scrap_green/base_widgets/app_textstyle.dart';
import 'package:scrap_green/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  onTap() {
    if (scaffoldKey.currentContext != null) {
      Navigator.of(scaffoldKey.currentContext).pop(true);
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return AppSingleton.instance.goBack(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppSingleton.instance.buildAppBar(onTap, 'History'),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      height: AppSingleton.instance.getHeight(50),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(50.0),
                              ),
                            ),
                            filled: true,
                            hintStyle:
                                AppTextStyle.regular(Colors.black38, 15.0),
                            hintText: "Search",
                            fillColor: Colors.white70),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Card(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    // leading: Icon(Icons.album),
                                    leading: Image.asset('assets/recycle.png',
                                        width: 62,
                                        height: 62,
                                        fit: BoxFit.contain),
                                    title: Text('Order No: REC007'),
                                    // subtitle: Text(
                                        // '19.05.2020 12:29PM \nGhatkopar-West,400084.'),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('19.05.2020 12:29PM',
                                              textAlign: TextAlign.left,
                                              // style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Text('Ghatkopar-West,400084.',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                    isThreeLine: true,
                                    trailing: Column(
                                      children: <Widget>[
                                        // Icon(Icons.flight),
                                        Text('Rs. 2500.00'),
                                        Expanded(
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              side: BorderSide(
                                                color: AppSingleton.instance
                                                    .getPrimaryColor(),
                                              ),
                                            ),
                                            onPressed: () {},
                                            color: AppSingleton.instance
                                                .getPrimaryColor(),
                                            textColor: Colors.white,
                                            child: Text(
                                              "Scheduled",
                                              style: AppTextStyle.regular(
                                                  Colors.white, 10.0,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
