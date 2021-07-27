import 'package:brain_store/Splash_screen/splash/pages/SplashScreen.dart';
import 'package:brain_store/package_screen1.dart';
import 'package:brain_store/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
// import 'package:simple_splashscreen/simple_splashscreen.dart';
import 'BottomNavigationbar/BottomNatigation_page.dart';
import 'Loginandregister/screens/confirm_email.dart';
import 'Splash_screen/intropages.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './localization/demo_localization.dart';

import 'localization/language_constants.dart';

// import './square/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(
    debug: true
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;
  setLocale(Locale locale) {
    setState(() {
      this.locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this.locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: AuthServices().user),
      ],
      child: MaterialApp(
        title: "Comrade",
        debugShowCheckedModeBanner: false,
        locale: locale,
        supportedLocales: [
          Locale("en"),
          Locale("de"),
          Locale("es"),
          Locale("fr"),
          Locale("pt")
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        // home: PackageScreen()
        home: Root(),
      ),
    );
  }
}

class Root extends StatelessWidget {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if(user == null){
      return SplashPage();
    }
    if(user != null && user.emailVerified){
      return BottomNavigationPage();
    }
    if(user != null && !user.emailVerified){
      return ConfirmEmail();
    }
  }
}

//
// class Splash extends StatefulWidget {
//   @override
//   _SplashState createState() => _SplashState();
// }
//
// class _SplashState extends State<Splash> {
//   @override
//   Widget build(BuildContext context) {
//     return Simple_splashscreen(
//       context: context,
//       gotoWidget: SplashPage(),
//       splashscreenWidget: SplashScreen(),
//       timerInSeconds: 5,
//     );
//   }
// }
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Container(
//           child: Stack(
//             children: [
//               Image.asset(
//                 "assets/images/logocomrade.png",
//                 fit: BoxFit.cover,
//               ),
//               // Positioned(
//               //   left: 70,
//               //   child: Text(
//               //     "Comrade",
//               //     style: TextStyle(
//               //       fontFamily: "Dancing Script",
//               //       color: Colors.pink,
//               //       fontSize: 40,
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
