import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:nice_button/NiceButton.dart';

class CradDetials extends StatefulWidget {
  CradDetials({Key key}) : super(key: key);

  @override
  _CradDetialsState createState() => _CradDetialsState();
}

class _CradDetialsState extends State<CradDetials> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              height: size.height * 0.3,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NiceButton(
                    width: size.width * 0.3,
                    radius: 10,
                    padding: const EdgeInsets.all(8),
                    text: "send",
                    gradientColors: [Color(0xff5b86e5), Color(0xff36d1dc)],
                    onPressed: () {},
                    background: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
