import 'package:carousel_slider/carousel_slider.dart';
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

   _CarouselDemoState({this.icons, this.header, this.description});
   final CarouselController _controller = CarouselController();
    @override
    void initState() {
      super.initState();
    }
  test(){

   }

  @override
  Widget build(BuildContext context) {
    
     List<_CarouselDemoState> list_header = [
      _CarouselDemoState(icons: "pad.png", header: "SIGN UP", description: "Sign up with Scrap Green and you are ready to sell your scrap without any hassel. Sit at home and sell your scrap"),
      _CarouselDemoState(icons: "pad.png", header: "SIGN IN", description: "Sign up with Scrap Green and you are ready to sell your scrap without any hassel. Sit at home and sell your scrap"),
      _CarouselDemoState(icons: "pad.png", header: "SIGN UP", description: "Sign up with Scrap Green and you are ready to sell your scrap without any hassel. Sit at home and sell your scrap"),
      _CarouselDemoState(icons: "pad.png", header: "SIGN IN", description: "Sign up with Scrap Green and you are ready to sell your scrap without any hassel. Sit at home and sell your scrap"),
    ];

    return Scaffold(
      body: Container(
        color: Colors.green,
        child: CarouselSlider(
          options: CarouselOptions(
            height: 900.0,
            autoPlay: true,
            carouselController: _controller,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }
          ),
          items: list_header.map((currentObject) => Container(
            width: 240,
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 250.0),
                    // child: Text('assets/'+currentObject.icons),
                    child: Image.asset('assets/'+currentObject.icons,
                      height: 150.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text(currentObject.header,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text(currentObject.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('#stayhome #staysafe',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: list_header.map((currentObject) {
                      int index = list_header.indexOf(currentObject);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                            ? Color.fromRGBO(237, 93, 22, 1)
                            : Color.fromRGBO( 255, 255, 255, 1),
                        ),
                      );
                    }).toList(),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 10.0),
                  // ),
                  Divider(
                    color: Colors.white,
                    thickness: 1.0,
                  ),
                  // Flexible(
                  //   child: RaisedButton(
                  //     onPressed: () => _controller.nextPage(),
                  //     child: Text('→'),
                  //   ),
                  // ),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => _controller.nextPage(),
                      color: Colors.white,
                      textColor: Colors.black,
                      child: Text(
                        "Next",
                        // style: AppTextStyle.regular(
                        //     Colors.white, 10.0,
                        //     ),
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // color: Colors.green,
          )).toList(),
        )
      ),
    );
  }
}