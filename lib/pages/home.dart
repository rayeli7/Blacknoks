import 'dart:convert';

import 'package:blacknoks/models/livestockdata_model.dart';
import 'package:blacknoks/pages/markets.dart';
import 'package:blacknoks/pages/user_portfoliopage.dart';
import 'package:blacknoks/services/api(s)/fetch_api.dart';
import 'package:blacknoks/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomeState();
}

class _HomeState extends State<Homepage> {
  List<LiveStockData> livestockdata = <LiveStockData>[];
  int _selectedIndex = 0;
  late bool _isLoading;
  late PageController _pageController;

  _getLiveStockData() {
    API.getLiveStockData().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        livestockdata =
            list.map((model) => LiveStockData.fromJson(model)).toList();
      });
    });
  }

  @override
  initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _isLoading = true;
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _getLiveStockData()(_isLoading = false);
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _pages = [
      GSEMarketsPage(
        livestockdata: livestockdata,
        isLoading: _isLoading,
      ),
      UserPortfolioPage(livestockdata: livestockdata),
    ];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const SizedBox(
            child: Image(
              height: 55,
              image: AssetImage("assets/images/blacknocks_logo_black.png"),
              fit: BoxFit.contain,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout_rounded),
              tooltip: 'Show Snackbar',
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
          ]),
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        //The following parameter is just to prevent
        //the user from swiping to the next page.
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.kayaking),
            label: 'Stocks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_rounded),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
