import 'package:brain_store/BottomNavigationbar/BottomNatigation_page.dart';
import 'package:brain_store/Loginandregister/screens/confirm_email.dart';
import 'package:brain_store/Loginandregister/screens/login-screen.dart';
import 'package:brain_store/Splash_screen/splash/items/item_splash_pageview.dart';
import 'package:brain_store/Splash_screen/splash/style.dart';
import 'package:brain_store/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthServices auth = AuthServices();
  int _currentPage = 0;
  PageController _controller = PageController();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD3E7D9),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                // child: Image.asset(
                // 'assets/images/bg.png',
                // fit: BoxFit.cover,
                // ),
              ),
              Column(
                children: [
                  Expanded(
                    flex: 70,
                    child: PageView(
                      onPageChanged: (pageIndex) {
                        setState(() {
                          currentPageIndex = pageIndex;
                          print('current page index $currentPageIndex');
                        });
                      },
                      children: [
                        ItemSplashPageView(
                          title: 'Reach your goals',
                          description:
                              'With guidance and support\neveryday from your mentors you\ncan reach your goals effortlessly.',
                          img_path: 'assets/images/clock.png',
                        ),
                        ItemSplashPageView(
                          title: 'Get Started',
                          description:
                              "At Comrade, we promise you\nwon't be called names or judged\nby your choices,race and religion.",
                          img_path: 'assets/images/nojudgementzone.png',
                        ),
                        ItemSplashPageView(
                          title: 'We are here to hear you',
                          description:
                              "Comrade's are available for\nyou round the clock\nAll day everyday.",
                          img_path: 'assets/images/clock.png',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 7,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: FractionallySizedBox(
                          heightFactor: 0.15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 33,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 4),
                                  child: AspectRatio(
                                    aspectRatio:
                                        currentPageIndex != 0 ? 1 / 1 : 3 / 1,
                                    child: Card(
                                      elevation: 0,
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: currentPageIndex != 0
                                                  ? [
                                                      AppTheme
                                                          .gradient1_disabled,
                                                      AppTheme
                                                          .gradient2_disabled,
                                                    ]
                                                  : [
                                                      AppTheme.gradient1,
                                                      AppTheme.gradient2,
                                                    ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 33,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 4),
                                  child: AspectRatio(
                                    aspectRatio:
                                        currentPageIndex != 1 ? 1 / 1 : 3 / 1,
                                    child: Card(
                                      elevation: 0,
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: currentPageIndex != 1
                                                  ? [
                                                      AppTheme
                                                          .gradient1_disabled,
                                                      AppTheme
                                                          .gradient2_disabled,
                                                    ]
                                                  : [
                                                      AppTheme.gradient1,
                                                      AppTheme.gradient2,
                                                    ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 33,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 4),
                                  child: AspectRatio(
                                    aspectRatio:
                                        currentPageIndex != 2 ? 1 / 1 : 3 / 1,
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 0,
                                      margin: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: currentPageIndex != 2
                                                  ? [
                                                      AppTheme
                                                          .gradient1_disabled,
                                                      AppTheme
                                                          .gradient2_disabled,
                                                    ]
                                                  : [
                                                      AppTheme.gradient1,
                                                      AppTheme.gradient2,
                                                    ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 5,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 15,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 50,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                heightFactor: 1,
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 5,
                                  shadowColor: AppTheme.gradient2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                AppTheme.gradient1,
                                                AppTheme.gradient2,
                                              ]),
                                        ),
                                        child: Text(
                                          'Get Started',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Raleway",
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              User user = auth.getUser;
                                              print(user);
                                              if (user != null) {
                                                user.emailVerified
                                                    ? Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BottomNavigationPage()))
                                                    : Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ConfirmEmail()));
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: Container(
                              alignment: Alignment(0.0, 0.5),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  'I have an account',
                                  style: TextStyle(
                                    color: Color(0xFF41504C),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Raleway",
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
