import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/profile.dart';
import 'package:brain_store/localization/language_constants.dart';
import 'package:brain_store/settings/paymenthistory.dart';
import 'package:brain_store/settings/privacypolicy.dart';
import 'package:brain_store/settings/support.dart';
import 'package:brain_store/settings/termsandconfitionspage.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';

import '../main.dart';

class Languages extends StatefulWidget {
  @override
  _LanguagesState createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  String _selectedLang;

  void _changeLanguage(String language) async {
    MyApp.setLocale(context, Locale('${language}'));
    this.setState(() {
      _selectedLang = language;
    });
  }

  List languages = [
    {"lang": "Deutsch", "code": "de"},
    {"lang": "English", "code": "en"},
    {"lang": "Espanol", "code": "es"},
    {"lang": "Francias", "code": "fr"},
    {"lang": "Portugues", "code": "pt"},
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Locale lang = Localizations.localeOf(context);
    _selectedLang = lang.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          getTranslated(context, 'language'),
          style: TextStyle(
            fontFamily: "Raleway",
            // fontFamily: 'Abril Fatface',
            color: Colors.black,
            fontSize: 28.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(),
            child: Container(
              height: 5,
              color: Color(0xFF1A3A77),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(getTranslated(context, 'chooseLanguage'),
              style: TextStyle(
                fontFamily: "Raleway",
                fontSize: 20,
              )),
          Container(
            child: Column(
                children: languages
                    .map((e) => ListTile(
                          onTap: () {
                            return _changeLanguage(e['code']);
                          },
                          title: Text(
                            e['lang'],
                            style: TextStyle(
                              fontFamily: "Raleway",
                            ),
                          ),
                          trailing: _selectedLang == e['code']
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Container(
                                  width: 1,
                                ),
                        ))
                    .toList()),
          ),
        ],
      ),
    );
  }
}
