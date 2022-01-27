import 'package:blacknoks/pages/markets.dart';
import 'package:blacknoks/pages/user_portfoliopage.dart';
import 'package:flutter/material.dart';

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

  final _pages = [
    const GSEMarketsPage(),
    const UserPortfolioPage(),
  ];
          
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Center(
          child: Image(
          image: AssetImage("assets/images/Vector.png")
          ),
        ),
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
      height: MediaQuery.of(context).size.height,
        ),
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],       
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
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




