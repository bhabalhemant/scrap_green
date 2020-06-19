import 'package:scrap_green/bloc/otp/otp_bloc.dart';
import 'package:scrap_green/bloc/sign_in_bloc.dart';
import 'package:scrap_green/bloc/sign_up_bloc.dart';
import 'package:scrap_green/bloc/sign_up_vendor_bloc.dart';
import 'package:scrap_green/bloc/splash_bloc.dart';
import 'package:scrap_green/ui/otp_screen.dart';
import 'package:scrap_green/ui/profile_screen.dart';
import 'package:scrap_green/ui/rate_card.dart';
import 'package:scrap_green/ui/select_type_screen.dart';
import 'package:scrap_green/ui/sign_in_screen.dart';
import 'package:scrap_green/ui/sign_up_screen.dart';
import 'package:scrap_green/ui/home.dart';
import 'package:scrap_green/ui/splash_screen.dart';
import 'package:scrap_green/ui/sign_up_vendor.dart';
import 'package:scrap_green/ui/pick_up_request.dart';
import 'package:scrap_green/ui/mycontribution.dart';
import 'package:scrap_green/ui/history.dart';
import 'package:scrap_green/ui/vendor_request.dart';

import 'package:scrap_green/utils/constants.dart' as Constants;
import 'package:scrap_green/utils/custom_route.dart';
import 'package:scrap_green/utils/simple_bloc_delegate.dart';
import 'package:scrap_green/utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/profile/profile_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<OtpBloc>(
          create: (context) => OtpBloc(),
        ),
        BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider<SignUpVendorBloc>(
          create: (context) => SignUpVendorBloc(),
        ),
        BlocProvider<SplashBloc>(
          create: (context) => SplashBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scrap Green',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: AppSingleton.instance.createMaterialColor(
          AppSingleton.instance.getPrimaryColor(),
        ),
      ),
      initialRoute: Constants.ROUTE_ROOT,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case Constants.ROUTE_ROOT:
            return CustomRoute(
              builder: (_) => SplashScreen(),
              settings: settings,
            );
          case Constants.ROUTE_SPLASH:
            return CustomRoute(
              builder: (_) => SplashScreen(),
              settings: settings,
            );
          case Constants.ROUTE_SIGN_IN:
            return CustomRoute(
              builder: (_) => SignInScreen(),
              settings: settings,
            );
          case Constants.ROUTE_HOME:
            return CustomRoute(
              builder: (_) => Home(),
              settings: settings,
            );
          case Constants.ROUTE_PICKUP_REQUEST:
            return CustomRoute(
              builder: (_) => PickUpRequest(),
              settings: settings,
            );
          case Constants.ROUTE_VENDOR_REQUEST:
            return CustomRoute(
              builder: (_) => VendorRequest(),
              settings: settings,
            );
          case Constants.ROUTE_REQUEST_DETAILS:
            return CustomRoute(
              builder: (_) => RequestDetails(),
              settings: settings,
            );
          case Constants.ROUTE_MY_CONTRIBUTION:
            return CustomRoute(
              builder: (_) => MyContribution(),
              settings: settings,
            );
          case Constants.ROUTE_SIGN_UP:
            return CustomRoute(
              builder: (_) => SignUpScreen(),
              settings: settings,
            );
          case Constants.ROUTE_SIGN_UP_VENDOR:
            return CustomRoute(
              builder: (_) => SignUpVendor(),
              settings: settings,
            );
          case Constants.ROUTE_PROFILE:
            return CustomRoute(
              builder: (_) => ProfileScreen(),
              settings: settings,
            );
          case Constants.ROUTE_OTP:
            return CustomRoute(
              builder: (_) => OtpScreen(),
              settings: settings,
            );
          case Constants.ROUTE_SELECT_TYPE:
            return CustomRoute(
              builder: (_) => SelectTypeScreen(),
              settings: settings,
            );
          case Constants.ROUTE_HISTORY:
            return CustomRoute(
              builder: (_) => History(),
              settings: settings,
            );
          case Constants.ROUTE_RATE_CARD:
            return CustomRoute(
              builder: (_) => RateCard(),
              settings: settings,
            );
          case Constants.ROUTE_CAROUSEL_DEMO:
            return CustomRoute(
              builder: (_) => CarouselDemo(),
              settings: settings,
            );
          default:
            return CustomRoute(
              builder: (_) => SignInScreen(),
              settings: settings,
            );
        }
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => SignInScreen(),
        );
      },
    );
  }
}
