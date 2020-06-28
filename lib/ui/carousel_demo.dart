import 'package:carousel_slider/carousel_slider.dart';
import 'package:dana/models/slider.dart';
import 'package:flutter/material.dart';
import 'package:dana/utils/constants.dart' as Constants;

class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  String icons;
  String header;
  String description;
  int _current = 0;
  int _max = 3;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<SliderItem> imgList = [
    SliderItem('pad.png', 'SIGN UP', 'Sign up with Scrap Green and you are ready to sell your scrap without any hassel. Sit at home and sell your scrap',
        '#STAYHOME #STAYSAFE 1'),
    SliderItem('pad.png', 'SIGN IN', 'Sign up with Scrap Green and you are ready to sell your scrap without any hassel. Sit at home and sell your scrap',
        '#STAYHOME #STAYSAFE 2'),
    SliderItem('pad.png', 'SIGN UP', 'Sign up with Scrap Green and you are ready to sell your scrap without any hassel. Sit at home and sell your scrap',
        '#STAYHOME #STAYSAFE 3'),
    SliderItem('pad.png', 'SIGN IN', 'Sign up with Scrap Green and you are ready to sell your scrap without any hassel. Sit at home and sell your scrap',
        '#STAYHOME #STAYSAFE 4')
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
                  child: Image.asset('assets/${item.logoPath}', width: 120, height: 120),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(item.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 18.0),
                  child: Text(item.description,
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
                  child: Text(item.subtitle,
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
                      }
                      else{
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
                  height: MediaQuery.of(context).size.height),
                  
              carouselController: _controller,
            ),
          ),
        ));
  }
}
