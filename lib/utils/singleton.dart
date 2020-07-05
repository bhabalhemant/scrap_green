import 'dart:math';

import 'package:scrapgreen/base_widgets/app_textstyle.dart';
import 'package:scrapgreen/base_widgets/gradient_appbar.dart';
import 'package:scrapgreen/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSingleton {
  AppSingleton._privateConstructor();

  static final AppSingleton instance = AppSingleton._privateConstructor();

  getPrimaryColor() {
    return HexColor('#56c125');
  }

  getSecondaryColor() {
    return HexColor('#85cf03');
  }

  getDarkBlueColor() {
    return HexColor('#2E3D4D');
  }

  getCardDarkGray() {
    return HexColor('#eeecee');
  }
  getLightGrayColor() {
    return Colors.grey[200];
  }

  dynamic getHeight(double height) {
    if (ScreenUtil.getInstance() != null) {
      return ScreenUtil.getInstance().setHeight(height);
    } else {
      return height;
    }
  }

  dynamic getWidth(double width) {
    if (ScreenUtil.getInstance() != null) {
      return ScreenUtil.getInstance().setWidth(width);
    } else {
      return width;
    }
  }

  dynamic getSp(double size) {
    if (ScreenUtil.getInstance() != null) {
      return ScreenUtil.getInstance().setSp(size);
    } else {
      return size;
    }
  }

  Widget getSpacer() {
    return SizedBox(
      height: getHeight(15),
    );
  }

  Widget getHorizontalSpacer() {
    return SizedBox(
      height: getWidth(10),
    );
  }
  Widget getSizedSpacer(double size) {
    return SizedBox(
      height: getHeight(size),
    );
  }

  Widget getErrorSnackBar(String message) {
    return SnackBar(
      duration: Duration(seconds: 1),
      content: Center(
        heightFactor: 1.0,
        child: Text(
          '' + message,
          style: AppTextStyle.regular(Colors.white, 15.0),
        ),
      ),
      backgroundColor: Colors.red,
    );
  }

  Widget getSuccessSnackBar(String message) {
    return SnackBar(
      duration: Duration(seconds: 1),
      content: Center(
        heightFactor: 1.0,
        child: Text(
          message,
          style: AppTextStyle.regular(Colors.white, 15.0),
        ),
      ),
      backgroundColor: Colors.green,
    );
  }

  Future<bool> exitAppDialog(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure'),
            content: Text('Do you want to exit an App?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<bool> goBack(BuildContext context) async {
    Navigator.of(context).pop(true);
    return false;
  }

  dynamic generateRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  Widget getBlankContainer() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  OutlineInputBorder getLightGrayOutLineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      borderSide: BorderSide(
        color: getLightGrayColor(),
      ),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  GradientAppBar buildAppBar(Function onTap, String title) {
    return GradientAppBar(
      leading: GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.chevron_left,
          color: Colors.black,
          size: getSp(30),
        ),
      ),
      gradient: LinearGradient(
        colors: [Colors.green, Colors.green],
      ),
      title: Text(
        title,
        style: AppTextStyle.bold(
          Colors.black,
          getSp(18),
        ),
      ),
    );
  }

  Widget buildCenterSizedProgressBar() {
    return Center(
      child: SizedBox(
        height: getHeight(30),
        width: getWidth(30),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            getPrimaryColor(),
          ),
        ),
      ),
    );
  }

  void hideKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
  }
}
