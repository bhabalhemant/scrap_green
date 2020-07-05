// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

    static const Map<String,dynamic> mr_IN = {
  "sign_up": "साइन अप करा",
  "sign_up_desc": "स्क्रॅप ग्रीन सह साइन अप करा आणि आपण कोणतीही भांडण न घेता आपला स्क्रॅप विक्री करण्यास तयार आहात. घरी बसून आपली भंगार विक्री करा.",
  "sign_in": "साइन इन करा",
  "stay_home": "#घरीरहा",
  "create_your_account": "आपले खाते तयार करा",
  "forgot_password": "संकेतशब्द विसरलात?"
};
  static const Map<String,dynamic> en_US = {
  "sign_up": "SIGN UP",
  "sign_up_desc": "Sign up with Scrap Green and you are ready to sell your scrap without any hassle. Sit at home and sell your scrap",
  "sign_in": "SIGN IN",
  "stay_home": "#STAYHOME",
  "create_your_account": "Create your account",
  "forgot_password": "Forgot Password?"
};
  static const Map<String,dynamic> hi_IN = {
  "sign_up": "साइन अप करें",
  "sign_up_desc": "स्क्रैप ग्रीन के साथ साइन अप करें और आप बिना किसी परेशानी के अपना स्क्रैप बेचने के लिए तैयार हैं। घर बैठो और अपना स्क्रैप बेचो",
  "sign_in": "साइन इन करें",
  "stay_home": "#घरपररहना",
  "create_your_account": "अपना खाता बनाएँ",
  "forgot_password": "पासवर्ड भूल गए?"
};
  static const Map<String, Map<String,dynamic>> mapLocales = {"mr_IN": mr_IN, "en_US": en_US, "hi_IN": hi_IN};
}
