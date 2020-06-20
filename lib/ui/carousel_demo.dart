import 'package:carousel_slider/carousel_slider.dart';
import 'package:dana/models/slider.dart';
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
    SliderItem('pad.png', 'SIGN', 'Sign up long text test test test test',
        '#STAYHOME #STAYSAFE 1'),
    SliderItem('pad.png', 'SIGN', 'Sign up long text test test test test',
        '#STAYHOME #STAYSAFE 2'),
    SliderItem('pad.png', 'SIGN', 'Sign up long text test test test test',
        '#STAYHOME #STAYSAFE 3')
  ];

  _CarouselDemoState({this.icons, this.header, this.description});

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
          color: Colors.lightGreen,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.asset('assets/${item.logoPath}', width: 28, height: 28),
                Text(item.subtitle),
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
          color: Colors.lightGreen,
          width: double.infinity,
          height: double.infinity,
          child: Center(
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
                  height: MediaQuery.of(context).size.height / 3),
              carouselController: _controller,
            ),
          ),
        ));
  }
}
