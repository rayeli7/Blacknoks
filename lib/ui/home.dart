import 'package:blacknoks/api(s)/fetch_api.dart';
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
  late Future<LiveStockData> futureLiveStockData;

//  final List<Widget> tabs = [
//    PortfolioSection(),
//    MarketsSection(),
//    SearchSection(),
//  ];
@override
  void initState() {
    super.initState();
    futureLiveStockData = fetchLiveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        height: MediaQuery.of(context).size.height / 14,

        ),
      backgroundColor: Colors.white,
      body: Center(
          child: FutureBuilder<LiveStockData>(
            future: futureLiveStockData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
          ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: GNav(
            activeColor: Colors.grey,
            iconSize: 24,
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
        iconColor: Colors.white,
        text: 'Home',
      ),
      const GButton(
        icon: FontAwesomeIcons.search,
        iconColor: Colors.white,
        text: 'Search',
      ),
    ];
  }
  }
