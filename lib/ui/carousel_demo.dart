import 'package:carousel_slider/carousel_slider.dart';
import 'package:scrapgreen/generated/locale_keys.g.dart';
import 'package:scrapgreen/models/slider.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  String icons;
  String header;
  String description;
  int _current = 0;
  int _max = 2;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<SliderItem> imgList = [
    SliderItem('pad.png', LocaleKeys.sign_up.tr(), LocaleKeys.sign_up_desc.tr(),
        '${LocaleKeys.stay_home.tr()} 1'),
    SliderItem('pad.png', LocaleKeys.sign_in.tr(), LocaleKeys.sign_up_desc.tr(),
        '${LocaleKeys.stay_home.tr()} 2'),
    SliderItem('pad.png', LocaleKeys.sign_in.tr(), LocaleKeys.sign_up_desc.tr(),
        '${LocaleKeys.stay_home.tr()} 3'),
  ];

  final CarouselController _controller = CarouselController();

  List<Widget> imageSliders;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageSliders = imgList.map((SliderItem item) {
      return Container(
          color: Colors.green,
          // width: double.infinity,
          // height: double.infinity,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
                  child: Image.asset('assets/${item.logoPath}',
                      width: 120, height: 120),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                  child: Text(
                    item.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.map((currentObject) {
                    int index = imgList.indexOf(currentObject);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color.fromRGBO(237, 93, 22, 1)
                            : Color.fromRGBO(255, 255, 255, 1),
                      ),
                    );
                  }).toList(),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_current < _max) {
                        _current += 1;
                        _controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear);
                      } else {
                        Navigator.pushNamed(context, Constants.ROUTE_SIGN_IN);
                      }
                    });
                  },
                  color: Colors.white,
                  textColor: Colors.black,
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ));
    }).toList();
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: Colors.green,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: false,
                carouselController: _controller,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                height: MediaQuery.of(context).size.height),
            carouselController: _controller,
          ),
        ),
      ),
    );
  }
}
