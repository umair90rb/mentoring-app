import 'package:flutter/material.dart';

import 'models/package.dart';

class CustomPackage extends StatefulWidget {
  @override
  _CustomPackageState createState() => _CustomPackageState();
}

class _CustomPackageState extends State<CustomPackage> {
  int talkTime = 0;
  int amount = 0;
  List category = [
    {'cat': 'Legal', 'price': 2, 'value': false},
    {'cat': 'Education and Profession', 'price': 2, 'value': false},
    {'cat': 'Entrepreneurship', 'price': 2, 'value': false},
    {'cat': 'Investment', 'price': 2, 'value': false},
    {'cat': 'Health & Nutrition', 'price': 2, 'value': false},
    {'cat': 'Relationships', 'price': 1, 'value': false},
    {'cat': 'Vent out', 'price': 1, 'value': false},
    {'cat': 'Travel', 'price': 1, 'value': false},
    {'cat': 'Beauty', 'price': 1, 'value': false},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Select',
          style: TextStyle(fontFamily: "Raleway", color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      persistentFooterButtons: [
        Text(
          'Amount:',
          style: TextStyle(
            fontFamily: "Raleway",
          ),
        ),
        Chip(
            backgroundColor: Colors.orange,
            label: Text(
              "\$${amount.toString()}",
              style: TextStyle(
                fontFamily: "Raleway",
                color: Colors.white,
              ),
            )),
        Text(
          'Talk Time: ',
          style: TextStyle(
            fontFamily: "Raleway",
          ),
        ),
        Chip(
            backgroundColor: Colors.orange,
            label: Text(
              "${talkTime.toString()} mins",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Raleway",
              ),
            )),
        SizedBox(
          width: 10,
        )
      ],
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        label: Text(
          'Done',
          style: TextStyle(
            fontFamily: "Raleway",
          ),
        ),
        onPressed: () {
          return Navigator.pop(
              context, Package(amount: amount, talkTime: talkTime));
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: category
                .map(
                  (e) => ListTile(
                    leading: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.orange,
                      value: e['value'],
                      onChanged: (checked) {
                        int index = category.indexOf(e);
                        if (checked) {
                          this.setState(() {
                            talkTime += 20;
                            amount += e['price'] * 20;
                            category[index]['value'] =
                                !category[index]['value'];
                          });
                        } else {
                          this.setState(() {
                            talkTime -= 20;
                            amount -= e['price'] * 20;
                            category[index]['value'] =
                                !category[index]['value'];
                          });
                        }
                      },
                    ),
                    title: Text(e['cat']),
                    trailing: Chip(
                        label: Text(
                          "\$${e['price']}",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                          ),
                        ),
                        backgroundColor: Colors.orange),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
