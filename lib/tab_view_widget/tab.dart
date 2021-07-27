import 'package:flutter/material.dart';

class SamplePage extends StatefulWidget {
  SamplePage({Key key}) : super(key: key);

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> with TickerProviderStateMixin {
  TabController _tabController;
  var tabData = ['tab1', 'tab2'];

  @override
  void initState() {
    _tabController = TabController(length: tabData.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// some widget above tab header
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Text(
              'Header',
              style: TextStyle(
                fontFamily: "Raleway",
              ),
            ),
          ),

          /// tab header
          TabBar(
            controller: _tabController,
            tabs: [
              ...tabData.map(
                (item) => Tab(
                  child: Text(item),
                ),
              ),
            ],
          ),

          /// tab content
          TabBarView(
            controller: _tabController,
            children: <Widget>[
              tabContent('tab1', 50),
              tabContent('tab2', 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget tabContent(String title, int length) {
    return Column(
      children: [
        ...List.generate(
          length,
          (index) => ListTile(
            title: Text(
              '${title} item ${index}',
              style: TextStyle(
                fontFamily: "Raleway",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
