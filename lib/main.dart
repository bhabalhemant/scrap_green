import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:scrapgreen/ui/sign_in_vendor_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scrapgreen/bloc/forgot_password_bloc.dart';
import 'package:scrapgreen/bloc/otp/otp_bloc.dart';
import 'package:scrapgreen/bloc/sign_in_bloc.dart';
import 'package:scrapgreen/bloc/sign_in_vendor_bloc.dart';
import 'package:scrapgreen/bloc/sign_up_bloc.dart';
import 'package:scrapgreen/bloc/sign_up_vendor_bloc.dart';
import 'package:scrapgreen/bloc/splash_bloc.dart';
import 'package:scrapgreen/bloc/profile_page/profile_bloc.dart';
import 'package:scrapgreen/bloc/settings/profile_bloc.dart';
import 'package:scrapgreen/bloc/change_password/cp_bloc.dart';
import 'package:scrapgreen/bloc/contact_us_bloc.dart';
import 'package:scrapgreen/bloc/rate_card/rate_card_bloc.dart';
import 'package:scrapgreen/generated/codegen_loader.g.dart';
import 'package:scrapgreen/ui/carousel_demo.dart';
import 'package:scrapgreen/ui/forgot_password_screen.dart';
import 'package:scrapgreen/ui/history.dart';
import 'package:scrapgreen/ui/home.dart';
import 'package:scrapgreen/ui/lang_view.dart';
import 'package:scrapgreen/ui/mycontribution.dart';
import 'package:scrapgreen/ui/otp_screen.dart';
import 'package:scrapgreen/ui/pick_up_request.dart';
import 'package:scrapgreen/ui/profile_screen.dart';
import 'package:scrapgreen/ui/rate_card.dart';
import 'package:scrapgreen/ui/request_details.dart';
import 'package:scrapgreen/ui/select_type_screen.dart';
import 'package:scrapgreen/ui/sign_in_screen.dart';
import 'package:scrapgreen/ui/sign_up_screen.dart';
import 'package:scrapgreen/ui/sign_up_vendor.dart';
import 'package:scrapgreen/ui/splash_screen.dart';
import 'package:scrapgreen/ui/vendor_request.dart';
import 'package:scrapgreen/ui/settings.dart';
import 'package:scrapgreen/ui/profile_1.dart';
import 'package:scrapgreen/ui/edit_profile.dart';
import 'package:scrapgreen/ui/change_password.dart';
import 'package:scrapgreen/ui/contact_us.dart';
import 'package:scrapgreen/utils/constants.dart' as Constants;
import 'package:scrapgreen/utils/custom_route.dart';
import 'package:scrapgreen/utils/simple_bloc_delegate.dart';
import 'package:scrapgreen/utils/singleton.dart';
import 'bloc/history_bloc.dart';
import 'bloc/profile/profile_bloc.dart';
import 'models/local_notification.dart';
import 'package:location/location.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

NotificationAppLaunchDetails notificationAppLaunchDetails;

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid =
  AndroidInitializationSettings('logo');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        debugPrint('notification payload: ' + payload);
      });

  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
      });

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('mr', 'IN'),
        Locale('hi', 'IN')
      ],
      path: 'assets/translations/',
      assetLoader: CodegenLoader(),
      child: MultiBlocProvider(
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
          BlocProvider<SignInVendorBloc>(
            create: (context) => SignInVendorBloc(),
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
          BlocProvider<HistoryBloc>(
            create: (context) => HistoryBloc(),
          ),
          BlocProvider<ForgotPasswordBloc>(
            create: (context) => ForgotPasswordBloc(),
          ),
          BlocProvider<ProfilePageBloc>(
            create: (context) => ProfilePageBloc(),
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(),
          ),
          BlocProvider<ChangePasswordBloc>(
            create: (context) => ChangePasswordBloc(),
          ),
          BlocProvider<ContactUsBloc>(
            create: (context) => ContactUsBloc(),
          ),
          BlocProvider<RateCardBloc>(
            create: (context) => RateCardBloc(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }

  onError(dynamic o) {
    if (o is String) {
      debugPrint("@@@@@@MESSAGE2 $o");
    } else {
      debugPrint("@@@@@@MESSAGE2 $o");
    }
  }


  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        LocalNotification localNotification = LocalNotification(
            message['notification']["title"],
            message['notification']["body"],
            "");
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'DANAID', 'DANA', 'DANA NOTIFICATIONS',
            importance: Importance.Max,
            priority: Priority.High,
            ticker: 'ticker');
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(DateTime.now().millisecond,
            localNotification.title, localNotification.body, platformChannelSpecifics,
            payload: localNotification.title);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      print("Firebase token: $token");
      assert(token != null);
      BlocProvider.of<SplashBloc>(context).add(SplashEvent(fcmId: token));
    });
    geoloator();
  }

  geoloator() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Scrap Green',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: AppSingleton.instance.createMaterialColor(
          AppSingleton.instance.getPrimaryColor(),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
          case Constants.ROUTE_SIGN_IN_VENDOR:
            return CustomRoute(
              builder: (_) => SignInVendorScreen(),
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
          case Constants.ROUTE_SETTING:
            return CustomRoute(
              builder: (_) => Settings(),
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
          case Constants.ROUTE_SELECT_LANGUAGE:
            return CustomRoute(
              builder: (_) => LanguageView(),
              settings: settings,
            );
          case Constants.ROUTE_FORGOT_PASSWORD:
            return CustomRoute(
              builder: (_) => ForgotPassWordScreen(),
              settings: settings,
            );
          case Constants.ROUTE_PROFILE_PAGE:
            return CustomRoute(
              builder: (_) => ProfilePage(),
              settings: settings,
            );
          case Constants.ROUTE_EDIT_PROFILE:
            return CustomRoute(
              builder: (_) => EditProfile(),
              settings: settings,
            );
          case Constants.ROUTE_CHANGE_PASSWORD:
            return CustomRoute(
              builder: (_) => ChangePassword(),
              settings: settings,
            );
          case Constants.ROUTE_CONTACT_US:
            return CustomRoute(
              builder: (_) => ContactUs(),
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