import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:blacknoks/api(s)/fetch_api.dart';
import 'package:blacknoks/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomeState();
}

class _HomeState extends State<Homepage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    var livestockdata = <LiveStockData>[];

  _getLiveStockData() {
    API.getLiveStockData().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        livestockdata = list.map((model) => LiveStockData.fromJson(model)).toList();
      });
    });
  }

  @override
  initState() {
    super.initState();
    _getLiveStockData();
  }

  @override
  dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Home'),
                actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
                ]
      ), 
      drawer: Container(
        height: MediaQuery.of(context).size.height / 14,

        ),
      backgroundColor: Colors.white,
      body: 
          ListView.builder(
              itemCount: livestockdata.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (){} ,

                  title: Text(livestockdata[index].name!),

                  subtitle: Text(
                    GSE_Companies[index],
                    style:const TextStyle(
                      color: Colors.blueAccent
                    ),
                    ),

                  trailing:Text(
                    livestockdata[index].price!.toString(),
                    style: const TextStyle(
                    color: Colors.redAccent),
                    ),

                  );
                 },
                 ),
       
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: GNav(
            activeColor: Colors.black,
            iconSize:30 ,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            selectedIndex: _selectedIndex,
            tabs: _bottomNavigationBarItemItems(),
            onTabChange: _onItemTapped
          ),
        ),
      )
    );
  }

  List<GButton> _bottomNavigationBarItemItems() {
    return [
      const GButton(
        icon: FontAwesomeIcons.home,
        iconColor: Colors.grey,
        text: 'Home',
      ),
      const GButton(
        icon: FontAwesomeIcons.search,
        iconColor: Colors.grey,
        text: 'Search',
      ),
    ];
  }
  }
