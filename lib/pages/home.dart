import 'package:blacknoks/pages/markets.dart';
import 'package:blacknoks/pages/user_portfoliopage.dart';
import 'package:blacknoks/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomeState();
}

class _HomeState extends State<Homepage> {
  int _selectedIndex = 0;

  @override
  initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: IndexedStack(
        children: <Widget>[
          GSEMarketsPage(),
          UserPortfolioPage(),
        ],
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'StockList',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Portfolio',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
